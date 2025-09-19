import 'dart:convert';

class LicenseModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final double latitude;
  final double longitude;
  final String type;
  final String? image;
  final String? kakao;
  final String? naver;
  double? distance; // 현재 위치로부터의 거리 (km)
  LicenseModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.type,
    this.image,
    this.kakao,
    this.naver,
    this.distance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "phone": phone,
      "address": address,
      "Latitude": latitude,
      "Longitude": longitude,
      "type": type,
      "image": image,
      "kakao": kakao,
      "naver": naver,
      "distance": distance,
    };
  }

  factory LicenseModel.fromMap(Map<String, dynamic> map) {
    return LicenseModel(
      id: map["id"]?.toInt(),
      name: map["name"],
      phone: map["phone"],
      address: map["address"],
      latitude: map["Latitude"]?.toDouble(),
      longitude: map["Longitude"]?.toDouble(),
      type: map["type"],
      image: map["image"],
      kakao: map["kakao"],
      naver: map["naver"],
      distance: map["distance"],
    );
  }

  String toJson() => json.encode(toMap());

  factory LicenseModel.fromJson(String source) =>
      LicenseModel.fromMap(json.decode(source));
}
