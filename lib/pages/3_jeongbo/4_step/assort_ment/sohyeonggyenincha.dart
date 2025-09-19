// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';

class Sohyeonggyeonincha extends StatefulWidget {
  const Sohyeonggyeonincha({Key? key}) : super(key: key);

  @override
  State<Sohyeonggyeonincha> createState() => _SohyeonggyeoninchaState();
}

class _SohyeonggyeoninchaState extends State<Sohyeonggyeonincha>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 1, vsync: this);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '소형견인차 (채점기준)',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // 이미지 섹션
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/gunanchacos.png',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  'assets/images/sohyeonggyeonincha.png',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // 시험자격 카드
                        _buildInfoCard(
                          title: '시험자격',
                          icon: Icons.person,
                          children: [
                            _buildInfoItem(
                                '만19세 이상으로 최초 운전면허 1,2종보통 취득후, 만 1년이상 경과되신 분'),
                            _buildInfoItem(
                                '도로교통법 제 70조의 규정에 의한 운전면허의 결격사유에 해당하지 아니한 자'),
                            _buildInfoItem(
                                '도로교통법시행령 제 45조(자동차등의 운전에 관하여 필요한 적성기준)의 규정에 합격한자'),
                          ],
                        ),

                        SizedBox(height: 16),

                        // 준비물 카드
                        _buildInfoCard(
                          title: '준비물',
                          icon: Icons.checklist,
                          children: [
                            _buildInfoItem('운전면허 신체검사표(응시원서)'),
                            _buildInfoItem('여권용 사진 1장 최근 6개월미만 (면허증 부착용)'),
                            _buildInfoItem('면허소지자 - 운전면허증(신분증),사진= 3x4 반명함 3장'),
                            _buildInfoItem(
                                '면허취소자 - 운전면허증(신분증),운전경력증명서,응시원서(운전면허신체검사) 사진= 3x4 반명함 3장'),
                            _buildInfoItem('운전면허증 또는 신분증'),
                            _buildInfoItem('응시료 : 25,000원',
                                isHighlighted: true),
                            _buildInfoItem('운전면허증 발급 (국문, 영문 : 10,000원)'),
                            _buildInfoItem('모바일 운전면허증 발급 (국문, 영문 : 15,000원)'),
                          ],
                        ),

                        SizedBox(height: 16),

                        // 시험방법 카드
                        _buildInfoCard(
                          title: '시험방법',
                          icon: Icons.directions_car,
                          children: [
                            _buildInfoItem(
                                '소형 견인 트레일러 면허시험은 1톤 화물트럭에 평판형 트레일러를 연결해 치르게 되며, 시험코스는 굴절.곡선 방향전환등 3개 코스로 이루어져 있습니다.'),
                            _buildInfoItem(
                                '굴절코스 : 지정시간 3분 초과시 마다 또는 검지선 접촉 시 마다 10점 감점'),
                            _buildInfoItem(
                                '곡선코스 : 지정시간 3분 초과시 마다 또는 검지선 접촉 시 마다 10점 감점'),
                            _buildInfoItem(
                                '방향전환코스 : 확인선을 미접촉하거나 지정시간 3분 초과시마다 또는 검지선 접촉시마다 10점 감점'),
                          ],
                        ),

                        SizedBox(height: 16),

                        // 합격기준 카드
                        _buildInfoCard(
                          title: '합격기준',
                          icon: Icons.emoji_events,
                          color: Colors.green,
                          children: [
                            _buildInfoItem(
                                '각 시험 항목별 감점기준에 따라 감점한 결과 100점 만점에 90점이상을 얻은 때'),
                          ],
                        ),

                        SizedBox(height: 16),

                        // 실격기준 카드
                        _buildInfoCard(
                          title: '실격기준',
                          icon: Icons.cancel,
                          color: Colors.red,
                          children: [
                            _buildInfoItem(
                                '출발지시를 알고 특별한 사유없이 20초 이내에 출발 (후진)하지 못한 때'),
                            _buildInfoItem('시험과제를 어느 하나라도 이행하지 아니한 때'),
                            _buildInfoItem('시험 중 안전사고를 일으키거나 코스를 벗어난 때'),
                          ],
                        ),

                        SizedBox(height: 24),

                        // 예약 버튼
                        _buildScheduleButton(
                          '소형견인차 시험일정 확인 및 예약',
                          Icons.calendar_today,
                          isOutlined: false,
                        ),

                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
    Color? color,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (color ?? Colors.blue).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color ?? Colors.blue,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: color ?? Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text, {bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6, right: 8),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: isHighlighted ? Colors.orange : Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isHighlighted
                    ? Colors.orange.shade700
                    : Colors.grey.shade700,
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleButton(String title, IconData icon,
      {required bool isOutlined}) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isOutlined
              ? [Colors.white, Colors.white]
              : [
                  Colors.blue.shade600,
                  Colors.blue.shade600.withOpacity(0.8),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: isOutlined
            ? Border.all(
                color: Colors.blue.shade600,
                width: 2,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _navigateToSchedule(title),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isOutlined ? Colors.blue.shade600 : Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isOutlined ? Colors.blue.shade600 : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSchedule(String title) {
    Get.to(WebView(
      url:
          'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
      title: title,
    ));
  }
}
