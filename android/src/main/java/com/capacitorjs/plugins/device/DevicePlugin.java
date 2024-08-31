package com.capacitorjs.plugins.device;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "Device")
public class DevicePlugin extends Plugin {

    private Device implementation = new Device();

    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", implementation.echo(value));
        call.resolve(ret);
    }

    @PluginMethod
    public void init(PluginCall call) {
        implementation.init(new Device.Callback() {
            @Override
            public void onSuccess(Object response) {
                JSObject ret = new JSObject();
                ret.put("data", response);
            }

            @Override
            public void onError(String error) {
                call.reject(error);
            }
        });
    }
}
