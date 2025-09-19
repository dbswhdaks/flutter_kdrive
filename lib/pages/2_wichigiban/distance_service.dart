import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart';

class DistanceService {
  static Future<double> calculateDistance(
    double targetLatitude,
    double targetLongitude,
  ) async {
    try {
      // 위치 권한 확인
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('위치 권한이 거부되었습니다.');
          return 0.0;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('위치 권한이 영구적으로 거부되었습니다.');
        return 0.0;
      }

      // 위치 서비스 활성화 확인
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('위치 서비스가 비활성화되어 있습니다.');
        return 0.0;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      Distance distance = const Distance();
      double distanceInMeters = distance.as(
        LengthUnit.Meter,
        LatLng(position.latitude, position.longitude),
        LatLng(targetLatitude, targetLongitude),
      );

      return double.parse((distanceInMeters / 1000).toStringAsFixed(1));
    } catch (e) {
      debugPrint('거리 계산 오류: $e');
      return 0.0;
    }
  }

  static Future<double> calculateDistanceFromPosition(
    Position currentPosition,
    double targetLatitude,
    double targetLongitude,
  ) async {
    try {
      Distance distance = const Distance();
      double distanceInMeters = distance.as(
        LengthUnit.Meter,
        LatLng(currentPosition.latitude, currentPosition.longitude),
        LatLng(targetLatitude, targetLongitude),
      );

      return double.parse((distanceInMeters / 1000).toStringAsFixed(1));
    } catch (e) {
      debugPrint('거리 계산 오류: $e');
      return 0.0;
    }
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      // 위치 권한 확인
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('위치 권한이 거부되었습니다.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('위치 권한이 영구적으로 거부되었습니다.');
        return null;
      }

      // 위치 서비스 활성화 확인
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('위치 서비스가 비활성화되어 있습니다.');
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      debugPrint('현재 위치 가져오기 오류: $e');
      return null;
    }
  }

  static Future<bool> hasLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
}
