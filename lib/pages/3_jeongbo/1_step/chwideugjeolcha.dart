// ignore_for_file: camel_case_types, unnecessary_cast, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';
import 'package:kdrive/pages/2_wichigiban/hospital.dart';
import 'package:kdrive/models/hospital_model.dart';
import 'package:kdrive/pages/2_wichigiban/location.dart';
// import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';

class Chwideugjeolcha extends StatelessWidget {
  const Chwideugjeolcha({Key? key}) : super(key: key);

  // 상수 정의로 메모리 최적화
  static const _kAppBarColor = Color(0xFF1976D2);
  static const _kHeaderColor = Color(0xFFF5F5F5);
  static const _kBorderRadius = 12.0;
  static const _kCardBorderRadius = 8.0;
  static const _kButtonBorderRadius = 6.0;
  static const _kLoadingDuration = Duration(milliseconds: 300);
  static const _kTransitionDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                ..._buildStepCards(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 10,
      backgroundColor: _kAppBarColor,
      title: const Text(
        '운전면허 시험순서',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(_kBorderRadius),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _kHeaderColor,
        borderRadius: BorderRadius.circular(_kBorderRadius),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.drive_eta_outlined,
            color: Colors.black54,
            size: 32,
          ),
          SizedBox(height: 12),
          Text(
            '운전면허 취득 과정',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '아래 순서에 따라 진행하세요',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStepCards() {
    return [
      _buildStepCard(
        stepNumber: '①',
        title: '응시 전 교통안전교육',
        description: '학과 시험 전까지 이수 완료',
        requirements: '준비물 : 신분증',
        buttonText: '응시전 교통안전교육 예약',
        buttonUrl:
            'https://www.safedriving.or.kr/rersafetyed/rerSafetyedScheduleViewM.do?menuCode=MN-MO-1111',
        buttonTitle: '',
        onPressed: null,
      ),
      _buildStepCard(
        stepNumber: '②',
        title: '신체검사',
        description: '시험장내 신체검사실 또는 병원에서 검사진행',
        requirements: '(문경,강릉,태백,광양,충주,춘천시험장내 신체검사원 없음)',
        buttonText: '신체검사 지정병원',
        buttonUrl: '',
        buttonTitle: '',
        onPressed: _handlePhysicalExam,
      ),
      _buildStepCard(
        stepNumber: '③',
        title: '학과시험',
        description: '준비물 : 응시원서,신분증, 6개월 이내 촬영한 컬러 사진 (3.5*4.5cm) 3매',
        requirements: '',
        buttonText: '학과시험 접수',
        buttonUrl: 'https://www.safedriving.or.kr/mainCertification01M.do',
        buttonTitle: '학과시험 접수',
        onPressed: null,
      ),
      _buildStepCard(
        stepNumber: '④',
        title: '기능시험',
        description: '준비물:응시원서,신분증',
        requirements:
            '대리접수 : 대리인 신분증 및 위임자의 위임장\n불합격시 : 불합격일로부터 3일 경과후 재 응시 가능',
        buttonText: '기능시험 접수',
        buttonUrl:
            'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
        buttonTitle: '기능시험 접수',
        onPressed: null,
        isWarning: true,
      ),
      _buildStepCard(
        stepNumber: '⑤',
        title: '연습면허 발급',
        description: '제 1,2종 보통면허시험 응시자로 학과시험, 장내기능 시험에 모두 합격한자',
        requirements: '',
        buttonText: '연습면허증 발급',
        buttonUrl: 'https://www.safedriving.or.kr/mainM.do',
        buttonTitle: '연습면허증 발급',
        onPressed: null,
      ),
      _buildStepCard(
        stepNumber: '⑥',
        title: '도로주행시험',
        description: '',
        requirements: '불합격 시 : 불합격일로부터 3일 경과 후 재 응시 가능',
        buttonText: '도로주행시험 접수',
        buttonUrl:
            'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
        buttonTitle: '도로주행시험 접수',
        onPressed: null,
        isWarning: true,
      ),
      _buildStepCard(
        stepNumber: '⑦',
        title: '운전면허증 발급',
        description: '제1,2종 보통면허: 연습면허 취득 후 도로주행시험에 합격한 자',
        requirements: '기타 면허:학과시험 기능시험에 불합격한 자',
        buttonText: '운전면허증 발급',
        buttonUrl: 'https://www.safedriving.or.kr/mainM.do',
        buttonTitle: '운전면허증 발급',
        onPressed: null,
      ),
    ];
  }

  Widget _buildStepCard({
    required String stepNumber,
    required String title,
    required String description,
    required String requirements,
    required String buttonText,
    required String buttonUrl,
    required String buttonTitle,
    required VoidCallback? onPressed,
    bool isWarning = false,
  }) {
    final colorScheme = _getColorScheme(isWarning);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kCardBorderRadius),
        border: Border.all(
          color: colorScheme.borderColor,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepHeader(stepNumber, title, colorScheme),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
            if (requirements.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                requirements,
                style: TextStyle(
                  color: colorScheme.requirementsColor,
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
            ],
            const SizedBox(height: 16),
            _buildStepButton(
                buttonText, buttonUrl, buttonTitle, onPressed, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildStepHeader(
      String stepNumber, String title, _ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: colorScheme.stepBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              stepNumber,
              style: TextStyle(
                color: colorScheme.stepTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: colorScheme.titleColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepButton(String buttonText, String buttonUrl,
      String buttonTitle, VoidCallback? onPressed, _ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.buttonColor,
          side: BorderSide(
            color: colorScheme.buttonBorderColor,
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kButtonBorderRadius),
          ),
        ),
        onPressed:
            onPressed ?? () => _navigateToWebView(buttonUrl, buttonTitle),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  _ColorScheme _getColorScheme(bool isWarning) {
    if (isWarning) {
      return _ColorScheme.warning();
    }
    return _ColorScheme.normal();
  }

  void _navigateToWebView(String url, String title) {
    if (url.isNotEmpty) {
      Get.to(() => WebView(url: url, title: title));
    }
  }

  Widget _buildShimmerLoadingDialog() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: _kLoadingDuration,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (value * 0.2),
          child: Opacity(
            opacity: value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_kBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1 * value),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLoadingIcon(),
                    const SizedBox(height: 16),
                    _buildLoadingText(),
                    const SizedBox(height: 20),
                    _buildProgressBar(),
                    const SizedBox(height: 16),
                    _buildLoadingDots(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: const Icon(
            Icons.local_hospital_outlined,
            size: 48,
            color: Colors.grey,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: _AnimatedLoadingIndicator(),
        ),
      ],
    );
  }

  Widget _buildLoadingText() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const Text(
        '병원 정보를 불러오는 중...',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildLoadingDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ShimmerDot(),
        _ShimmerDot(delay: 200),
        _ShimmerDot(delay: 400),
      ],
    );
  }

  void _showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('알림'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePhysicalExam() async {
    try {
      // 위치 권한 확인 및 요청
      if (!await _requestLocationPermission()) {
        return;
      }

      // 로딩 다이얼로그 표시
      Get.dialog(
        _buildShimmerLoadingDialog(),
        barrierDismissible: false,
        transitionDuration: _kTransitionDuration,
        transitionCurve: Curves.easeInOut,
      );

      // 병원 데이터 로드 및 처리
      final hospitalList = await _loadHospitalData();

      // 로딩 닫기
      Get.back();

      // 결과 페이지로 이동
      await Future.delayed(const Duration(milliseconds: 100));
      Get.to(
        () => Hospital(hospitalList: hospitalList),
        transition: Transition.fadeIn,
        duration: _kTransitionDuration,
      );
    } on PermissionDeniedException {
      Get.back();
      _showErrorDialog('위치 권한이 거부되었습니다.\n설정에서 위치 권한을 허용해주세요.');
    } on LocationServiceDisabledException {
      Get.back();
      _showErrorDialog('위치 서비스가 비활성화되어 있습니다.\n설정에서 위치 서비스를 활성화해주세요.');
    } catch (e) {
      Get.back();
      _showErrorDialog('병원 정보를 불러오는 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.');
      debugPrint('Error getting hospital list: $e');
    }
  }

  Future<bool> _requestLocationPermission() async {
    var permissionStatus = await Permission.location.status;
    if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
      var requested = await Permission.location.request();
      if (!requested.isGranted) {
        _showErrorDialog('위치 권한이 필요합니다.\n설정에서 위치 권한을 허용해주세요.');
        return false;
      }
    }
    return true;
  }

  Future<List<HospitalModel>> _loadHospitalData() async {
    // 병원 목록과 현재 위치를 병렬로 가져오기
    final results = await Future.wait([
      getHospitalList(),
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high),
    ]);

    final hospitalList = results[0] as List<HospitalModel>;
    final currentPosition = results[1] as Position;

    // 거리 계산 및 정렬
    _calculateAndSortDistances(hospitalList, currentPosition);

    return hospitalList;
  }

  void _calculateAndSortDistances(
      List<HospitalModel> hospitalList, Position currentPosition) {
    for (final hospital in hospitalList) {
      hospital.distance = hospital.calculateDistance(currentPosition);
    }

    hospitalList.sort((a, b) {
      if (a.distance == null || b.distance == null) return 0;
      return a.distance!.compareTo(b.distance!);
    });
  }
}

// 색상 스키마 클래스로 색상 관리 최적화
class _ColorScheme {
  final Color stepBackgroundColor;
  final Color stepTextColor;
  final Color titleColor;
  final Color requirementsColor;
  final Color buttonColor;
  final Color buttonBorderColor;
  final Color borderColor;

