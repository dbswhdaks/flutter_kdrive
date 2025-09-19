// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, unused_import, camel_case_types
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';
import 'package:kdrive/pages/2_wichigiban/hospital.dart';
import 'package:kdrive/models/hospital_model.dart';
import 'package:kdrive/pages/3_jeongbo/5_step/id_card.dart';
import 'package:kdrive/pages/2_wichigiban/location.dart';
import 'package:kdrive/pages/3_jeongbo/5_step/photo_specifications.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class Junbimul extends StatefulWidget {
  const Junbimul({Key? key}) : super(key: key);

  @override
  State<Junbimul> createState() => _DriveList5State();
}

class _DriveList5State extends State<Junbimul> with TickerProviderStateMixin {
  // 상수 정의로 메모리 최적화
  static const _kAppBarColor = Color(0xFF1976D2);
  static const _kHeaderColor = Color(0xFFF5F5F5);
  static const _kBorderRadius = 12.0;
  static const _kCardBorderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 7,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 40),
              Icon(
                Icons.checklist,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                "준비물",
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
              Tab(text: "신규 응시 신체검사"),
              Tab(text: "학과시험"),
              Tab(text: "기능시험"),
              Tab(text: "도로주행 시험"),
              Tab(text: "합격자 면허증 교부"),
              Tab(text: "연습면허/연습면허 재교부"),
              Tab(text: "응시원서 분실"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPhysicalExamTab(),
            _buildWrittenExamTab(),
            _buildPracticalExamTab(),
            _buildRoadTestTab(),
            _buildLicenseIssuanceTab(),
            _buildPracticeLicenseTab(),
            _buildApplicationLossTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhysicalExamTab() {
    return _buildTabContent([
      _buildInfoCard("신규 응시 신체검사", Icons.medical_services_outlined),
      Row(
        children: [
          _buildActionButton(
            '신분증 인정 범위',
            () => _navigateToPage(Id_Card()),
          ),
          SizedBox(width: 8),
          _buildActionButton(
            '허용되는 사진 규격',
            () => _navigateToPage(Photo_Specifications()),
          ),
        ],
      ),
      SizedBox(height: 16),
      _buildSectionCard("수수료",
          ["신체검사료 (시험장 내 신체검사장 기준)", "1종 대형/특수면허: 7,000원", "기타 면허: 6,000원"]),
      _buildSectionCard(
          "준비물 및 주의사항", ["신분증", "6개월 이내 촬영한 컬러 사진 (규격 3.5cm*4.5cm) 3매"]),
      _buildWarningCard(
          "병원 신체검사 외 건강검진결과 및 징병신체검사서 확인(시험장 및 경찰서 방문 시 행정정보 공동이용 동의 시 활용 가능), 진단서로 신체 검사 후 대리접수 가능(제1종 보통, 제2종 운전면허에 한함)"),
      _buildWarningCard("병원 신체검사 수수료는 병원마다 상이함"),
      _buildWarningCard(
          "강릉, 태백, 문경, 광양, 충주, 춘천면허시험장 내에는 신체검사장이 없으므로 가까운 병원에서 신체검사를 받으시기 바랍니다."),
      _buildWarningCard(
          "한쪽 눈이 보이지 않는 분이 1종 보통면허 시험에 응시할 경우, 안과의사의 진단서 필요 (세부기준 고객지원센터 1577-1120문의)"),
      _buildSectionCard("인터넷접수 및 대리접수 가능여부", ["인터넷: 불가", "대리: 불가, 본인신체검사"]),
      SizedBox(height: 16),
      _buildActionButton(
        '신체검사 지정병원',
        () => _navigateToHospital(),
      ),
    ]);
  }

  Widget _buildWrittenExamTab() {
    return _buildTabContent([
      _buildInfoCard("학과시험(재 응시 포함)", Icons.edit_note_outlined),
      _buildSectionCard("수수료", ["10,000원, 원동기 8,000원"]),
      _buildSectionCard("준비물 및 주의사항", ["신분증, 응시원서"]),
      _buildSectionCard("인터넷접수 및 대리접수 가능여부", ["인터넷 예약: 가능", "대리: 불가"]),
      SizedBox(height: 16),
      _buildActionButton(
        '학과시험 접수',
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/mainCertification01M.do',
          '학과시험 접수',
        ),
      ),
    ]);
  }

  Widget _buildPracticalExamTab() {
    return _buildTabContent([
      _buildInfoCard("기능 시험 (재 응시 포함)", Icons.directions_car_outlined),
      _buildSectionCard("수수료", [
        "대형/특수: 25,000원",
        "1·2종 보통: 25,000원",
        "2종 소형: 14,000원",
        "원동기: 10,000원"
      ]),
      _buildSectionCard("준비물 및 주의사항", ["신분증, 응시원서"]),
      _buildSectionCard("인터넷접수 및 대리접수 가능여부",
          ["인터넷 예약: 가능", "대리: 가능 (대리: 위임장, 대리인·위임자 신분증, 응시원서)"]),
      SizedBox(height: 16),
      _buildActionButton(
        '기능시험 일정 및 예약',
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
          '기능시험 일정 및 예약',
        ),
      ),
    ]);
  }

  Widget _buildRoadTestTab() {
    return _buildTabContent([
      _buildInfoCard("도로주행 시험 (재 응시 포함)", Icons.route_outlined),
      _buildSectionCard("수수료", ["30,000원"]),
      _buildSectionCard("준비물 및 주의사항", ["신분증, 응시원서"]),
      _buildSectionCard("인터넷접수 및 대리접수 가능여부",
          ["인터넷 예약: 가능", "대리: 가능 (대리: 위임장, 대리인·위임자 신분증, 응시원서)"]),
      SizedBox(height: 16),
      _buildActionButton(
        '도로주행 시험 일정 및 예약',
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
          '도로주행 시험 일정 및 예약',
        ),
      ),
    ]);
  }

  Widget _buildLicenseIssuanceTab() {
    return _buildTabContent([
      _buildInfoCard("합격자 면허증 교부", Icons.card_membership_outlined),
      _buildSectionCard(
          "수수료", ["운전면허증(국문,영문): 10,000원", "모바일 운전면허증(국문,영문): 15,000원"]),
      _buildSectionCard(
          "준비물 및 주의사항", ["신분증, 응시원서", "6개월 이내 촬영한 컬러 사진 (규격 3.5cm*4.5cm) 1매"]),
      _buildWarningCard("기존 면허증 소지자는 구 면허증 반납"),
      _buildSectionCard("인터넷접수 및 대리접수 가능여부",
          ["인터넷 예약: 불가", "대리: 가능 (대리: 위임장, 대리인·위임자 신분증, 응시원서)"]),
    ]);
  }

  Widget _buildPracticeLicenseTab() {
    return _buildTabContent([
      _buildInfoCard("연습면허/연습면허 재교부", Icons.assignment_outlined),
      _buildSectionCard("수수료", ["4,000원"]),
      _buildSectionCard("준비물 및 주의사항", ["신분증, 응시원서"]),
      _buildSectionCard("인터넷접수 및 대리접수 가능여부", [
        "인터넷 예약: 가능 (연습면허증 재교부는 인터넷 불가)",
        "대리: 가능 (대리: 위임장, 대리인·위임자 신분증, 응시원서)"
      ]),
      SizedBox(height: 16),
      _buildActionButton(
        '연습면허 발급',
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/mainCertification01M.do',
          '연습면허 발급',
        ),
      ),
    ]);
  }

  Widget _buildApplicationLossTab() {
    return _buildTabContent([
      _buildInfoCard("응시원서 분실", Icons.description_outlined),
      _buildSectionCard("수수료", ["1,000원, 연습면허 재발급 시 4,000원"]),
      _buildSectionCard(
          "준비물 및 주의사항", ["신분증", "6개월 이내 촬영한 컬러 사진 (규격 3.5cm*4.5cm) 1매"]),
      _buildSectionCard(
          "인터넷접수 및 대리접수 가능여부", ["인터넷 예약: 불가", "대리: 가능 (대리: 위임장, 대리인·위임자 신분증)"]),
    ]);
  }

  // Helper methods
  void _navigateToWebView(String url, String title) {
    Get.to(WebView(url: url, title: title));
  }

  void _navigateToPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
      /// 로딩 인디케이터 컨테이너
      backgroundColor: Colors.transparent,
      child: Container(
        width: 300,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          /// 로딩 인디케이터 컨테이너 내부 컬럼
          mainAxisSize: MainAxisSize.min,
          children: [
            // 로딩 텍스트
            Text(
              '병원 정보를 불러오는 중...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            // Shimmer 효과가 적용된 로딩 인디케이터
            Shimmer.fromColors(
              /// 로딩 인디케이터 컨테이너
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                /// 로딩 인디케이터 컨테이너
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Shimmer 효과가 적용된 텍스트
            Shimmer.fromColors(
              /// 로딩 인디케이터 컨테이너
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                /// 로딩 인디케이터 컨테이너
                width: 120,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            SizedBox(height: 8),
            Shimmer.fromColors(
              /// 로딩 인디케이터 컨테이너
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                /// 로딩 인디케이터 컨테이너
                width: 80,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    Get.dialog(
      /// 에러 다이얼로그
      AlertDialog(
        title: Text('알림'),
        content: Text(message),
        actions: [
          /// 에러 다이얼로그 액션
          TextButton(
            /// 에러 다이얼로그 액션 버튼
            onPressed: () => Get.back(),
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(List<Widget> children) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(_kBorderRadius),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.black54,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, List<String> contents,
      {bool isImportant = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kCardBorderRadius),
        border: Border.all(
          color:
              isImportant ? const Color(0xFFFFCC80) : const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isImportant
                          ? const Color(0xFFE65100)
                          : const Color(0xFF212121),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...contents
                .map((content) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        content,
                        style: TextStyle(
                          color: isImportant
                              ? const Color(0xFFD32F2F)
                              : const Color(0xFF757575),
                          fontSize: 14,
                          height: 1.4,
                        ),
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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(_kCardBorderRadius),
        border: Border.all(
          color: const Color(0xFFFFCDD2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_outlined,
              color: const Color(0xFFD32F2F),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Color(0xFFD32F2F),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        /// 버튼 컨테이너 내부 박스 데코레이션
        border: Border.all(
          color: Colors.blue[600]!,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Material(
        /// 버튼 컨테이너 내부 머티리얼
        color: Colors.transparent,
        child: InkWell(
          /// 버튼 컨테이너 내부 인클 웰
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            /// 버튼 컨테이너 내부 컨테이너 내부 패딩
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 버튼 컨테이너 내부 컬럼
                Icon(
                  /// 버튼 컨테이너 내부 컬럼 내부 아이콘
                  Icons.arrow_forward_ios,
                  color: Colors.blue[600],
                  size: 12,
                ),
                SizedBox(width: 6),
                Text(
                  /// 버튼 컨테이너 내부 컬럼 내부 텍스트
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[600],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
