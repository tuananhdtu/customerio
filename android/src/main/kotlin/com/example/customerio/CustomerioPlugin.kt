package com.example.customerio

import android.app.Activity
import androidx.annotation.NonNull
import io.customer.sdk.CustomerIO
import io.customer.sdk.data.model.Region
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import org.json.JSONTokener

/** CustomerioPlugin */
class CustomerioPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity;

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "customerio")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "initCustomerIO" -> {
                val json = call.arguments
                val jsonObject = JSONTokener(json.toString()).nextValue() as JSONObject
                val builder = CustomerIO.Builder(
                    siteId = jsonObject.getString("siteId"),
                    apiKey = jsonObject.getString("apiKey"),
                    appContext = activity.application
                )
                builder.setRegion(Region.EU)
                builder.build()
                result.success("OK")
            }

            "setIdentifier" -> {
                CustomerIO.instance().identify(call.arguments.toString())
                result.success("OK")
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        print("Not yet implemented")
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        print("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        print("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        print("Not yet implemented")
    }
}
