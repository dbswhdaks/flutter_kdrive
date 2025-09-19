// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kdrive/models/hospital_model.dart';
import 'package:kdrive/pages/2_wichigiban/distance_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:geolocator/geolocator.dart';

// 스타일 정의 클래스
class HospitalStyles {
  /// 신체검사 지정병원 화면 스타일 클래스
  // 그라데이션 색상
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    /// 신체검사 지정병원 화면 스타일 클래스
    colors: [Colors.white, Color(0xFFf8f9ff)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient iconGradient = LinearGradient(
    /// 신체검사 지정병원 화면 스타일 클래스
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const TextStyle titleStyle = TextStyle(
    /// 신체검사 지정병원 화면 스타일 클래스
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static const TextStyle hospitalNameStyle = TextStyle(
    /// 신체검사 지정병원 화면 스타일 클래스
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Color(0xFF2d3748),
    letterSpacing: 0.3,
  );

  static const TextStyle phoneStyle = TextStyle(
    /// 신체검사 지정병원 화면 스타일 클래스
    fontSize: 15,
    color: Color(0xFF667eea),
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static const TextStyle addressStyle = TextStyle(
    /// 신체검사 지정병원 화면 스타일 클래스
    fontSize: 14,
    color: Color(0xFF718096),
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle distanceStyle = TextStyle(
    fontSize: 13,
    color: Color(0xFF48bb78),
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
  );

  static const TextStyle popupTitleStyle = TextStyle(
    /// 신체검사 지정병원 화면 스타일 클래스
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Color(0xFF2d3748),
    letterSpacing: 0.3,
  );

  static const TextStyle popupAddressStyle = TextStyle(
    /// 신체검사 지정병원 화면 스타일 클래스
    fontSize: 15,
    color: Color(0xFF718096),
    height: 1.5,
    letterSpacing: 0.1,
  );

  static const TextStyle popupDistanceStyle = TextStyle(
    /// 신체검사 지정병원 화면 스타일 클래스
    fontSize: 14,
    color: Color(0xFF48bb78),
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  static const TextStyle closeButtonStyle = TextStyle(
    fontSize: 16,
    color: Color(0xFF718096),
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static const TextStyle errorTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0xFFe53e3e),
    letterSpacing: 0.3,
  );

  static const TextStyle errorMessageStyle = TextStyle(
    fontSize: 15,
    color: Color(0xFF718096),
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle emptyTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0xFF718096),
    letterSpacing: 0.3,
  );

  static const TextStyle emptyMessageStyle = TextStyle(
    fontSize: 15,
    color: Color(0xFFa0aec0),
    height: 1.4,
    letterSpacing: 0.1,
  );
}

// 공통 위젯 클래스
class HospitalWidgets {
  // 병원 아이콘 위젯
  static Widget hospitalIcon() {
    return Container(
      /// 신체검사 지정병원 화면 쉬머 위젯
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: HospitalStyles.iconGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            /// 신체검사 지정병원 화면 쉬머 위젯
            color: const Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(
        /// 신체검사 지정병원 화면 쉬머 위젯
        Icons.local_hospital_rounded,
        size: 28,
        color: Colors.white,
      ),
    );
  }

  // 거리 표시 위젯
  static Widget distanceChip(String distance) {
    /// 신체검사 지정병원 화면 쉬머 위젯
    return Container(
      /// 신체검사 지정병원 화면 쉬머 위젯
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF48bb78), Color(0xFF38a169)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            /// 신체검사 지정병원 화면 쉬머 위젯
            color: const Color(0xFF48bb78).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        /// 신체검사 지정병원 화면 쉬머 위젯
        distance,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  // 액션 버튼 위젯
  static Widget actionButton({
    /// 신체검사 지정병원 화면 쉬머 위젯
    required VoidCallback onPressed,
    required Color backgroundColor,
    required IconData icon,
    required String label,
  }) {
    return Container(
      /// 신체검사 지정병원 화면 쉬머 위젯
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [backgroundColor, backgroundColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        /// 신체검사 지정병원 화면 쉬머 위젯
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label, style: HospitalStyles.buttonTextStyle),
      ),
    );
  }

  // 상태 아이콘 위젯
  static Widget statusIcon({
    /// 신체검사 지정병원 화면 쉬머 위젯
    required IconData icon,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      /// 신체검사 지정병원 화면 쉬머 위젯
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [backgroundColor, backgroundColor.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        /// 신체검사 지정병원 화면 쉬머 위젯
        icon,
        size: 48,
        color: color,
      ),
    );
  }

  // Shimmer 카드 위젯
  static Widget shimmerCard() {
    /// 신체검사 지정병원 화면 쉬머 위젯
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        gradient: HospitalStyles.cardGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          /// 신체검사 지정병원 화면 쉬머 위젯
          children: [
            Container(
              /// 신체검사 지정병원 화면 쉬머 위젯
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                /// 신체검사 지정병원 화면 쉬머 위젯
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerLine(double.infinity, 20),
                  const SizedBox(height: 6),
                  _buildShimmerLine(140, 18),
                  const SizedBox(height: 6),
                  _buildShimmerLine(double.infinity, 16),
                  const SizedBox(height: 6),
                  _buildShimmerLine(220, 16),
                  const SizedBox(height: 8),
                  _buildShimmerLine(80, 14),
                ],
              ),
            ),
            _buildShimmerLine(24, 24),
          ],
        ),
      ),
    );
  }

  static Widget _buildShimmerLine(double width, double height) {
    return Container(
      /// 신체검사 지정병원 화면 쉬머 위젯
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}

class Hospital extends StatefulWidget {
  /// 신체검사 지정병원 화면
  const Hospital({super.key, required this.hospitalList});

  final List<HospitalModel> hospitalList;

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  /// 신체검사 지정병원 화면 상태 클래스
  List<HospitalModel> sortedHospitalList = [];
  Map<String, double> distanceCache = {};
  bool isLoading = true;
  bool isInitialLoad = true;
  String? errorMessage;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    distanceCache.clear();
    super.dispose();
  }

  // 초기화 함수 - 완전 정렬 버전
  Future<void> _initializeData() async {
    /// 신체검사 지정병원 화면 초기화 함수
    try {
      // 위치 권한 확인
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _setErrorState('위치 권한이 거부되었습니다. 설정에서 권한을 허용해주세요.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _setErrorState('위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.');
        return;
      }

      // 위치 서비스 활성화 확인
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _setErrorState('위치 서비스가 비활성화되어 있습니다. 설정에서 위치 서비스를 활성화해주세요.');
        return;
      }

      // 현재 위치 가져오기
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 10),
      );

      // 거리 계산 및 완전 정렬
      await _calculateDistancesAndSort();

      // 정렬 완료 후 UI 업데이트
      if (mounted) {
        setState(() {
          isLoading = false;
          isInitialLoad = false;
        });
      }
    } catch (e) {
      _setErrorState('데이터를 불러오는 중 오류가 발생했습니다: $e');
    }
  }

  // 거리 계산 및 완전 정렬
  Future<void> _calculateDistancesAndSort() async {
    if (currentPosition == null) return;

    try {
      // 모든 병원의 거리를 병렬로 계산
      List<Future<MapEntry<HospitalModel, double>>> futures =
          widget.hospitalList.map((hospital) async {
        String cacheKey = '${hospital.latitude}_${hospital.longitude}';

        // 캐시 확인
        if (distanceCache.containsKey(cacheKey)) {
          return MapEntry(hospital, distanceCache[cacheKey]!);
        }

        // 거리 계산
        double distance = await DistanceService.calculateDistanceFromPosition(
            currentPosition!, hospital.latitude, hospital.longitude);

        // 캐시에 저장
        distanceCache[cacheKey] = distance;

        return MapEntry(hospital, distance);
      }).toList();

      // 모든 거리 계산 완료 대기
      List<MapEntry<HospitalModel, double>> allDistances =
          await Future.wait(futures);

      // 거리순으로 정렬
      allDistances.sort((a, b) => a.value.compareTo(b.value));

      // 정렬된 리스트 업데이트
      if (mounted) {
        setState(() {
          sortedHospitalList = allDistances.map((entry) => entry.key).toList();
        });
      }
    } catch (e) {
      // 거리 계산 실패 시 기본 목록 사용
      if (mounted) {
        setState(() {
          sortedHospitalList = List.from(widget.hospitalList);
        });
      }
    }
  }

  void _setErrorState(String message) {
    if (mounted) {
      setState(() {
        errorMessage = message;
        isLoading = false;
        isInitialLoad = false;
      });
    }
  }

  // 거리 정보 가져오기 - 캐시 우선 사용
  String _getDistanceText(int index) {
    if (index >= sortedHospitalList.length) return '거리 계산 중...';

    final hospital = sortedHospitalList[index];
    String cacheKey = '${hospital.latitude}_${hospital.longitude}';

    if (distanceCache.containsKey(cacheKey)) {
      double distance = distanceCache[cacheKey]!;
      if (distance == 0.0) {
        return '거리 계산 실패';
      }
      return '${distance.toStringAsFixed(1)}km';
    }
    return '거리 계산 중...';
  }

  // 팝업창 표시 - 캐시 활용
  void _showPopup(BuildContext context, HospitalModel hospital) async {
    try {
      String cacheKey = '${hospital.latitude}_${hospital.longitude}';
      double distance;

      // 캐시에서 거리 확인
      if (distanceCache.containsKey(cacheKey)) {
        distance = distanceCache[cacheKey]!;
      } else {
        // 캐시에 없으면 계산
        distance = await DistanceService.calculateDistance(
            hospital.latitude, hospital.longitude);
        distanceCache[cacheKey] = distance;
      }

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => _buildPopupDialog(context, hospital, distance),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('팝업을 표시하는 중 오류가 발생했습니다.')),
        );
      }
    }
  }

  // 팝업 다이얼로그 위젯
  Widget _buildPopupDialog(
      BuildContext context, HospitalModel hospital, double distance) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 병원명
            Text(
              hospital.name.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2d3748),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 주소
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: const Color(0xFF718096),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    hospital.address.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF718096),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 거리 정보
            Row(
              children: [
                Icon(
                  Icons.directions_walk_outlined,
                  size: 18,
                  color: const Color(0xFF48bb78),
                ),
                const SizedBox(width: 8),
                Text(
                  distance > 0
                      ? '${distance.toStringAsFixed(1)}km'
                      : '거리 계산 실패',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF48bb78),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 버튼들
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _makePhoneCall(hospital.phone.toString()),
                    icon: const Icon(Icons.phone_outlined, size: 18),
                    label: const Text('통화'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF667eea),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _openMap(hospital.name.toString()),
                    icon: const Icon(Icons.directions_outlined, size: 18),
                    label: const Text('길찾기'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF48bb78),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 닫기 버튼
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFf7fafc),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFe2e8f0),
                  width: 1,
                ),
              ),
              child: TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close_outlined,
                  size: 18,
                  color: Color(0xFF718096),
                ),
                label: const Text(
                  '닫기',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF718096),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 전화 걸기
  Future<void> _makePhoneCall(String phone) async {
    try {
      await launchUrl(Uri.parse('tel://$phone'));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('전화 연결에 실패했습니다.')),
        );
      }
    }
  }

  // 지도 열기
  Future<void> _openMap(String name) async {
    try {
      String naverUrl =
          'https://map.naver.com/v5/search/${Uri.encodeComponent(name)}';
      await launchUrl(Uri.parse(naverUrl));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('지도 앱 실행에 실패했습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // 앱바 위젯
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: HospitalStyles.primaryGradient,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: const Text('신체검사 지정병원', style: HospitalStyles.titleStyle),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 메인 바디 위젯
  Widget _buildBody() {
    if (isLoading) {
      return _buildShimmerLoading();
    }

    if (errorMessage != null) {
      return _buildErrorState();
    }

    if (sortedHospitalList.isEmpty) {
      return _buildEmptyState();
    }

    return _buildHospitalList();
  }

  // 병원 리스트 위젯
  Widget _buildHospitalList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: false,
      itemCount: sortedHospitalList.length,
      itemBuilder: (context, index) {
        return _buildHospitalCard(index);
      },
    );
  }

  // 병원 카드 위젯
  Widget _buildHospitalCard(int index) {
    final hospital = sortedHospitalList[index];

    return GestureDetector(
      onTap: () => _showPopup(context, hospital),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: HospitalStyles.cardGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              HospitalWidgets.hospitalIcon(),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hospital.name.toString(),
                      style: HospitalStyles.hospitalNameStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_rounded,
                          size: 16,
                          color: const Color(0xFF667eea),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            hospital.phone.toString(),
                            style: HospitalStyles.phoneStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 16,
                          color: const Color(0xFF718096),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            hospital.address.toString(),
                            style: HospitalStyles.addressStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.directions_walk_rounded,
                          size: 16,
                          color: const Color(0xFF48bb78),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _getDistanceText(index),
                          style: HospitalStyles.distanceStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF667eea).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF667eea),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 에러 상태 위젯
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HospitalWidgets.statusIcon(
              icon: Icons.error_outline_rounded,
              color: const Color(0xFFe53e3e),
              backgroundColor: const Color(0xFFfed7d7),
            ),
            const SizedBox(height: 28),
            const Text(
              '오류가 발생했습니다',
              style: HospitalStyles.errorTitleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFf7fafc),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFfed7d7),
                  width: 1,
                ),
              ),
              child: Text(
                errorMessage ?? '알 수 없는 오류가 발생했습니다',
                style: HospitalStyles.errorMessageStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667eea).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    errorMessage = null;
                    distanceCache.clear();
                    currentPosition = null;
                  });
                  _initializeData();
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('다시 시도'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Shimmer 로딩 위젯
  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFe2e8f0),
      highlightColor: const Color(0xFFf7fafc),
      period: const Duration(milliseconds: 800),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) => HospitalWidgets.shimmerCard(),
      ),
    );
  }

  // 빈 상태 위젯
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HospitalWidgets.statusIcon(
              icon: Icons.local_hospital_outlined,
              color: const Color(0xFF718096),
              backgroundColor: const Color(0xFFf7fafc),
            ),
            const SizedBox(height: 28),
            const Text(
              '병원 정보를 찾을 수 없습니다',
              style: HospitalStyles.emptyTitleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFf7fafc),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFe2e8f0),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 24,
                    color: const Color(0xFFa0aec0),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '위치 권한을 확인해주세요',
                    style: HospitalStyles.emptyMessageStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
