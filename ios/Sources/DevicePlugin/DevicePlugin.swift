import Foundation
import Capacitor

@objc(DevicePlugin)
public class DevicePlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "DevicePlugin"
    public let jsName = "Device"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "initialize", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = Device()

    @objc func initialize(_ call: CAPPluginCall) {
        print("makeApiCall method invoked from JavaScript")
        
        implementation.initialize { success, message in
            if success {
                print("API call successful: \(message ?? "No additional message")")
                call.resolve([
                    "message": message ?? "No additional message"
                ])
            } else {
                print("API call failed: \(message ?? "Unknown error")")
                call.reject(message ?? "Unknown error")
            }
        }
    }
}
