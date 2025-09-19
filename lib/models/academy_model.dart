import 'dart:convert';

class AcademyModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final double latitude;
  final double longitude;
  final String? homepage;
  final String type;
  final String? image;
  final String? kakao;
  final String? naver;
  double? distance; // 현재 위치로부터의 거리 (km)

  AcademyModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.homepage,
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
      "homepage": homepage,
      "type": type,
      "image": image,
      "kakao": kakao,
      "naver": naver,
      "distance": distance,
    };
  }

  factory AcademyModel.fromMap(Map<String, dynamic> map) {
    return AcademyModel(
      id: map["id"]?.toInt() ?? 0,
      name: map["name"]?.toString() ?? '',
      phone: map["phone"]?.toString() ?? '',
      address: map["address"]?.toString() ?? '',
      latitude: (map["Latitude"] ?? map["latitude"])?.toDouble() ?? 0.0,
      longitude: (map["Longitude"] ?? map["longitude"])?.toDouble() ?? 0.0,
      homepage: map["homepage"]?.toString(),
      type: map["type"]?.toString() ?? '',
      image: map["image"]?.toString(),
      kakao: map["kakao"]?.toString(),
      naver: map["naver"]?.toString(),
      distance: map["distance"]?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AcademyModel.fromJson(String source) =>
      AcademyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AcademyModel(id: $id, name: $name, phone: $phone, address: $address, latitude: $latitude, longitude: $longitude, homepage: $homepage, type: $type, image: $image, kakao: $kakao, naver: $naver, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AcademyModel &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.homepage == homepage &&
        other.type == type &&
        other.image == image &&
        other.kakao == kakao &&
        other.naver == naver &&
        other.distance == distance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        homepage.hashCode ^
        type.hashCode ^
        image.hashCode ^
        kakao.hashCode ^
        naver.hashCode ^
        distance.hashCode;
  }
}
