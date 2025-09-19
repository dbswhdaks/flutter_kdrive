// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdrive/component/web_view.dart';

class Teugbyeol extends StatefulWidget {
  const Teugbyeol({Key? key}) : super(key: key);

  @override
  State<Teugbyeol> createState() => _DriveList6State();
}

class _DriveList6State extends State<Teugbyeol> with TickerProviderStateMixin {
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
      length: 4,
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
                "면허정지·취소자 과정",
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
              Tab(text: "음주운전 1회자 교육"),
              Tab(text: "음주운전 2회자 교육"),
              Tab(text: "음주운전 3회자 교육"),
              Tab(text: "기타 정지 및 취소자 과정"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFirstTimeDrunkDrivingTab(),
            _buildSecondTimeDrunkDrivingTab(),
            _buildThirdTimeDrunkDrivingTab(),
            _buildOtherSuspensionCancellationTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstTimeDrunkDrivingTab() {
    return _buildTabContent([
      _buildInfoCard(
          "음주운전 1회자 교육", Icons.warning_amber_rounded, _kWarningColor),
      _buildActionCard(
        '교육 일정 확인 및 예약',
        Icons.open_in_new_outlined,
        _kPrimaryColor,
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/eduSeSpecial/eduSeSpecialExmDayLocalNoneM.do',
          '교육 일정 확인',
        ),
      ),
      _buildSectionCard(
          "교육목표",
          [
            "음주 문화의 이해와 음주운전의 심각성을 인식할 수 있다.",
            "알코올이 운전행동에 미치는 영향을 통해 음주운전의 위험성을 인식할 수 있다.",
            "일반적인 음주운전의 유형을 이해하고 음주운전예방을 위한 실천계획을 수립할 수 있다.",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육대상",
          [
            "과거 5년 이내(마지막 적발일 기준) 1회 음주운전을 한 사람",
            "(예)과거 2009.04.01 / 2011.05.30 총 2번의 음주운전 이후 2021.07.01 다시 음주운전에 적발되었을 경우 음주운전 전력은 총 3회이지만 교육은 음주운전 1회자 교육 대상자에 해당",
          ],
          _kSecondaryColor),
      _buildWarningCard("면허정지·취소자는 반드시 경찰서 출석 및 면허증 반납 후 교육 수강 가능"),
      _buildSectionCard(
          "교육시간",
          [
            "총 3회, 12시간 교육 / 1회당 4시간",
            "음주진단반 4시간 + 음주공통 1차반 4시간 + 음주공통 2차반 4시간",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "교육커리큘럼(교육순서)",
          [
            "1회차: 음주진단반 (4시간) → 2회차: 음주공통 1차반 (4시간) → 3회차: 음주공통 2차반 (4시간) → 면허정지자 → 2차 현장참여교육 (30일 추가감경가능)",
            "1회차: 음주진단반 (4시간) → 2회차: 음주공통 1차반 (4시간) → 3회차: 음주공통 2차반 (4시간) → 면허취소자 → 교육종료(면허취득 자격부여)",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육이수 혜택",
          [
            "면허정지자 : 면허정지일수 20일 감경(단, 이의심의위원회, 행정심판, 행정소송으로 감경된 경우 제외)",
            "면허취소자 : 운전면허 취득을 위한 필수 과정",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "수강신청 절차",
          [
            "1. 교육통지서에 명시된 자신의 해당 교육반을 확인 후, 홈페이지에서 사전에 예약",
            "2. 교육시간 10분 전까지 교육장 방문 후 본인확인용 신분증을 접수창구에 제출하여 교육 접수",
            "3. 교재의 좌석번호 부여 받은 후, 해당 강의실의 지정된 좌석에서 수강",
            "4. 교육이수 후 한국도로교통공단 홈페이지에서 교육이수증 출력(모바일 홈페이지에서 교육이수증 표출 기능 사용 가능)",
          ],
          _kSecondaryColor),
      _buildWarningCard("본 교육은 법정교육으로 교육시간 이후 교육접수 불가"),
      _buildSectionCard(
          "준비물",
          [
            "수강료 : 1회당(4시간)32,000원×3회",
            "본인확인용 신분증(주민등록증, 여권, 그 외 사진·생년월일·성명이 명확하게 기재되어 있는 여타 공공기관 발행 신분증 등)",
          ],
          _kSecondaryColor),
      _buildWarningCard("임시운전면허증은 신분증으로 인정 불가"),
    ]);
  }

  Widget _buildSecondTimeDrunkDrivingTab() {
    return _buildTabContent([
      _buildInfoCard(
          "음주운전 2회자 교육", Icons.warning_amber_rounded, _kWarningColor),
      _buildActionCard(
        '교육 일정 확인 및 예약',
        Icons.open_in_new_outlined,
        _kPrimaryColor,
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/eduSeSpecial/eduSeSpecialExmDayLocalNoneM.do',
          '교육 일정 확인',
        ),
      ),
      _buildSectionCard(
          "교육목표",
          [
            "문제음주가 음주운전에 미치는 영향을 알 수 있다.",
            "음주운전 재발의 원인과 유형, 심리적 특성을 이해할 수 있다.",
            "운전 성격 진단 및 분석을 통해 음주운전 예방 방법을 수립할 수 있다.",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육대상",
          [
            "과거 5년 이내(마지막 적발일 기준) 2회 음주운전을 한 사람",
            "(예) 과거 2009.04.04 / 2019.06.01 총 2번의 음주운전 이후 2021.07.01 다시 음주운전에 적발되었을 경우 음주운전 전력은 총 3회이지만 교육은 음주운전 2회자 교육 대상자에 해당",
          ],
          _kSecondaryColor),
      _buildWarningCard("※ 면허취소자는 반드시 경찰서 출석 및 면허증 반납 후 교육 수강 가능"),
      _buildSectionCard(
          "교육시간",
          [
            "총 4회, 16시간 교육 / 1회당 4시간",
            "음주공통 1차반 4시간 + 음주공통 2차반 4시간 + 음주기본 1차반 4시간 + 음주기본 2차반 4시간",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "교육커리큘럼(교육순서)",
          [
            "면허취소자",
            "1회차 : 음주공통 1차반 (4시간) → 2회차 : 음주공통 2차반 (4시간) → 3회차 : 음주기본 1차반 (4시간) → 4회차 : 음주기본 2차반 (4시간) → 교육종료(면허취득 자격부여)",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육이수 혜택",
          [
            "운전면허 취득을 위한 필수 과정",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "수강신청 절차",
          [
            "1. 교육통지서에 명시된 자신의 해당 교육반을 확인 후, 홈페이지에서 사전에 예약",
            "2. 교육시간 10분 전까지 교육장 방문 후 본인확인용 신분증을 접수창구에 제출하여 교육 접수",
            "3. 교재의 좌석번호 부여 받은 후, 해당 강의실의 지정된 좌석에서 수강",
            "4. 교육이수 후 한국도로교통공단 홈페이지에서 교육이수증 출력(모바일 홈페이지에서 교육이수증 표출 기능 사용 가능)",
          ],
          _kSecondaryColor),
      _buildWarningCard("본 교육은 법정교육으로 교육시간 이후 교육접수 불가"),
      _buildSectionCard(
          "준비물",
          [
            "수강료 : 1회당(4시간)32,000원×4회",
            "본인확인용 신분증(주민등록증, 여권, 그 외 사진·생년월일·성명이 명확하게 기재되어 있는 여타 공공기관 발행 신분증 등)",
          ],
          _kSecondaryColor),
      _buildWarningCard("임시운전면허증은 신분증으로 인정 불가"),
    ]);
  }

  Widget _buildThirdTimeDrunkDrivingTab() {
    return _buildTabContent([
      _buildInfoCard(
          "음주운전 3회자 교육", Icons.warning_amber_rounded, _kWarningColor),
      _buildActionCard(
        '교육 일정 확인 및 예약',
        Icons.open_in_new_outlined,
        _kPrimaryColor,
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/eduSeSpecial/eduSeSpecialExmDayLocalNoneM.do',
          '교육 일정 확인 및 예약',
        ),
      ),
      _buildSectionCard(
          "교육목표",
          [
            "음주운전의 위험요인과 교통사고 간의 인과관계에 대해서 인식할 수 있다.",
            "음주운전의 위험성을 체험하고, 상담프로그램을 통해 음주운전 재발 방지를 위한 계획을 수립해 실천할 수 있다.",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육대상",
          [
            "과거 5년 이내에(마지막 적발일 기점) 음주운전 전력이 총 3회인 경우",
            "(예) 과거 2009.04.01 / 2018.09.01. / 2019.06.01 총 3번의 음주운전 이후 2021.07.01 다시 음주운전에 적발되었을 경우 음주운전 경력은 총 4번이지만 교육은 음주운전 3회자 교육 대상자에 해당",
          ],
          _kSecondaryColor),
      _buildWarningCard("면허취소자는 반드시 경찰서 출석 및 면허증 반납 후 교육 수강 가능"),
      _buildSectionCard(
          "교육시간",
          [
            "총 12회, 48시간 교육 / 1회당 4시간",
            "음주공통 1차반 4시간 + 음주공통 2차반 4시간 + 음주기본 1차반 4시간 + 음주기본 2차반 4시간+ 음주심화 1~8차반 32시간(각 회차별 4시간)",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "교육커리큘럼(교육순서)",
          [
            "1회차 : 음주공통 1차반 (4시간) → 2회차 : 음주공통 2차반 (4시간) → 3회차 : 음주기본 1차반 (4시간) → 4회차 : 음주기본 2차반 (4시간) → 5~12회차 : 음주심화 1-8차반 (각 회차별 4시간/32시간)",
            "교육순서대로만 수강이 가능하며, 각 교육별(회차별) 다른 지역교육장에서 수강 가능",
            "단, 음주심화반의 경우 1~4차와 5~8차 교육을 반드시 동일 교육장에서 수강해야 함",
            "음주심화반 예약시 원하는 달의 음주심화 1차와 5차 날짜에 한번씩만 예약을 하면 됨 (매주 1회 실시)",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육이수 혜택",
          [
            "운전면허 취득을 위한 필수 과정",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "수강신청 절차",
          [
            "1. 교육통지서에 명시된 자신의 해당 교육반을 확인 후, 홈페이지에서 사전에 예약",
            "2. 교육시간 10분전 까지 교육장 방문 후 본인확인용 신분증, 교육수강료(음주심화1~8차반에 한정) 등을 접수창구에 제출하여 교육 접수",
            "3. 교재의 좌석번호 부여 받은 후, 해당 강의실의 지정된 좌석에서 수강",
            "4. 교육이수 후 한국도로교통공단 홈페이지에서 교육이수증 출력(모바일 홈페이지에서 교육이수증 표출 기능 사용 가능)",
          ],
          _kSecondaryColor),
      _buildWarningCard("본 교육은 법정교육으로 교육시간 이후 교육접수 불가"),
      _buildSectionCard(
          "준비물",
          [
            "수강료 : 1회당(4시간)32,000원×12회",
            "본인확인용 신분증(주민등록증, 여권, 그 외 사진·생년월일·성명이 명확하게 기재되어 있는 여타 공공기관 발행 신분증 등)",
          ],
          _kSecondaryColor),
      _buildWarningCard("임시운전면허증은 신분증으로 인정 불가"),
    ]);
  }

  Widget _buildOtherSuspensionCancellationTab() {
    return _buildTabContent([
      _buildInfoCard(
          "음주운전 이외 운전면허 정지.취소자 과정", Icons.info_outline, _kPrimaryColor),

      // 법규준수교육
      _buildSubSectionTitle("법규준수교육"),
      _buildSectionCard(
          "교육목표",
          [
            "교통법규 준수의 중요성을 인식하고 법규 위반의 동기와 태도, 잘못된 운전행동을 스스로 개선하여 준법운전 및 교통사고를 예방할 수 있는 운전자 양성",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육대상",
          [
            "교통사고와 법규위반(난폭운전 포함) 등으로 운전면허가 정지·취소된 경우 또는 어린이보호구역 내 어린이 사상사고를 유발한 경우",
            "2018.04.25 이후 법규준수교육(권장) 이수자는 1년 이내 동일 교육 수강 불가",
            "ex) 신호위반 1회, 중앙선 침범 1회로 2018년 06월 30일 법규준수교육 이수 시 2019년 06월 30일까지 동일 교육 수강 불가",
          ],
          _kSecondaryColor),
      _buildWarningCard("면허정지•취소자는 반드시 경찰서 출석 및 면허증 반납 후 교육수강 가능"),
      _buildSectionCard(
          "교육시간",
          [
            "6시간 (강의 4시간 / 진단 및 해설 1시간 / 시청각 1시간)",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "교육이수 혜택",
          [
            "면허정지자 : 면허정지일수 20일 감경(단, 이의심의위원회, 행정심판, 행정소송으로 감경된 경우 제외)",
            "면허취소자 : 운전면허 취득을 위한 필수 과정",
            "어린이 보호구역 내 어린이 사상사고자 : 40점 미만 벌점 보유 시 처분 벌점 최대 20점 감경",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "수강신청 절차",
          [
            "1. 교육통지서에 명시된 자신의 해당 교육반을 확인 후, 홈페이지에서 사전에 예약",
            "2. 교육시간 20분 전까지 교육장 방문 후 본인확인용 신분증, 교육수강료 등을 접수창구에 제출하여 교육 접수",
            "3. 교재와 좌석번호를 부여 받은 후, 해당 강의실의 지정된 좌석에서 수강",
            "4. 교육 이수 후 한국도로교통공단 홈페이지에서 교육이수증 출력(모바일 홈페이지에서 교육이수증 표출 기능 사용 가능)",
          ],
          _kSecondaryColor),
      _buildWarningCard("본 교육은 법정교육으로 교육시작 이후 교육장 입장불가"),
      _buildSectionCard(
          "준비물",
          [
            "수강료 : 48,000원",
            "본인확인용 신분증(주민등록증, 여권, 그 외 사진·생년월일·성명이 명확하게 기재되어 있는 여타 공공기관 발행 신분증 등)",
          ],
          _kSecondaryColor),
      _buildWarningCard("임시운전면허증은 신분증으로 인정 불가"),

      // 배려운전교육
      _buildSubSectionTitle("배려운전교육"),
      _buildSectionCard(
          "교육목표",
          [
            "보복운전에 대한 이해와 보복운전의 심각성을 인식할 수 있다.",
            "보복운전의 위험요인과 교통안전간의 인과관계에 대해서 인식할 수 있다.",
            "보복운전의 위험성을 학습하고, 상담프로그램을 통해 보복운전 재발 방지를 위한 계획을 수립해 실천할 수 있다.",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육대상",
          [
            "보복운전으로 운전면허가 정지·취소된 경우",
          ],
          _kSecondaryColor),
      _buildWarningCard("면허정지· 취소자는 반드시 경찰서 출석 및 면허증 반납 후 교육 수강 가능"),
      _buildSectionCard(
          "교육시간",
          [
            "6시간 (상담 5시간 / 강의 및 시청각 1시간)",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "교육이수 혜택",
          [
            "면허정지자 : 면허정지일수 20일 감경(단, 이의심의위원회, 행정심판, 행정소송으로 감경된 경우 제외)",
            "면허취소자 : 운전면허 취득을 위한 필수 과정",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "수강신청 절차",
          [
            "1. 교육통지서에 명시된 자신의 해당 교육반을 확인 후, 홈페이지에서 사전에 예약",
            "2. 교육시간 20분 전까지 교육장 방문 후 본인확인용 신분증, 교육수강료 등을 접수창구에 제출하여 교육 접수",
            "3. 교재와 좌석번호를 부여 받은 후, 해당 강의실의 지정된 좌석에서 수강",
            "4. 교육 이수 후 한국도로교통공단 홈페이지에서 교육이수증 출력(모바일 홈페이지에서 교육이수증 표출 기능 사용 가능)",
          ],
          _kSecondaryColor),
      _buildWarningCard("본 교육은 법정교육으로 교육시작 이후 교육장 입장불가"),
      _buildSectionCard(
          "준비물",
          [
            "수강료 : 48,000원",
            "본인확인용 신분증(주민등록증, 여권, 그 외 사진·생년월일·성명이 명확하게 기재되어 있는 여타 공공기관 발행 신분증 등)",
          ],
          _kSecondaryColor),
      _buildWarningCard("임시운전면허증은 신분증으로 인정 불가"),

      // 현장참여교육
      _buildSubSectionTitle("운전면허 정지자 2차 교육과정(현장참여교육)"),
      _buildSectionCard(
          "교육목표",
          [
            "자신의 성격, 행동 등에 따른 운전 성향에 대한 자가 진단 및 평가로 자신의 운전태도와 운전행동에 대한 객관적인 인식을 하게 한다.",
            "음주운전을 하기까지의 단계별 심리 및 태도 분석을 통하여, 음주운전이 치명적인 결과를 초래하게 된다는 사실을 명확히 인식하게 한다.",
            "도로, 차량, 교통환경 속에 잠재된 위험요소를 이해시키고, 교통사고의 원인에 대한 체계적인 지식을 습득하여 교통사고 재발방지와 예방 능력을 갖추게 한다.",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육대상",
          [
            "운전면허 정지처분을 받아 특별교통안전교육(1차)를 이수한 사람 중 희망자",
          ],
          _kSecondaryColor),
      _buildWarningCard("현장참여교육 이수자는 1년 이내 동일 교육 수강 불가"),
      _buildSectionCard(
          "교육시간",
          [
            "8시간 (현장체험활동 등 4시간 / 강의 및 시청각 4시간)",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "교육이수 혜택",
          [
            "면허정지일수 30일 추가감경(단, 이의심의위원회, 행정심판, 행정소송으로 감경된 경우 제외)",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "수강신청 절차",
          [
            "1. 특별교통안전교육(1차) 이수 후, 홈페이지에서 사전 예약",
            "특별교통안전교육(1차) 이수 전에 예약을 할 경우, 2차인증을 통한 교육반 대상자 조회가 안될 수 있습니다.",
            "2. 교육시간 20분 전까지 교육장 방문 후 본인확인용 신분증, 교육수강료 등을 접수창구에 제출하여 교육 접수",
            "본 교육은 법정교육으로 교육시작 이후 교육장 입장불가",
            "3. 교재와 좌석번호를 부여 받은 후, 해당 강의실의 지정된 좌석에서 수강",
            "4. 교육 이수 후 한국도로교통공단 홈페이지에서 교육이수증 출력(모바일 홈페이지에서 교육이수증 표출 기능 사용 가능)",
          ],
          _kSecondaryColor),
      _buildSectionCard(
          "준비물",
          [
            "수강료 : 64,000원",
            "본인확인용 신분증(주민등록증, 여권, 그 외 사진·생년월일·성명이 명확하게 기재되어 있는 여타 공공기관 발행 신분증 등)",
          ],
          _kSecondaryColor),
      _buildWarningCard("임시운전면허증은 신분증으로 인정 불가"),

      // 벌점감경 과정
      _buildSubSectionTitle("운전면허 벌점감경 과정"),
      _buildSectionCard(
          "교육목표",
          [
            "교통상황에 따른 자신의 처지와 책임을 자각하고 스스로 의욕을 조절할 수 있는 능력과 태도를 갖게 한다.",
            "도로교통법령의 의의와 적용범위를 이해하고, 적법행동의 습관화 태도를 갖게 한다.",
            "교통참여자로서 의사소통기술 등을 알고 타 교통참여자의 교통을 배려하는 태도를 보이게 한다.",
          ],
          _kPrimaryColor),
      _buildSectionCard(
          "교육대상",
          [
            "운전면허 정지처분을 받기 전, 벌점 40점 미만인 경우",
          ],
          _kSecondaryColor),
      _buildWarningCard("별점감경교육 이수자는 1년 이내 동일 교육 수강 불가"),
      _buildSectionCard(
          "교육시간",
          [
            "4시간 (강의 3시간 / 시청각 1시간)",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "교육이수 혜택",
          [
            "처분벌점 최대 20점 감경",
          ],
          _kSuccessColor),
      _buildSectionCard(
          "수강신청 절차",
          [
            "1. 본인의 벌점을 확인 후, 홈페이지에서 사전 예약",
            "운전면허 벌점 확인방법",
            "본인명의의 휴대폰으로 국번없이 182 전화, 공동인증서로 이파인(www.efine.go.kr) 로그인, 공단 통합민원 홈페이지 내 마이페이지 로그인, 신분증 지참 하여 경찰서 교통민원실 방문 등",
            "2. 교육시간 20분 전까지 교육장 방문 후 본인확인용 신분증, 교육수강료 등을 접수창구에 제출하여 교육 접수",
            "본 교육은 법정교육으로 교육시작 이후 교육장 입장불가",
            "3. 교재와 좌석번호를 부여 받은 후, 해당 강의실의 지정된 좌석에서 수강",
            "4. 교육 이수 후 한국도로교통공단 홈페이지에서 교육이수증 출력(모바일 홈페이지에서 교육이수증 표출 기능 사용 가능)",
          ],
          _kSecondaryColor),
      _buildSectionCard(
          "준비물",
          [
            "수강료 : 32,000원",
            "본인확인용 신분증(주민등록증, 여권, 그 외 사진·생년월일·성명이 명확하게 기재되어 있는 여타 공공기관 발행 신분증 등)",
          ],
          _kSecondaryColor),
      _buildActionCard(
        '교육 일정 확인 및 예약',
        Icons.open_in_new_outlined,
        _kPrimaryColor,
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/eduSeSpecial/eduSeSpecialExmDayLocalNoneM.do',
          '교육 일정 확인',
        ),
      ),
    ]);
  }

  // Helper methods
  void _navigateToWebView(String url, String title) {
    Get.to(WebView(url: url, title: title));
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

  Widget _buildSubSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: _kTextPrimaryColor,
        ),
      ),
    );
  }
}
