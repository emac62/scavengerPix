import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1618980018345182/2936625698';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1618980018345182/8688162745';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1618980018345182/7099748907";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1618980018345182/4585266201";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
// test ad units