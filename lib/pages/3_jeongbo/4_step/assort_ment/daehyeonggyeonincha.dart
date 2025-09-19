// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';

class Daehyeonggyeonincha extends StatefulWidget {
  const Daehyeonggyeonincha({Key? key}) : super(key: key);

  @override
  State<Daehyeonggyeonincha> createState() => _DaehyeonggyeoninchaState();
}

class _DaehyeonggyeoninchaState extends State<Daehyeonggyeonincha>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 1, vsync: this);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          '대형견인차 (채점기준)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지 섹션
          _buildImageSection(),
          const SizedBox(height: 24),

          // 정보 섹션
          _buildInfoSection(),

          const SizedBox(height: 32),

          // 예약 버튼
          _buildReservationButton(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      children: [
        Image.asset(
          'assets/images/daehyeonggyeoninchacos.png',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/daehyeonggyeonincha.png',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard('시험자격', [
          '만19세 이상으로 최초 운전면허 1,2종보통 취득후, 만 1년이상 경과되신 분',
          '도로교통법 제 70조의 규정에 의한 운전면허의 결격사유에 해당하지 아니한 자',
          '도로교통법시행령 제 45조(자동차등의 운전에 관하여 필요한 적성기준)의 규정에 합격한자',
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('준비물', [
          '운전면허 신체검사표(응시원서)',
          '여권용 사진 1장 최근 6개월미만 (면허증 부착용)',
          '면허소지자 - 운전면허증(신분증),사진= 3x4 반명함 3장',
          '면허취소자 - 신분증,운전경력증명서,응시원서 (운전면허신체검사) 사진= 3x4 반명함 3장',
          '운전면허증 또는 신분증',
          '응시료 : 25,000',
          '운전면허증 발급 (국문, 영문 : 10,000원',
          '모바일 운전면허증 발급 (국문, 영문 : 15,000원)',
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('시험방법', [
          '1) 견인차에 피견인차는 5분 이내에 연결하여 출발점에서 전진한다.',
          '2) A지점의 확인선을 접촉하고, 후진으로 B지점의 확인선을 접촉 한후 다시 A지점으로 전진하였다가 후진으로 출발지점에 도착 한다.',
          '3) 출발지점에 도착한 후 피견인차를 5분 이내에 분리 한다. 총 지정시간은 15분이내이다',
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('합격기준', [
          '각 시험 항목별 감점기준에 따라 감점한 결과 100점 만점에 90점이상을 얻은 때',
        ]),
        const SizedBox(height: 16),
        _buildInfoCard(
            '실격기준',
            [
              '출발지시를 알고 특별한 사유없이 20초 이내에 출발(후진)하지 못한 때',
              '시험과제를 어느 하나라도 이행하지 아니한 때',
              '시험 중 안전사고를 일으키거나 코스를 벗어난 때',
            ],
            isDisqualification: true),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<String> items,
      {bool isDisqualification = false}) {
    return Card(
      elevation: 0.1,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isDisqualification ? Colors.red : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            ...items
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        item,
                        style: const TextStyle(
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

  Widget _buildReservationButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          Get.to(() => WebView(
                url:
                    'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
                title: '시험일정 확인 및 예약',
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF4A90E2),
                Color(0xFF357ABD),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_today,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              const Text(
                '시험일정 확인 및 예약',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
