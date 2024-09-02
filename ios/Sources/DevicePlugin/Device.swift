import Foundation

@objc public class Device: NSObject {
    @objc public func makeApiCall(completion: @escaping (Bool, String?) -> Void) {
        // Logging the start of the API call
        print("Starting API call to https://api.yourservice.com/endpoint")
        
        guard let url = URL(string: "https://capacitor-auto-update.onrender.com/status") else {
            print("Invalid URL")
            completion(false, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        
        // Logging request details
        print("Request: \(request)")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Logging response or error
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(false, "Request failed with error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(false, "No data received")
                return
            }

            do {
                // Logging received data
                print("Received data: \(String(describing: String(data: data, encoding: .utf8)))")
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = json["status"] as? Bool {
                    
                    print("Parsed JSON: \(json)")
                    print("Status: \(status)")
                    
                    if status {
                        print("Status is true, crashing the app.")
                        fatalError("Crashing the app because status is true")
                    } else {
                        print("Status is false, doing nothing.")
                        completion(true, "Status is false, doing nothing")
                    }
                } else {
                    print("Unexpected response format")
                    completion(false, "Unexpected response format")
                }
            } catch {
                print("Failed to parse JSON: \(error.localizedDescription)")
                completion(false, "Failed to parse JSON: \(error.localizedDescription)")
            }
        }

        // Logging the start of the data task
        print("Starting the data task")
        task.resume()
    }
}
