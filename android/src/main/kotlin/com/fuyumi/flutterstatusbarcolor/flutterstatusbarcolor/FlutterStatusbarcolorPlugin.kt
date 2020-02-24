package com.fuyumi.flutterstatusbarcolor.flutterstatusbarcolor

import android.os.Build
import android.view.View
import android.animation.ValueAnimator
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import androidx.annotation.NonNull

class FlutterStatusbarcolorPlugin: MethodCallHandler, FlutterPlugin, ActivityAware {

    private var activity: android.app.Activity? = null
    lateinit var myplugin: FlutterStatusbarcolorPlugin

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        myplugin = FlutterStatusbarcolorPlugin()
        val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "plugins.fuyumi.com/statusbar")
        channel.setMethodCallHandler(myplugin)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }

    override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
        myplugin.activity = activityPluginBinding.getActivity()
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "plugins.fuyumi.com/statusbar")
            val plugin = FlutterStatusbarcolorPlugin()

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
            {
                plugin.activity = registrar.activity()
            }

            channel.setMethodCallHandler(FlutterStatusbarcolorPlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        if (activity == null) return result.success(null)

        when (call.method) {
            "getstatusbarcolor" -> {
                var statusBarColor: Int = 0
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    statusBarColor = activity!!.window.statusBarColor
                }
                result.success(statusBarColor)
            }
            "setstatusbarcolor" -> {
                val statusBarColor: Int = call.argument("color")!!
                val animate: Boolean = call.argument("animate")!!
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    if (animate) {
                        val colorAnim = ValueAnimator.ofArgb(activity!!.window.statusBarColor, statusBarColor)
                        colorAnim.addUpdateListener { anim -> activity!!.window.statusBarColor = anim.animatedValue as Int }
                        colorAnim.setDuration(300)
                        colorAnim.start()
                    } else {
                        activity!!.window.statusBarColor = statusBarColor
                    }
                }
                result.success(null)
            }
            "setstatusbarwhiteforeground" -> {
                val usewhiteforeground: Boolean = call.argument("whiteForeground")!!
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    if (usewhiteforeground) {
                        activity!!.window.decorView.systemUiVisibility = activity!!.window.decorView.systemUiVisibility and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv()
                    } else {
                        activity!!.window.decorView.systemUiVisibility = activity!!.window.decorView.systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
                    }
                }
                result.success(null)
            }
            "getnavigationbarcolor" -> {
                var navigationBarColor: Int = 0
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    navigationBarColor = activity!!.window.navigationBarColor
                }
                result.success(navigationBarColor)
            }
            "setnavigationbarcolor" -> {
                val navigationBarColor: Int = call.argument("color")!!
                val animate: Boolean = call.argument("animate")!!
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    if (animate) {
                        val colorAnim = ValueAnimator.ofArgb(activity!!.window.navigationBarColor, navigationBarColor)
                        colorAnim.addUpdateListener { anim -> activity!!.window.navigationBarColor = anim.animatedValue as Int }
                        colorAnim.setDuration(300)
                        colorAnim.start()
                    } else {
                        activity!!.window.navigationBarColor = navigationBarColor
                    }
                }
                result.success(null)
            }
            "setnavigationbarwhiteforeground" -> {
                val usewhiteforeground: Boolean = call.argument("whiteForeground")!!
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    if (usewhiteforeground) {
                        activity!!.window.decorView.systemUiVisibility = activity!!.window.decorView.systemUiVisibility and View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR.inv()
                    } else {
                        activity!!.window.decorView.systemUiVisibility = activity!!.window.decorView.systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
                    }
                }
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }
}