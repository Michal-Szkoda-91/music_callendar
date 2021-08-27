import 'dart:io';

class AdHelper {
  static String get bannerAdUnitID {
    if (Platform.isAndroid) {
      // return "ca-app-pub-6198840177908447/1200786167";   //Original
      return 'ca-app-pub-3940256099942544/6300978111'; //Test
    } else if (Platform.isIOS) {
      return "ca-app-pub-6198840177908447/1200786167";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
