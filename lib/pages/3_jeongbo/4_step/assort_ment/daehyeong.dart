// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';

class Daehyeong extends StatefulWidget {
  const Daehyeong({Key? key}) : super(key: key);

  @override
  State<Daehyeong> createState() => _DaehyeongState();
}

class _DaehyeongState extends State<Daehyeong> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 1, vsync: this);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          '1종대형(채점기준)',
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
          'assets/images/daehyeongcos.png',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/daehyong.png',
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
          '만19세 이상으로 최초 운전면허 1,2종보통 취득후 만 1년이상 경과되신 분',
          '도로교통법 제 70조의 규정에 의한 운전면허의 결격사유에 해당하지 아니한 자',
          '도로교통법시행령 제 45조(자동차등의 운전에 관하여 필요한 적성기준)의 규정에 합격한자',
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('준비물', [
          '운전면허 신체검사표(응시원서)',
          '여권용 사진 1장 최근 6개월미만 (면허증 부착용)',
          '면허소지자 - 운전면허증(신분증),사진=3x4 반명함 3장',
          '면허취소자 - 운전면허증(신분증),운전경력 증명서,응시원서(운전면허신체검사) 사진= 3x4 반명함 3장',
          '운전면허증 또는 신분증',
          '응시료 : 25,000',
          '운전면허증 발급 (국문, 영문 : 10,000원',
          '모바일 운전면허증 발급 (국문, 영문 : 15,000원)',
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('시험방법', [
          '좌측방향지시등을 켜고 출발 한다. 삐소리가 나면 바로 방향지시등을 끈다. 횡단보도 일시정지 후 약 3초 후에 출발한다. '
              '언덕 위.아래 흰색 정지선 안에 정지후 기어를 1단으로 변속하고 약 3초 후에 출발한다. '
              '그 다음은 굴절코스 다음은 교차로 녹색신호에 직진하여 곡선코스로 진입. 통과후 교차로 녹색신호시 '
              '직진한 다음 방향전환 코스로 진입. 통과후 교차로에서 좌회전 신호를 받고 좌회진 그 다음은 철길 건널목 '
              '정지선 정지 후 약 3초 후에 출발 다음은 기어변속구간 입니다. 2단으로 출발해서 20킬로 미터를 '
              '넘기면 바로 3단변속 후 바로 속도를 20킬로 미만으로 줄이고 기어를 2단으로 변속한다. 다음은 주차코스는 '
              '후진 으로 진입.통과후 교차로 우회전 (우측 방향 지시등 을 켜고) 종료 직전 약 5m이전에 우측방향지시등을 '
              '켜고 종료한다. 전체 코스 이동중 돌발상황이 나옵니다.(기어변속구간 제외) 급정지 하시고 최대한 빨리 '
              '비상등을 켜세요. 그리고 돌발 상황이 지나면 비상을을 끄고 출발 약 3초 후 출발 하세요.바로 출발하면 감점 될수 있습니다.',
          '굴절코스 : 지정시간 2분 초과시 마다 또는 검지선 접촉 시 마다 5점 감점',
          '곡선코스 : 지정시간 2분 초과시 마다 또는 검지선 접촉 시 마다 5점 감점',
          '방향전환코스 : 확인선을 미접촉하거나 지정시간 2분 초과 시 마다 또는 검지선 접촉시 마다 5점 감점',
          '주차코스 : 확인선을 미접촉하거나 지정시간 2분 초과 시 마다 또는 검지선 접촉시 마다 5점 감점, 주차 확인선 미접촉시 10점 감점(앞.뒷바퀴가 흰색 주차선 미접촉시)',
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('합격기준', [
          '각 시험 항목별 감점기준에 따라 감점한 결과 100점 만점에 80점이상을 얻은 때',
        ]),
        const SizedBox(height: 16),
        _buildInfoCard(
            '실격기준',
            [
              '1) 특별한 사유없이 출발선에서 30초 이내 출발하지 못한 때',
              '2) 경사로코스,굴절코스,곡선코스,방향전환코스, 기어변속코스 및 평행주차 코스를 어느 하나라도 이행하지 아니한 때',
              '3) 특별한 사유없이 교차로를 30초 이내에 통과하지 아니한 때',
              '4) 시험중 안전사고를 일으키거나 단 1회라도 차로를 벗어날 때',
              '5) 경사로 정지구간 이행 후 30초를 초과하여 경사구간을 통과하지 못한 때 또는 경사정지구간에서 후진하여 앞 범퍼가 경사로 사면을 벗어난 때',
              '6) 주차 브레이크를 해제하지 않고 주행한 때',
              '7) 안전벨트를 착용하지 않고 주행한 때',
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Get.to(() => WebView(
                    url:
                        'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
                    title: '시험일정 확인 및 예약',
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    '시험일정 확인 및 예약',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
