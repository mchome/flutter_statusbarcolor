package com.fuyumi.flutterstatusbarcolor.flutterstatusbarcolor

import android.os.Build;
import android.app.Activity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterStatusbarcolorPlugin private constructor(private val activity: Activity) : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "plugins.fuyumi.com/statusbar")
            channel.setMethodCallHandler(FlutterStatusbarcolorPlugin(registrar.activity()))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        when (call.method) {
            "setstatusbarcolor" -> {
                val statusbarcolor: Int = call.argument("color")
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    activity.window.statusBarColor = statusbarcolor
                }
                result.success(null)
            }
            "setnavigationbarcolor" -> {
                val navigationbarcolor: Int = call.argument("color")
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    activity.window.navigationBarColor = navigationbarcolor
                }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }
}
