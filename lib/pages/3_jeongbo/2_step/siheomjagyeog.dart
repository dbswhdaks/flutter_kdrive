// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, unused_field

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class Siheomjagyeog extends StatefulWidget {
  const Siheomjagyeog({Key? key}) : super(key: key);

  @override
  State<Siheomjagyeog> createState() => _DriveList2State();
}

class _DriveList2State extends State<Siheomjagyeog> {
  // 상수 정의로 메모리 최적화
  static const _kAppBarColor = Color(0xFF1976D2);
  static const _kHeaderColor = Color(0xFFF5F5F5);
  static const _kBorderRadius = 12.0;
  static const _kCardBorderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 0,
          title: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                "시험자격/결격/면제",
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
              Tab(text: "시험 면제"),
              Tab(text: "운전면허 결격사유"),
              Tab(text: "응시 제한"),
              Tab(text: "시험자격"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildExamExemptionTab(),
            _buildDisqualificationTab(),
            _buildRestrictionTab(),
            _buildQualificationTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildExamExemptionTab() {
    return _buildTabContent([
      _buildInfoCard("시험 면제", Icons.assignment_turned_in_outlined),
      _buildSectionCard("대상자", [
        "국내 면허 인정 국가의 권한 있는 기관에서 교부한 운전면허증 소지자 제2종 보통면허 신체검사 ● 학과+기능+주행=면제"
      ]),
      _buildSectionCard(
          "합격기준", ["70점 (1종보통,1종대형,1종특수,대형견인,소형견인,구난차)", "60점 (2종보통,2종소형,원동기)"],
          isImportant: true),
      _buildSectionCard("준비물", [
        "응시원서(신체검사 완료 또는 건강검진 결과서 조회.제출)",
        "신청일로부터 6개월 내에 모자를 벗은 상태에서 배경 없이 촬영된 3.5X4.5cm 규격의 상반신 컬러사진 (허용되는 사진규격) 3매",
        "신분증 (신분증 인정 범위)"
      ]),
      _buildSectionCard("시험내용", ["안전운전에 필요한 교통법규 등 공개된 학과시험 문제은행 중 40문제 출제"]),
      _buildSectionCard("결과발표", [
        "시험 종료 즉시 컴퓨터 모니터에 획득 점수 및 합격 여부 표시",
        "합격 또는 불합격도장이 찍힌 응시원서를 돌려받아 본인이 보관",
        "1년경과 시 기존 원서 폐기 후 학과시험부터 신규 접수하여야 하며 이때 교통안전교육 재수강은 불필요"
      ]),
      _buildSectionCard("응시가능언어", ["한국어, 영어, 중국어, 베트남어"]),
      _buildSectionCard("비문해자를 위한 PC학과시험",
          ["시험문제와 보기를 음성으로 들을 수 있는 PC학과시험 시험시간 총 80분", "민원실에서 접수 시 신청 가능"]),
      _buildSectionCard("청각장애인을 위한 수화 PC학과시험",
          ["청각장애인이면서 비문해자를 위한 수화로 보는 PC학과시험", "시험시간 총 80분, 민원실에서 접수 시 신청 가능"]),
    ]);
  }

  Widget _buildDisqualificationTab() {
    return _buildTabContent([
      _buildInfoCard("운전면허 결격사유", Icons.block_outlined),
      _buildWarningCard("다음에 해당하는 사람은 운전면허를 받을 수 없습니다."),
      _buildSectionCard("연령.경력", [
        "18세 미만인 사람(원동기장치 자전거의 경우에는 16세 미만)",
        "제1종 대형면허 또는 제1종 특수면허를 받고자 하는 사람이 19세 미만이거나 자동차(이륜자동차와 원동기장치자전거를 제외한다)의 운전 경험이 1년 미만인 사람"
      ]),
      _buildSectionCard("정신질환 등", [
        "교통상의 위험과 장해를 일으킬 수 있는 정신질환(치매, 조현병, 분열성 정동장애, 양극성 정동장애, 재발성 우울장애 등), 정신발육 지연, 뇌전증, 마약·대마·향정신성의약품 또는 알코올 관련 장애 등으로 인하여 정상적인 운전을 할 수 없다고 해당 분야 전문의가 인정하는 사람"
      ]),
      _buildSectionCard("신체조건", [
        "듣지 못하는 사람(제1종 대형·특수 운전면허에 한함)",
        "앞을 보지 못하는 사람(한쪽 눈만 보지 못하는 사람의 경우에는 제1종 운전면허 중 대형·특수 운전면허에 한함)",
        "다리, 머리, 척추, 그 밖의 신체의 장애로 인하여 앉아 있을 수 없는 사람",
        "양쪽 팔의 팔꿈치 관절 이상을 잃은 사람",
        "양쪽 팔을 전혀 쓸 수 없는 사람 (다만, 신체장애 정도에 적합하게 제작·승인된 자동차를 사용하여 정상적인 운전을 할 수 있는 경우는 제외)"
      ]),
    ]);
  }

  Widget _buildRestrictionTab() {
    return _buildTabContent([
      _buildInfoCard("응시 제한", Icons.access_time_outlined),
      _buildWarningCard(
          "운전면허 행정처분 시 또는 기타 도로교통법 위반시 이의 경중에 따라 일정 기간 응시하지 못하게 하는 제도 입니다."),
      _buildPeriodCard("5년 제한",
          ["무면허, 음주운전, 약물복용, 과로 운전, 공동위험행위 중 사상사고 야기 후 필요한 구호조치를 하지 않고 도주"]),
      _buildPeriodCard("4년 제한", ["5년 제한 이외의 사유로 사상사고 야기 후 도주"]),
      _buildPeriodCard("3년 제한",
          ["음주운전을 하다가 2회 이상 교통사고를 야기", "자동차 이용 범죄, 자동차 강·절취한 자가 무면허로 운전한 경우"]),
      _buildPeriodCard("2년 제한", [
        "3회 이상 무면허운전",
        "운전면허시험 대리 응시를 한 경우",
        "운전면허시험 대리 응시를 하고 원동기면허를 취득하고자 하는 경우",
        "공동위험행위로 2회 이상으로 면허취소 시",
        "부당한 방법으로 면허 취득 또는 이용, 운전면허시험 대리 응시",
        "다른 사람의 자동차를 강·절취한 자",
        "음주운전 2회 이상, 측정 불응 2회 이상 자",
        "음주운전, 측정불응을 하다가 교통사고를 일으킨 경우",
        "운전면허시험, 전문학원 강사자격시험, 기능검정원 자격시험에서 부정행위를 하여 해당 시험이 무효로 처리된 자"
      ]),
      _buildWarningCard("도로교통법 제84조의2(부정행위자에 대한 조치)"),
      _buildPeriodCard("1년 제한", [
        "무면허운전",
        "공동위험행위로 운전면허가 취소된 자가 원동기면허를 취득하고자 하는 경우",
        "자동차 이용 범죄",
        "2년 제한 이외의 사유로 면허가 취소된 경우"
      ]),
      _buildPeriodCard(
          "6개월 제한", ["단순 음주, 단순 무면허, 자동차이용범죄로 면허취소 후 원동기면허를 취득하고자 하는 경우"]),
      _buildPeriodCard("바로 면허시험에 응시 가능한 경우",
          ["적성검사 또는 면허 갱신 미필자", "2종에 응시하는 1종 면허 적성검사 불합격자"]),
    ]);
  }

  Widget _buildQualificationTab() {
    return _buildTabContent([
      _buildInfoCard("시험자격", Icons.verified_user_outlined),
      _buildSectionCard("면허종류", [
        "제1종 대형·특수면허 : 만19세 이상으로 1,2종 보통면허 취득 후 1년 이상인 자",
        "제1종 보통·2종 보통·2종 소형면허 : 만18세 이상인 자",
        "제2종 원동기장치 자전거 면허 : 만16세 이상인 자",
        "제1종·2종 장애인 면허 : 장애인 운동능력측정시험 합격자, 1종을 취득하기 위해서는 1종에 부합되는 합격자"
      ]),
      _buildSectionCard(
          "신체검사기준",
          [
            "제1종 면허 : 두 눈을 동시에 뜨고 잰 시력 0.8 이상, 두 눈의 시력이 각각 0.5 이상",
            "제 2종 면허 : 두 눈을 동시에 뜨고 잰 시력이 0.5 이상. 다만, 한쪽 눈을 보지 못하는 사람은 다른 쪽 눈의 시력이 0.6 이상이어야 함"
          ],
          isImportant: true),
      _buildColorTestCard(),
      _buildSectionCard("청력", [
        "제1종 대형·특수에 한하여 청력 55 데시벨의 소리를 들을 수 있을 것",
        "보청기 사용 시 40 데시벨의 소리를 들을 수 있을 것"
      ]),
      _buildSectionCard("신체", [
        "조향장치나 그 밖의 장치를 뜻대로 조작할 수 없는 등 정상적인 운전을 할 수 없다고 인정되는 신체상 또는 정신상의 장애가 없을 것",
        "제1종 대형 및 특수면허는 상지, 하지, 문진판단 등 신체장애 여부를 판단"
      ]),
    ]);
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

  Widget _buildPeriodCard(String title, List<String> contents) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kCardBorderRadius),
        border: Border.all(
          color: const Color(0xFFFFCC80),
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
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "⏰",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFFE65100),
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
                        style: const TextStyle(
                          color: Color(0xFFD32F2F),
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

  Widget _buildColorTestCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kCardBorderRadius),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
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
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.palette_outlined,
                      color: const Color(0xFF1976D2),
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "색채식별",
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: const Text(
                    "적색등(red), 황색등(yellow), 녹색등(green)을 정확히 구분 가능할 것",
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
