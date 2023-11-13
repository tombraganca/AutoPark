// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';

import "package:url_launcher/url_launcher.dart" as url;

class OpenUrl {
  static openMaps(String lat, String long) async {
    var appleMap = "https://maps.apple.com/?ll=$lat,$long&z=10";
    var googleMap =
        "https://www.google.com/maps/dir/?api=1&destination=$lat,$long&zoom=16";
    log(googleMap);
    log(appleMap);
    try {
      if (Platform.isIOS) {
        await url.launchUrl(Uri.parse(appleMap),
            mode: url.LaunchMode.externalApplication);
      } else if (Platform.isAndroid) {
        await url.launchUrl(Uri.parse(googleMap),
            mode: url.LaunchMode.externalApplication);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static openWaze(String lat, String long) async {
    var wazeGoogle = "https://waze.com/ul?ll=$lat,$long&z=10";
    var wazeApple = "https://waze.com/ul?ll=$lat,$long&z=10&navigate=yes";
    log(wazeApple);
    log(wazeGoogle);
    try {
      bool launched = await url.launchUrl(Uri.parse(wazeGoogle),
          mode: url.LaunchMode.externalApplication);
      if (launched) {
        await url.launchUrl(Uri.parse(wazeApple),
            mode: url.LaunchMode.externalApplication);
      } else {
        url.launchUrl(Uri.parse("market://details?id=com.waze"));
      }
    } catch (e) {
      log(e.toString());
      throw 'Could not launch Waze';
    }
  }
}
