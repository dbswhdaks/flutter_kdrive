// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';

// 상수 정의
class IljongbotongConstants {
  static const String title = "장내기능 및 도로주행 (채점기준)";
  static const String tab1Title = "장내기능 채점기준";
  static const String tab2Title = "도로주행 채점기준";
  static const String examScheduleUrl =
      'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121';

  // 색상 팔레트 (Material Design 3)
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color secondaryColor = Color(0xFF625B71);
  static const Color tertiaryColor = Color(0xFF7D5260);
  static const Color surfaceColor = Color(0xFFFFFBFE);
  static const Color errorColor = Color(0xFFB3261E);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);

  // 스타일 상수
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static const TextStyle sectionTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: primaryColor,
    letterSpacing: 0.3,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: secondaryColor,
    letterSpacing: 0.2,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF1C1B1F),
    height: 1.5,
  );

  static const TextStyle boldBodyStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1C1B1F),
    height: 1.5,
  );

  static const TextStyle highlightStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryColor,
    height: 1.5,
  );

  static const TextStyle successTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: successColor,
    height: 1.5,
  );

  static const TextStyle errorTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: errorColor,
    height: 1.5,
  );
}

class Iljongbotong extends StatefulWidget {
  const Iljongbotong({Key? key}) : super(key: key);

  @override
  State<Iljongbotong> createState() => _IljongbotongState();
}

