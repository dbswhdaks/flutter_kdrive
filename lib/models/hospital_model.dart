import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class HospitalModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final double latitude;
  final double longitude;
  double? distance; // 현재 위치로부터의 거리 (km)

  HospitalModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.distance,
  });

  // 현재 위치로부터의 거리 계산
  double calculateDistance(Position currentPosition) {
    final distance = Distance();
    return distance.as(
      LengthUnit.Kilometer,
      LatLng(currentPosition.latitude, currentPosition.longitude),
      LatLng(latitude, longitude),
    );
  }

  // 거리 기반 정렬을 위한 비교 메서드
  int compareByDistance(HospitalModel other) {
    if (distance == null || other.distance == null) return 0;
    return distance!.compareTo(other.distance!);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "phone": phone,
      "address": address,
      "Latitude": latitude,
      "Longitude": longitude,
      "distance": distance,
    };
  }

  factory HospitalModel.fromMap(Map<String, dynamic> map) {
    return HospitalModel(
      id: map["id"]?.toInt(),
      name: map["name"],
      phone: map["phone"],
      address: map["address"],
      latitude:
          map["Latitude"]?.toDouble() ?? map["Latitude"]?.toDouble() ?? 0.0,
      longitude:
          map["Longitude"]?.toDouble() ?? map["Longitude"]?.toDouble() ?? 0.0,
      distance: map["distance"]?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HospitalModel.fromJson(String source) =>
      HospitalModel.fromMap(json.decode(source));
}
