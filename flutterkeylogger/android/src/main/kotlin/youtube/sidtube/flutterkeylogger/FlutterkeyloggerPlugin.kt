package youtube.sidtube.flutterkeylogger

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry.Registrar


/** FlutterkeyloggerPlugin */
 class FlutterkeyloggerPlugin : FlutterPlugin {
    lateinit var eventChannel: EventChannel
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setupEvent(flutterPluginBinding.flutterEngine.dartExecutor,flutterPluginBinding.applicationContext)
    }
    fun setupEvent(binaryMessenger: BinaryMessenger,context: Context) {
        eventChannel = EventChannel(binaryMessenger, "keylogger")
        assert(context!=null)
        eventChannel.setStreamHandler(LogReciever(context))
    }
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            FlutterkeyloggerPlugin().setupEvent(registrar.messenger(),registrar.activity())
        }
    }
    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel.setStreamHandler(null);
    }
}