class _IljongbotongState extends State<Iljongbotong>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: IljongbotongConstants.surfaceColor,
        appBar: _buildAppBar(),
        body: TabBarView(
          children: [
            _buildIndoorFunctionTab(),
            _buildRoadDrivingTab(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        IljongbotongConstants.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottom: ButtonsTabBar(
        backgroundColor: Colors.amber[600],
        unselectedBackgroundColor: Colors.white,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        splashColor: Colors.purpleAccent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        labelSpacing: 10,
        labelStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        tabs: [
          Tab(text: IljongbotongConstants.tab1Title),
          Tab(text: IljongbotongConstants.tab2Title),
        ],
      ),
    );
  }

  Widget _buildIndoorFunctionTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [IljongbotongConstants.surfaceColor, Color(0xFFF3F3F3)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIndoorFunctionImage(),
              const SizedBox(height: 24),
              _buildIndoorFunctionContent(),
              const SizedBox(height: 24),
              _buildScheduleButton(
                '장내기능 시험일정 확인 및 예약',
                Icons.schedule,
                isOutlined: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndoorFunctionImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: const Image(
        image: AssetImage('assets/images/1b2b.png'),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildIndoorFunctionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          icon: Icons.assessment,
          title: "장내기능 (채점기준)",
          children: [
            _buildInfoRow(
              Icons.check_circle,
              "각 시험 항목별 감점기준에 따라 감점결과 100점 만점에 80점 이상 합격",
              color: IljongbotongConstants.successColor,
            ),
            const SizedBox(height: 16),
            _buildWarningSection(),
          ],
        ),
      ],
    );
  }

  Widget _buildWarningSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IljongbotongConstants.errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: IljongbotongConstants.errorColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: IljongbotongConstants.errorColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "다음의 경우 실격으로 한다.",
                style: IljongbotongConstants.errorTextStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDisqualificationItems(),
        ],
      ),
    );
  }

  Widget _buildDisqualificationItems() {
    const items = [
      "특별한 사유없이 출발선에서 30초 이내 출발하지 못한때",
      "경사로코스, 방향전환코스, 기어변속구간을 어느 하나라도 이행하지 아니한 때",
      "특별한 사유없이 교차로를 30초 이내 통과하지 못한때",
      "시험중 안전사고를 일으키거나 단1회라도 차로를 벗어 났을때",
      "경사로 정지구간 이행후 30초를 초과하여 경사구간을 통과하지 못한때 또는 경사 정지구간에서 후진하여 앞 범퍼가 경사로 사면을 벗어난 때",
    ];

    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: IljongbotongConstants.errorColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: IljongbotongConstants.bodyStyle,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRoadDrivingTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [IljongbotongConstants.surfaceColor, Color(0xFFF3F3F3)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRoadDrivingImages(),
              const SizedBox(height: 24),
              _buildRoadDrivingContent(),
              const SizedBox(height: 24),
              _buildScheduleButton(
                '도로주행 시험일정 확인 및 예약',
                Icons.schedule,
                isOutlined: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoadDrivingImages() {
    const imageNames = ['doro1.png', 'doro2.png', 'doro3.png', 'doro4.png'];

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: imageNames.map((imageName) {
          return Container(
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/images/$imageName'),
              fit: BoxFit.contain,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRoadDrivingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          icon: Icons.assessment,
          title: "도로주행 (채점기준)",
          children: [
            _buildCourseSection(),
            const SizedBox(height: 20),
            _buildTestItemsSection(),
            const SizedBox(height: 20),
            _buildRoadCriteriaSection(),
            const SizedBox(height: 20),
            _buildPassCriteriaSection(),
            const SizedBox(height: 20),
            _buildFailCriteriaSection(),
            const SizedBox(height: 20),
            _buildOtherSection(),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: IljongbotongConstants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: IljongbotongConstants.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: IljongbotongConstants.sectionTitleStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color ?? IljongbotongConstants.primaryColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: color != null
                ? IljongbotongConstants.bodyStyle.copyWith(color: color)
                : IljongbotongConstants.bodyStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseSection() {
    return _buildSubsectionCard(
      icon: Icons.route,
      title: "시험코스",
      children: [
        _buildInfoRow(
          Icons.straighten,
          "총연장 5km 이상",
          color: IljongbotongConstants.highlightStyle.color,
        ),
      ],
    );
  }

  Widget _buildTestItemsSection() {
    return _buildSubsectionCard(
      icon: Icons.list_alt,
      title: "시험항목",
      children: [
        _buildInfoRow(
          Icons.checklist,
          "운전자세, 제동장치 및 조향장치 조작, 직진 및 좌.우회전, 진로변경 등 총 87개 채점 항목",
        ),
      ],
    );
  }

  Widget _buildRoadCriteriaSection() {
    return _buildSubsectionCard(
      icon: Icons.route,
      title: "도로주행시험을 실시하는\n도로의 기준",
      children: [
        _buildInfoRow(Icons.directions_car, "주행거리 5km이상 실제도로에서 실시"),
        _buildInfoRow(Icons.speed, "지시속도에 의한 주행(매시 40km) 1구간 400m"),
        _buildInfoRow(Icons.swap_horiz, "차로변경(편도 2차로 이상의 도로에서) 각 1회"),
        _buildInfoRow(Icons.turn_left, "방향전환 좌.우회전, 직진(교차로) 1회"),
        _buildInfoRow(Icons.directions_walk, "횡단보도(일시정지 및 통과) 1회"),
      ],
    );
  }

  Widget _buildPassCriteriaSection() {
    return _buildSubsectionCard(
      icon: Icons.emoji_events,
      title: "합격기준",
      children: [
        _buildInfoRow(
          Icons.check_circle,
          "70점 이상 합격",
          color: IljongbotongConstants.successColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          Icons.description,
          "시험관이 채점표에 의하여 감점방식으로 채점 2012년 11월 1일 도로주행시험 노선 및 채점에 (전자채점시스템 도입)",
        ),
      ],
    );
  }

  Widget _buildFailCriteriaSection() {
    return _buildSubsectionCard(
      icon: Icons.cancel,
      title: "실격기준",
      children: [
        _buildInfoRow(
          Icons.error,
          "3회 이상 출발블능 또는 응시자가 시험을 포기한 경우",
          color: IljongbotongConstants.errorColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          Icons.error,
          "5회 이상 '클러치 조작 불량으로 인한 엔진정지','급브레이크 사용' 또는 그 밖의 사유로 운전능력이 현저하게 부족한 것으로 인정되는 경우",
          color: IljongbotongConstants.errorColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          Icons.error,
          "교통사고 야기한 경우 또는 운전능력부족으로 일으킬 위험이 현저한 경우",
          color: IljongbotongConstants.errorColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          Icons.error,
          "교통사고 예방 및 시험 진행을 위한 시험관 지시.통제에 불응한 경우",
          color: IljongbotongConstants.errorColor,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          Icons.error,
          "보행자 보호의무 위반, 신호 또는 지시위반, 중앙선 침범 어린이 통학버스 보호의무 위반한 경우",
          color: IljongbotongConstants.errorColor,
        ),
      ],
    );
  }

  Widget _buildOtherSection() {
    return _buildSubsectionCard(
      icon: Icons.info,
      title: "기타",
      children: [
        _buildInfoRow(Icons.schedule, "연습면허 유효기간 내에 도로주행시험에 합격해야 합니다."),
        _buildInfoRow(
          Icons.note,
          "(유효기간이 지났을 경우에는 다시 PC학과시험, 장내기능시험에 합격 후에 연습면허 발급 받아야 함)",
        ),
        _buildInfoRow(
          Icons.history,
          "도로주행시험 응시 후 불합격자는(운전전문학원에서 불합격한 이력도 포함)",
        ),
        _buildInfoRow(Icons.timer, "불합격일부터 3일 경과 후에 재응시가 가능합니다."),
        _buildInfoRow(Icons.help_outline, "예) 불합격이 1일이면 4일부터 재응시 가능"),
      ],
    );
  }

  Widget _buildSubsectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: IljongbotongConstants.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: IljongbotongConstants.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: IljongbotongConstants.secondaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: IljongbotongConstants.subtitleStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
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
                  Colors.blue,
                  Colors.blue.withOpacity(0.8),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: isOutlined
            ? Border.all(
                color: Colors.blue,
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
                  color: isOutlined ? Colors.blue : Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isOutlined ? Colors.blue : Colors.white,
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
      url: IljongbotongConstants.examScheduleUrl,
      title: title,
    ));
  }
}
