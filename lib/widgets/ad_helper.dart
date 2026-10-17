import 'package:flutter/foundation.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'ca-app-pub-1618980018345182/2936625698';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'ca-app-pub-1618980018345182/8688162745';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return "ca-app-pub-1618980018345182/7099748907";
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return "ca-app-pub-1618980018345182/4585266201";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  // test ad units

  static String get testBannerAdUnitID {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get testInterstitialAdUnitId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
