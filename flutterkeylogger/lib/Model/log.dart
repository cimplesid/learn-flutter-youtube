part of flutterkeylogger;

class Log {
  Log(
      {this.text,
      this.packageName,
      this.type,
      this.raw,
      this.eventTime,
      this.logTime});

  /// Text data that event contains default is "[]"
  String text;

  /// Package name of the event in string
  String packageName;

  /// All the POSSIBLE  types to handle are
  /// TYPE_VIEW_CLICKED, TYPE_VIEW_LONG_CLICKED, TYPE_VIEW_SELECTED, TYPE_VIEW_FOCUSED, TYPE_VIEW_TEXT_CHANGED, TYPE_WINDOW_STATE_CHANGED, TYPE_NOTIFICATION_STATE_CHANGED, TYPE_VIEW_HOVER_ENTER, TYPE_VIEW_HOVER_EXIT, TYPE_TOUCH_EXPLORATION_GESTURE_START, TYPE_TOUCH_EXPLORATION_GESTURE_END, TYPE_WINDOW_CONTENT_CHANGED, TYPE_VIEW_SCROLLED, TYPE_VIEW_TEXT_SELECTION_CHANGED, TYPE_ANNOUNCEMENT, TYPE_VIEW_ACCESSIBILITY_FOCUSED, TYPE_VIEW_ACCESSIBILITY_FOCUS_CLEARED, TYPE_VIEW_TEXT_TRAVERSED_AT_MOVEMENT_GRANULARITY, TYPE_GESTURE_DETECTION_START, TYPE_GESTURE_DETECTION_END, TYPE_TOUCH_INTERACTION_START, TYPE_TOUCH_INTERACTION_END, TYPE_WINDOWS_CHANGED, TYPE_VIEW_CONTEXT_CLICKED,  TYPE_ASSIST_READING_CONTEXT
  /// CONTENT_CHANGE_TYPE_UNDEFINED, CONTENT_CHANGE_TYPE_SUBTREE, CONTENT_CHANGE_TYPE_TEXT, CONTENT_CHANGE_TYPE_CONTENT_DESCRIPTION, CONTENT_CHANGE_TYPE_STATE_DESCRIPTION, CONTENT_CHANGE_TYPE_PANE_TITLE, CONTENT_CHANGE_TYPE_PANE_APPEARED CONTENT_CHANGE_TYPE_PANE_DISAPPEARED
  /// WINDOWS_CHANGE_ADDED, WINDOWS_CHANGE_REMOVED, WINDOWS_CHANGE_TITLE, WINDOWS_CHANGE_BOUNDS, WINDOWS_CHANGE_LAYER, WINDOWS_CHANGE_ACTIVE, WINDOWS_CHANGE_FOCUSED, WINDOWS_CHANGE_ACCESSIBILITY_FOCUSED, WINDOWS_CHANGE_PARENT, WINDOWS_CHANGE_CHILDRE, WINDOWS_CHANGE_PIP
  /// for more https://developer.android.com/reference/android/view/accessibility/AccessibilityEvent
  String type;

  /// ALl the original extracted event data in string
  String raw;

  /// eventTime is time provided by [getEventTime()] method and logTime is time in which log is extracted in string
  String eventTime, logTime;

  static Log _fromMap(var json) => Log(
      text: json["text"],
      packageName: json["packageName"],
      type: json["type"],
      raw: json["raw"],
      logTime: DateTime.now().millisecondsSinceEpoch.toString(),
      eventTime: json["time"]);
}
