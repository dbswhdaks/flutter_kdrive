// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';

class Leejonsohyeong extends StatefulWidget {
  const Leejonsohyeong({Key? key}) : super(key: key);

  @override
  State<Leejonsohyeong> createState() => _LeejonsohyeongState();
}

class _LeejonsohyeongState extends State<Leejonsohyeong>
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
          '2종소형·원동기 (채점기준)',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // 이미지 섹션
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.asset(
                                'assets/images/leejongsohyeongcos.png',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Image.asset(
                                'assets/images/leejongsohyeong.png',
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 시험자격 카드
                      _buildInfoCard(
                        title: '시험자격',
                        icon: Icons.person,
                        color: colorScheme.primary,
                        children: [
                          _buildInfoItem('원동기 : 만 16세이상'),
                          _buildInfoItem('2종소형 : 만 18세이상'),
                          _buildInfoItem(
                              '도로교통법 제 70조의 규정에 의한 운전면허의 결격사유에 해당하지 아니한 자'),
                          _buildInfoItem(
                              '도로교통법시행령 제 45조(자동차등의 운전에 관하여 필요한 적성기준)의 규정에 합격한자'),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 준비물 카드
                      _buildInfoCard(
                        title: '준비물',
                        icon: Icons.checklist,
                        color: colorScheme.secondary,
                        children: [
                          _buildInfoItem('운전면허 신체검사표(응시원서)'),
                          _buildInfoItem('여권용 사진 1장 최근 6개월미만 (면허증 부착용)'),
                          _buildInfoItem('면허소지자 - 운전면허증(신분증),사진= 3x4 반명함 3장'),
                          _buildInfoItem(
                              '면허취소자 - 운전면허증(신분증),운전경력증명서, 응시원서(운전면허신체검사) 사진= 3x4 반명함 3장'),
                          _buildInfoItem('운전면허증 또는 신분증'),
                          _buildInfoItem('응시료 : 2종소형 = 14,000원, 원동기 = 10,000원'),
                          _buildInfoItem('운전면허증 발급 (국문, 영문 : 10,000원)'),
                          _buildInfoItem('모바일 운전면허증 발급 (국문, 영문 : 15,000원)'),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 시험방법 카드
                      _buildInfoCard(
                        title: '시험방법',
                        icon: Icons.directions_car,
                        color: colorScheme.tertiary,
                        children: [
                          _buildInfoItem(
                              '굴절코스 전진 → 곡선코스 전진 → 좁은 길 코스 통과 → 연속진로전환 코스 통과'),
                        ],
                      ),
                      const SizedBox(height: 16),

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
                      const SizedBox(height: 16),

                      // 실격기준 카드
                      _buildInfoCard(
                        title: '실격기준',
                        icon: Icons.cancel,
                        color: Colors.red,
                        children: [
                          _buildInfoItem('운전미숙으로 20초 이내에 출발하지 못한 때'),
                          _buildInfoItem('시험과제를 어느 하나라도 이행하지 아니한 때'),
                          _buildInfoItem('시험 중 안전사고를 일으키거나 코스를 벗어난 때'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // 예약 버튼
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: colorScheme.primary.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Get.to(WebView(
                              url:
                                  'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
                              title: '시험일정 확인 및 예약',
                            ));
                          },
                          icon: const Icon(Icons.calendar_today, size: 20),
                          label: const Text(
                            '시험일정 확인 및 예약',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
