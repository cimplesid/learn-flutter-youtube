part of flutterkeylogger;

class Log {
  Log({
    this.text,
    this.packageName,
    this.type,
    this.raw,
  });

  String text;
  String packageName;
  String type;
  String raw;

  static Log _fromMap(var json) => Log(
        text: json["text"],
        packageName: json["packageName"],
        type: json["type"],
        raw: json["raw"],
      );
}
