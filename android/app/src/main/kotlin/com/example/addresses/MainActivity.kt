package com.example.addresses

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.provider.Settings

class MainActivity: FlutterActivity() {
    private val CHANNEL = "device_info"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getIMEI") {
                val imei = getIMEI()
                if (imei != null) {
                    result.success(imei)
                } else {
                    result.error("UNAVAILABLE", "IMEI not available.", null)
                }
            } else if (call.method == "getSerialNumber") {
                result.success("Not available on Android")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getIMEI(): String? {
        return Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
    }
}