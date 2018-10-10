package com.fuyumi.flutterstatusbarcolor.flutterstatusbarcolor

import android.os.Build
import android.app.Activity
import android.view.View
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
                val statusBarColor: Int = call.argument("color")!!
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    activity.window.statusBarColor = statusBarColor
                }
                result.success(null)
            }
            "setnavigationbarcolor" -> {
                val navigationBarColor: Int = call.argument("color")!!
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    activity.window.navigationBarColor = navigationBarColor
                }
                result.success(null)
            }
            "setstatusbarwhiteforeground" -> {
                val usewhiteforeground: Boolean = call.argument("whiteForeground")!!
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    if (usewhiteforeground) {
                        activity.window.decorView.systemUiVisibility = activity.window.decorView.systemUiVisibility and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv()
                    } else {
                        activity.window.decorView.systemUiVisibility = activity.window.decorView.systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
                    }
                }
                result.success(null)
            }
            "setnavigationbarwhiteforeground" -> {
                val usewhiteforeground: Boolean = call.argument("whiteForeground")!!
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    if (usewhiteforeground) {
                        activity.window.decorView.systemUiVisibility = activity.window.decorView.systemUiVisibility and View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR.inv()
                    } else {
                        activity.window.decorView.systemUiVisibility = activity.window.decorView.systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
                    }
                }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }
}