  const _ColorScheme({
    required this.stepBackgroundColor,
    required this.stepTextColor,
    required this.titleColor,
    required this.requirementsColor,
    required this.buttonColor,
    required this.buttonBorderColor,
    required this.borderColor,
  });

  factory _ColorScheme.normal() {
    return const _ColorScheme(
      stepBackgroundColor: Color(0xFFE3F2FD),
      stepTextColor: Color(0xFF1976D2),
      titleColor: Color(0xFF212121),
      requirementsColor: Color(0xFF757575),
      buttonColor: Color(0xFF1976D2),
      buttonBorderColor: Color(0xFF90CAF9),
      borderColor: Color(0xFFE0E0E0),
    );
  }

  factory _ColorScheme.warning() {
    return const _ColorScheme(
      stepBackgroundColor: Color(0xFFFFF3E0),
      stepTextColor: Color(0xFFF57C00),
      titleColor: Color(0xFFE65100),
      requirementsColor: Color(0xFFD32F2F),
      buttonColor: Color(0xFFF57C00),
      buttonBorderColor: Color(0xFFFFB74D),
      borderColor: Color(0xFFFFCC80),
    );
  }
}

// 애니메이션 로딩 인디케이터 위젯
class _AnimatedLoadingIndicator extends StatefulWidget {
  const _AnimatedLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<_AnimatedLoadingIndicator> createState() =>
      _AnimatedLoadingIndicatorState();
}

class _AnimatedLoadingIndicatorState extends State<_AnimatedLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

// Shimmer 점 위젯
class _ShimmerDot extends StatefulWidget {
  final int delay;

  const _ShimmerDot({Key? key, this.delay = 0}) : super(key: key);

  @override
  State<_ShimmerDot> createState() => _ShimmerDotState();
}

class _ShimmerDotState extends State<_ShimmerDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600 + widget.delay),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.5 + (_controller.value * 0.5),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
