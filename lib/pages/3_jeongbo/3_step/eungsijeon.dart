// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, unused_field
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';
import 'package:kdrive/drive_main.dart';
import 'package:kdrive/pages/2_wichigiban/hospital.dart';
import 'package:kdrive/models/hospital_model.dart';
import 'package:kdrive/pages/2_wichigiban/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class Eungsijeon extends StatefulWidget {
  const Eungsijeon({Key? key}) : super(key: key);

  @override
  State<Eungsijeon> createState() => _DriveList3State();
}

class _DriveList3State extends State<Eungsijeon> with TickerProviderStateMixin {
  // 개선된 색상 팔레트
  static const _kPrimaryColor = Color(0xFF2563EB);
  static const _kPrimaryLightColor = Color(0xFF3B82F6);
  static const _kSecondaryColor = Color(0xFF10B981);
  static const _kBackgroundColor = Color(0xFFF8FAFC);
  static const _kCardColor = Color(0xFFFFFFFF);
  static const _kTextPrimaryColor = Color(0xFF1E293B);
  static const _kTextSecondaryColor = Color(0xFF64748B);
  static const _kBorderColor = Color(0xFFE2E8F0);
  static const _kWarningColor = Color(0xFFEF4444);
  static const _kWarningLightColor = Color(0xFFFEF2F2);
  static const _kSuccessColor = Color(0xFF10B981);
  static const _kSuccessLightColor = Color(0xFFF0FDF4);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: _kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 36),
              Text(
                "응시전 교통안전교육",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          bottom: ButtonsTabBar(
            backgroundColor: Colors.amber,
            unselectedBackgroundColor: Colors.grey[100],
            unselectedLabelStyle: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            labelSpacing: 20,
            tabs: const [
              Tab(text: "교통안전교육"),
              Tab(text: "신체검사"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSafetyEducationTab(),
            _buildPhysicalExamTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyEducationTab() {
    return _buildTabContent([
      _buildInfoCard("응시 전 교통안전교육", Icons.school_outlined, _kPrimaryColor),
      _buildActionCard(
        '교통안전교육 확인 및 예약',
        Icons.open_in_new_outlined,
        _kPrimaryColor,
        () {
          Get.to(WebView(
              url:
                  'https://www.safedriving.or.kr/rersafetyed/rerSafetyedScheduleViewM.do?menuCode=MN-MO-1111',
              title: '교통안전교육 일정 확인 및 예약'));
        },
      ),
      _buildSectionCard(
          "교육대상",
          [
            "처음으로 운전면허를 취득하는 자(원동기장치 자전거 응시자 포함)",
            "군 운전면허소지자 중 일반 면허로 갱신하는 자",
          ],
          _kSuccessColor),
      _buildWarningCard("※ 교육대상자 제외"),
      _buildSectionCard(
          "교육대상자 제외",
          [
            "운전면허가 있는 사람이 다른 종류의 운전면허를 취득하고자 하는 자 (원동기장치자전거 면허 소지자 포함)",
            "외국면허 소지자로서 일반 면허로 갱신하고자 하는 자",
            "국제운전면허증을 받고자 하는 자",
          ],
          _kWarningColor),
      _buildSectionCard("교육 시기", ["학과시험 응시 전까지 언제나 가능"], _kPrimaryColor),
      _buildSectionCard("교육 시간", ["시청각 1시간"], _kPrimaryColor),
      _buildSectionCard(
          "수강신청 절차",
          ["교육 수강 신청 및 접수 > 지문 등록 > 수강카드발급 > 강의실 입실 > 교육 수강"],
          _kSecondaryColor),
      _buildSectionCard(
          "준비물", ["주민등록증 또는 본인을 확인할 수 있는 신분증, 교육 수강료 무료"], _kSecondaryColor),
      _buildSectionCard(
          "주의사항",
          ["신규면허 발급 전까지 유효기간 이내에는 수회에 걸쳐 면허시험에 응시하더라도 추가 교육 수강 의무 면제"],
          _kSecondaryColor),
    ]);
  }

  Widget _buildPhysicalExamTab() {
    return _buildTabContent([
      _buildInfoCard("신체검사", Icons.medical_services_outlined, _kSecondaryColor),
      _buildActionCard(
        '신체검사 지정병원',
        Icons.location_on_outlined,
        _kSecondaryColor,
        () => _navigateToHospital(),
      ),
      _buildSectionCard(
          "장소",
          [
            '운전면허시험장 내 신체검사실 또는 병원(문경, 강릉, 태백, 광양, 충주, 춘천시험장은 신체검사실이 없으므로 병원에서 받아와야 함)'
          ],
          _kPrimaryColor),
      _buildSectionCard("준비물 및 주의사항",
          ['신분증, 6개월 이내 촬영한 컬러 사진 (규격 3.5cm*4.5cm) 2매'], _kSecondaryColor),
      _buildSectionCard(
          "수수료",
          [
            '시험장 내 신체검사실: 1종 대형/특수면허 7,000원, 기타 면허 6,000원',
            '건강검진결과내역서 등 제출 시 신체검사비 무료(1종보통, 7년 무사고만 해당)',
            '시험장 내 신체검사장 외의 병원인 경우 신체검사비는 일반의료수가에 따름',
          ],
          _kSuccessColor),
      _buildSectionCard(
          "건강검진 결과 제출 시 면제",
          [
            '국민건강보험법 또는 의료급여법에 따른 건강검진 결과 또는 병역법에 따른 병역판정 신체검사 결과(신청일로부터 2년 이내)를 받으신 경우는 운전면허시험장 또는 경찰서에서 본인이 정보이용동의서 작성 시 별도의 건강검진결과 내역서 제출 및 신체검사를 받지 않아도 됨 (단, 신청일로부터 2년 이내여야 하며, 시력 또는 청력기준을 충족해야 함)'
          ],
          _kSuccessColor),
    ]);
  }

  Widget _buildTabContent(List<Widget> children) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: color,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: _kTextPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
      String title, IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _kCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: _kTextPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: color,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
      String title, List<String> contents, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _kCardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _kBorderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: _kTextPrimaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...contents
                .map((content) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              content,
                              style: TextStyle(
                                color: _kTextSecondaryColor,
                                fontSize: 15,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningCard(String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _kWarningLightColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _kWarningColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kWarningColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: _kWarningColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: _kWarningColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToHospital() async {
    try {
      // 위치 권한 확인 및 요청
      var permissionStatus = await Permission.location.status;
      if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
        var requested = await Permission.location.request();
        if (!requested.isGranted) {
          _showErrorDialog('위치 권한이 필요합니다.\n설정에서 위치 권한을 허용해주세요.');
          return;
        }
      }

      // shimmer 효과 로딩 표시
      Get.dialog(
        _buildShimmerLoadingDialog(),
        barrierDismissible: false,
      );

      // 병원 목록과 현재 위치를 병렬로 가져오기
      final results = await Future.wait([
        getHospitalList(),
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high),
      ]);

      final hospitalList = results[0] as List<HospitalModel>;
      final currentPosition = results[1] as Position;

      // 거리 계산 및 정렬 (HospitalModel의 내장 메서드 활용)
      for (final hospital in hospitalList) {
        hospital.distance = hospital.calculateDistance(currentPosition);
      }

      hospitalList.sort((a, b) {
        if (a.distance == null || b.distance == null) return 0;
        return a.distance!.compareTo(b.distance!);
      });

      // 로딩 닫기
      Get.back();

      // 결과 페이지로 이동
      Get.to(() => Hospital(hospitalList: hospitalList));
    } on PermissionDeniedException {
      Get.back(); // 로딩 닫기
      _showErrorDialog('위치 권한이 거부되었습니다.\n설정에서 위치 권한을 허용해주세요.');
    } on LocationServiceDisabledException {
      Get.back(); // 로딩 닫기
      _showErrorDialog('위치 서비스가 비활성화되어 있습니다.\n설정에서 위치 서비스를 활성화해주세요.');
    } catch (e) {
      Get.back(); // 로딩 닫기
      _showErrorDialog('병원 정보를 불러오는 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.');
      print('Error getting hospital list: $e');
    }
  }

  Widget _buildShimmerLoadingDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _kCardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.location_on_outlined,
                color: _kPrimaryColor,
                size: 32,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '병원 정보를 불러오는 중...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _kTextPrimaryColor,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_kPrimaryColor),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _kWarningColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.error_outline,
                color: _kWarningColor,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Text(
              '알림',
              style: TextStyle(
                color: _kTextPrimaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(
            color: _kTextSecondaryColor,
            fontSize: 15,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              backgroundColor: _kPrimaryColor.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              '확인',
              style: TextStyle(
                color: _kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
