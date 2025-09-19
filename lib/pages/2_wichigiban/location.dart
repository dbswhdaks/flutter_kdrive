import 'package:kdrive/main.dart';
import 'package:kdrive/models/academy_model.dart';
import 'package:kdrive/models/hospital_model.dart';
import 'package:kdrive/models/license_model.dart';

/// 학원추천목록 가져오기
Future<List<AcademyModel>> getAcademySuggestionList() async {
  var result = await supabase
      .from('academy_suggestion')
      .select()
      .order('id', ascending: false);

  List<AcademyModel> academySuggestionList =
      result.map((e) => AcademyModel.fromMap(e)).toList();

  return academySuggestionList;
}

/// 학원목록 가져오기
Future<List<AcademyModel>> getAcademyList() async {
  var result =
      await supabase.from('academy').select().order('id', ascending: false);

  List<AcademyModel> academyList =
      result.map((e) => AcademyModel.fromMap(e)).toList();

  return academyList;
}

/// 병원목록 가져오기
Future<List<HospitalModel>> getHospitalList() async {
  var result =
      await supabase.from('hospital').select().order('id', ascending: false);

  List<HospitalModel> hospitalList =
      result.map((e) => HospitalModel.fromMap(e)).toList();

  return hospitalList;
}

/// 면허시험장목록 가져오기
Future<List<LicenseModel>> getLicenseList() async {
  var result =
      await supabase.from('license').select().order('id', ascending: false);

  List<LicenseModel> licenseList =
      result.map((e) => LicenseModel.fromMap(e)).toList();

  return licenseList;
}
