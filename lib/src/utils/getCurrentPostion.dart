import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';



Future<bool> checkPositionPermission() async {
  bool serviceEnabled;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    PermissionStatus status = await Permission.location.request();

    if (status != PermissionStatus.granted) {
      return false;
    }

  }
  return serviceEnabled;
}



Future<LatLng?> getCurrentLocation() async  {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    PermissionStatus status = await Permission.location.request();

    if (status != PermissionStatus.granted) {
      return Future.error('Location services are disabled.');
    }

  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  Position? position = await Geolocator.getCurrentPosition(forceAndroidLocationManager: true);

  return wgs84ToGcj02(position.latitude, position.longitude);

}


LatLng wgs84ToGcj02(double latitude, double longitude) {
  double pi = 3.14159265358979324;
  double a = 6378245.0;
  double ee = 0.00669342162296594323;

  double transformLatitude(double x, double y) {
    double pi = 3.14159265358979324;
    double ee = 0.00669342162296594323;
    double a = 6378245.0;
    double dLat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(x.abs());
    dLat += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    dLat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    dLat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return dLat;
  }

  double transformLongitude(double x, double y) {
    double pi = 3.14159265358979324;
    double ee = 0.00669342162296594323;
    double a = 6378245.0;
    double dLon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(x.abs());
    dLon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    dLon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    dLon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return dLon;
  }

  double radLatitude = latitude / 180.0 * pi;
  double magic = sin(radLatitude);
  magic = 1 - ee * magic * magic;
  double sqrtMagic = sqrt(magic);
  double dLatitude = transformLatitude(longitude - 105.0, latitude - 35.0);
  double dLongitude = transformLongitude(longitude - 105.0, latitude - 35.0);
  radLatitude = latitude / 180.0 * pi;
  magic = sin(radLatitude);
  magic = 1 - ee * magic * magic;
  sqrtMagic = sqrt(magic);
  dLatitude = (dLatitude * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
  dLongitude = (dLongitude * 180.0) / (a / sqrtMagic * cos(radLatitude) * pi);
  double gcjLatitude = latitude + dLatitude;
  double gcjLongitude = longitude + dLongitude;
  return LatLng(gcjLatitude, gcjLongitude);
}





