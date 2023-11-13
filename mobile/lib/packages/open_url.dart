// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:map_launcher/map_launcher.dart';

class OpenUrl {
  static void openMaps(String lat, String long, String title) async {
    log("${double.parse(lat)} ${double.parse(long)}");
    if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(double.parse(lat), double.parse(long)),
        title: title,
      );
    }
  }

  static openWaze(String lat, String long, String title) async {
    log("${double.parse(lat)} ${double.parse(long)}");
    if (await MapLauncher.isMapAvailable(MapType.waze) ?? false) {
      await MapLauncher.showMarker(
        mapType: MapType.waze,
        coords: Coords(double.parse(lat), double.parse(long)),
        title: title,
      );
    }
  }
}
