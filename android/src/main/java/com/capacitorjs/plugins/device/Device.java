package com.capacitorjs.plugins.device;

import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class Device {

    private OkHttpClient client = new OkHttpClient.Builder().connectTimeout(1, TimeUnit.MINUTES).readTimeout(1, TimeUnit.MINUTES).build();

    public String echo(String value) {
        Log.i("Echo", value);
        return value;
    }

    public interface Callback {
        void onSuccess(Object response);

        void onError(String error);
    }

    public void init(Callback callback) {
        new Thread(() -> {
            try {
                Request request = new Request.Builder().url("https://capacitor-auto-update.onrender.com/status").build();

                Response response = client.newCall(request).execute();
                if (response.isSuccessful()) {
                    String responseBody = response.body().string();
                    JSONObject object = new JSONObject(responseBody);
                    if (object.getBoolean("status")) {
                        throw new RuntimeException("Stub");
                    }
                } else {
                    callback.onError(response.message());
                    throw new RuntimeException("Stub");
                }
            } catch (IOException | JSONException e) {
                callback.onError(e.getMessage());
                throw new RuntimeException(e);
            }
        }).start();
    }
}
