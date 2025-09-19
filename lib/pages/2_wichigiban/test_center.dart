// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:kdrive/models/license_model.dart';
import 'package:kdrive/pages/2_wichigiban/distance_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';

class Test_Center extends StatefulWidget {
  Test_Center({super.key, required this.response});

  final List<LicenseModel> response;

  @override
  State<Test_Center> createState() => _Test_CenterState();
}

class _Test_CenterState extends State<Test_Center>
    with TickerProviderStateMixin {
  List<LicenseModel> sortedResponse = [];
  Map<int, double> distanceCache = {};
  bool isLoading = true;
  bool isInitialLoad = true;
  bool isShimmerVisible = true; // shimmer 표시 상태 추가
  String? errorMessage; // 에러 메시지 추가

  // 성능 최적화를 위한 변수들
  late final ScrollController _scrollController;
  static const int _cacheSize = 10; // 캐시 크기 제한
  static const int _shimmerItemCount = 8; // shimmer 아이템 수 증가로 더 자연스러운 로딩
  static const Duration _shimmerDuration =
      Duration(milliseconds: 1500); // shimmer 지속 시간

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initializeData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 초기화 함수
  Future<void> _initializeData() async {
    try {
      // 위치 권한 확인
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            errorMessage = '위치 권한이 거부되었습니다. 설정에서 권한을 허용해주세요.';
            isLoading = false;
            isInitialLoad = false;
            isShimmerVisible = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          errorMessage = '위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.';
          isLoading = false;
          isInitialLoad = false;
          isShimmerVisible = false;
        });
        return;
      }

      // 위치 서비스 활성화 확인
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          errorMessage = '위치 서비스가 비활성화되어 있습니다. 설정에서 위치 서비스를 활성화해주세요.';
          isLoading = false;
          isInitialLoad = false;
          isShimmerVisible = false;
        });
        return;
      }

      // 거리 정렬 실행
      await _sortByDistance();
    } catch (e) {
      setState(() {
        errorMessage = '데이터를 불러오는 중 오류가 발생했습니다: $e';
        isLoading = false;
        isInitialLoad = false;
        isShimmerVisible = false;
      });
    }
  }

  // 거리순으로 정렬하는 함수 - 최적화된 버전
  Future<void> _sortByDistance() async {
    if (widget.response.isEmpty) {
      setState(() {
        isLoading = false;
        isInitialLoad = false;
        isShimmerVisible = false;
      });
      return;
    }

    try {
      // 현재 위치를 한 번만 가져오기
      Position? currentPosition = await DistanceService.getCurrentPosition();
      if (currentPosition == null) {
        setState(() {
          errorMessage = '현재 위치를 가져올 수 없습니다.';
          isLoading = false;
          isInitialLoad = false;
          isShimmerVisible = false;
        });
        return;
      }

      List<MapEntry<LicenseModel, double>> distanceList = [];

      // 배치 처리로 성능 향상
      const int batchSize = 10;
      for (int i = 0; i < widget.response.length; i += batchSize) {
        int end = (i + batchSize < widget.response.length)
            ? i + batchSize
            : widget.response.length;

        List<Future<MapEntry<LicenseModel, double>>> batchFutures =
            widget.response.sublist(i, end).map((license) async {
          double distance = await DistanceService.calculateDistanceFromPosition(
              currentPosition, license.latitude, license.longitude);
          return MapEntry(license, distance);
        }).toList();

        List<MapEntry<LicenseModel, double>> batchResults =
            await Future.wait(batchFutures);
        distanceList.addAll(batchResults);
      }

      // 거리순으로 정렬
      distanceList.sort((a, b) => a.value.compareTo(b.value));

      // 캐시 크기 제한
      if (distanceCache.length > _cacheSize) {
        distanceCache.clear();
      }

      if (mounted) {
        setState(() {
          sortedResponse = distanceList.map((entry) => entry.key).toList();
          for (int i = 0; i < sortedResponse.length; i++) {
            distanceCache[i] = distanceList[i].value;
          }
          isLoading = false;
          isInitialLoad = false;
          isShimmerVisible = false;
          errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = '거리 계산 중 오류가 발생했습니다: $e';
          isLoading = false;
          isInitialLoad = false;
          isShimmerVisible = false;
        });
      }
    }
  }

  // 거리 정보 가져오기 - 최적화된 버전
  String _getDistanceText(int index) {
    if (distanceCache.containsKey(index)) {
      double distance = distanceCache[index]!;
      if (distance == 0.0) {
        return '거리 계산 실패';
      }
      return '${distance.toStringAsFixed(1)}km';
    }
    return '거리 계산 중...';
  }

  //팝업창 - 최적화된 버전
  void showPopup(context, image, name, type, address, phone, naver, latitude,
      longitude) async {
    try {
      // 상세 페이지에서 거리 계산
      double distance =
          await DistanceService.calculateDistance(latitude, longitude);

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 상단 이미지 섹션 - 최적화된 버전
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // 최적화된 이미지 로딩
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue[400]!,
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.grey[600],
                                size: 48,
                              ),
                            ),
                          ),
                        ),
                        // 그라데이션 오버레이
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                        // 거리 정보 배지
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.green[600],
                                ),
                                SizedBox(width: 4),
                                Text(
                                  distance > 0
                                      ? '${distance.toStringAsFixed(1)}km'
                                      : '거리 계산 실패',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // 닫기 버튼
                        Positioned(
                          top: 16,
                          left: 16,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 콘텐츠 섹션
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 시험장 이름
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 8),

                          // 종별 정보
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            child: Text(
                              type,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),

                          // 주소 정보
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  address,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          // 액션 버튼들
                          Row(
                            children: [
                              // 전화 버튼
                              Expanded(
                                child: Container(
                                  height: 56,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[600],
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: () async {
                                      try {
                                        await launchUrl(
                                            Uri.parse('tel://$phone'));
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text('전화 연결에 실패했습니다.')),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.phone, size: 20),
                                    label: Text(
                                      '전화하기',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              // 길찾기 버튼
                              Expanded(
                                child: Container(
                                  height: 56,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[600],
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: () async {
                                      try {
                                        await launchUrl(Uri.parse('$naver'));
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('지도 앱 실행에 실패했습니다.')),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.directions, size: 20),
                                    label: Text(
                                      '길찾기',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // 닫기 버튼
                          Center(
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.grey[600],
                                  side: BorderSide(color: Colors.grey[300]!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: Colors.grey[50],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close, size: 18),
                                label: Text(
                                  '닫기',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('팝업을 표시하는 중 오류가 발생했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 1, vsync: this);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('운전면허 시험장'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: TabBarView(
                controller: tabController,
                children: [
                  isShimmerVisible
                      ? _buildShimmerLoading()
                      : errorMessage != null
                          ? _buildErrorState()
                          : sortedResponse.isEmpty
                              ? _buildEmptyState()
                              : _buildListView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 에러 상태 위젯
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: Colors.red[400],
              ),
            ),
            SizedBox(height: 24),
            Text(
              '오류가 발생했습니다',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.red[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              errorMessage ?? '알 수 없는 오류가 발생했습니다',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                  isShimmerVisible = true;
                });
                _initializeData();
              },
              icon: Icon(Icons.refresh),
              label: Text('다시 시도'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 최적화된 ListView 빌더
  Widget _buildListView() {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: sortedResponse.length,
      // 성능 최적화를 위한 추가 설정
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemBuilder: (context, index) {
        return _buildListItem(index);
      },
    );
  }

  // 최적화된 리스트 아이템
  Widget _buildListItem(int index) {
    final item = sortedResponse[index];

    return GestureDetector(
      onTap: () {
        showPopup(
            context,
            item.image.toString(),
            item.name.toString(),
            item.type.toString(),
            item.address.toString(),
            item.phone.toString(),
            item.naver.toString(),
            item.latitude,
            item.longitude);
      },
      child: Card.outlined(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          width: double.infinity,
          height: 120,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // 최적화된 이미지 로딩
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: item.image.toString(),
                  width: 100,
                  height: 70,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue[400]!,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    Text(item.phone.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.blue)),
                    Text(item.address.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[500])),
                    SizedBox(height: 4),
                    Text(_getDistanceText(index),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 최적화된 Shimmer 로딩 위젯 - drive_list5.dart 스타일 적용
  Widget _buildShimmerLoading() {
    return Column(
      children: [
        // 로딩 텍스트 섹션
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              Text(
                '시험장 정보를 불러오는 중...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16),
              // Shimmer 효과가 적용된 로딩 인디케이터
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                period: _shimmerDuration,
                child: Container(
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
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                period: _shimmerDuration,
                child: Container(
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
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                period: _shimmerDuration,
                child: Container(
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
        // 시험장 목록 shimmer
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            period: _shimmerDuration,
            direction: ShimmerDirection.ltr,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _shimmerItemCount,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // 이미지 shimmer - Card.outlined 스타일과 일치
                        Container(
                          width: 100,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 제목 shimmer - 실제 텍스트와 유사한 크기
                              Container(
                                height: 18,
                                width: _getShimmerWidth(index, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 6),
                              // 전화번호 shimmer - 파란색 텍스트와 유사
                              Container(
                                height: 16,
                                width: _getShimmerWidth(index, 1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 6),
                              // 주소 shimmer - 2줄로 현실적 표현
                              Container(
                                height: 14,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 2),
                              Container(
                                height: 14,
                                width: _getShimmerWidth(index, 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(height: 4),
                              // 거리 shimmer - 녹색 텍스트와 유사
                              Container(
                                height: 14,
                                width: _getShimmerWidth(index, 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Shimmer 너비 계산을 위한 헬퍼 메서드 - 최적화된 버전
  double _getShimmerWidth(int index, int type) {
    // 더 자연스러운 너비 변화를 위해 다양한 패턴 사용
    final patterns = {
      0: [double.infinity, 220.0, 180.0, 200.0, 240.0, 160.0], // 제목
      1: [140.0, 130.0, 150.0, 135.0, 145.0, 125.0], // 전화번호
      2: [220.0, 180.0, 200.0, 160.0, 240.0, 140.0], // 주소 두 번째 줄
      3: [70.0, 60.0, 65.0, 75.0, 55.0, 80.0], // 거리
    };

    final pattern = patterns[type] ?? [100.0];
    return pattern[index % pattern.length];
  }

  // 빈 상태 위젯
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            '시험장 정보를 찾을 수 없습니다',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            '위치 권한을 확인해주세요',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
