import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    if (kDebugMode) {
      print("ChromeSafari browser opened");
    }
  }

  @override
  void onCompletedInitialLoad() {
    if (kDebugMode) {
      print("ChromeSafari browser initial load completed");
    }
  }

  @override
  void onClosed() {
    if (kDebugMode) {
      print("ChromeSafari browser closed");
    }
  }
}
