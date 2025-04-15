import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geolocator/geolocator.dart';
import 'package:store_app/Models/store.dart';

class DistanceService {
  Future<Position> getUserLocation() async {
    print("im here");
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    print("here");

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }
    print("heree");

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    print("im here");

    return await Geolocator.getCurrentPosition();
  }

  Future<double> getDistanceToStore(
    Store store, {
    String unit = "meters",
  }) async {
    final user = await getUserLocation();
    print("im here");
    return FlutterMapMath().distanceBetween(
      user.latitude,
      user.longitude,
      store.latitude,
      store.longitude,
      unit,
    );
  }
}
