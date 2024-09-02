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
