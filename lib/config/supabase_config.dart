// ignore_for_file: avoid_print

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Supabase 프로젝트 URL 및 익명 키
  static const String supabaseUrl = 'https://bmynnrryybrzbipdprmh.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJteW5ucnJ5eWJyemJpcGRwcm1oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM2NTIyNTksImV4cCI6MjA0OTIyODI1OX0.t3ci0hD07h0srEobU4NMqU-zXggY63JVJxza55S6leY';

  // Supabase 클라이언트 인스턴스
  static SupabaseClient get client => Supabase.instance.client;

  // Supabase 초기화
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  // hospitals 테이블 구조
  // 테이블 이름: hospitals
  // 컬럼:
  // - id: 정수형 (기본 키)
  // - name: 문자열 (병원 이름)
  // - phone: 문자열 (전화번호)
  // - address: 문자열 (주소)
  // - latitude: 실수형 (위도)
  // - longitude: 실수형 (경도)

  // 병원 데이터 가져오기
  static Future<List<dynamic>> getHospitals() async {
    try {
      final response = await client.from('hospitals').select();
      return response;
    } catch (e) {
      print('Error fetching hospitals: $e');
      return [];
    }
  }
}
