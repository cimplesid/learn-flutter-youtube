package youtube.sidtube.drawoverotherapps

import `in`.jvapps.system_alert_window.SystemAlertWindowPlugin
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        SystemAlertWindowPlugin.setPluginRegistrant(this)
    }

   override fun registerWith(registry: PluginRegistry) {
      SystemAlertWindowPlugin.registerWith(registry.registrarFor("in.jvapps.system_alert_window"));
   }
}