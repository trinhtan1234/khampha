import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    final PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      return Future.error('Location permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings(); // Open app settings for the user to grant permission manually
      return Future.error('Location permission permanently denied');
    }

    final LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permission denied');
    } else if (permission == LocationPermission.deniedForever) {
      openAppSettings(); // Open app settings for the user to grant permission manually
      return Future.error('Location permission permanently denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
