package youtube.sidtube.flutterkeylogger

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.provider.Settings;
import android.util.Log;

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.PluginRegistry

const val REQUEST_CODE_FOR_ACCESSIBILITY = 167

/** FlutterkeyloggerPlugin */
 class FlutterkeyloggerPlugin : FlutterPlugin, ActivityAware, MethodCallHandler, PluginRegistry.ActivityResultListener {
    lateinit var eventChannel: EventChannel
    lateinit var methodChannel: MethodChannel

    lateinit var context: Context
    lateinit var pendingResult: Result
    lateinit var mActivity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        setupEvent(flutterPluginBinding.flutterEngine.dartExecutor, flutterPluginBinding.applicationContext)
    }

    fun setupEvent(binaryMessenger: BinaryMessenger, context: Context) {
        eventChannel = EventChannel(binaryMessenger, "keylogger/accessibility_event")
        methodChannel = MethodChannel(binaryMessenger, "keylogger/accessibility_channel")
        assert(context!=null)
        eventChannel.setStreamHandler(LogReciever(context))
        methodChannel.setMethodCallHandler(this)
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            FlutterkeyloggerPlugin().setupEvent(registrar.messenger(), registrar.activity())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        pendingResult = result

        if (call.method.equals("isAccessibilityPermissionEnabled")) {
            result.success(Utils.isAccessibilitySettingsOn(context))
        } else if (call.method.equals("requestAccessibilityPermission")) {
            var intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
            mActivity.startActivityForResult(intent, REQUEST_CODE_FOR_ACCESSIBILITY)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == REQUEST_CODE_FOR_ACCESSIBILITY) {
            if (resultCode == Activity.RESULT_OK) {
                pendingResult.success(true)
            } else if (resultCode == Activity.RESULT_CANCELED) {
                pendingResult.success(Utils.isAccessibilitySettingsOn(context));
            } else {
                pendingResult.success(false)
            }
            return true
        }
        return false
    }

    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        this.mActivity = binding.getActivity()
        binding.addActivityResultListener(this)
    }

   override fun onDetachedFromActivityForConfigChanges() {
        //this.mActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

   override fun onDetachedFromActivity() {
        //this.mActivity = null
    }
}
