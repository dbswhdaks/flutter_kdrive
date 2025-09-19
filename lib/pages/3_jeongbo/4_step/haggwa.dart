// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdrive/pages/3_jeongbo/4_step/assort_ment/daehyeong.dart';
import 'package:kdrive/pages/3_jeongbo/4_step/assort_ment/daehyeonggyeonincha.dart';
import 'package:kdrive/pages/3_jeongbo/4_step/assort_ment/gunancha.dart';
import 'package:kdrive/pages/3_jeongbo/4_step/assort_ment/iljongbotong.dart';
import 'package:kdrive/pages/3_jeongbo/4_step/assort_ment/leejongsohyeong.dart';
import 'package:kdrive/pages/3_jeongbo/4_step/assort_ment/sohyeonggyenincha.dart';
import 'package:kdrive/component/web_view.dart';

class Haggwa extends StatefulWidget {
  const Haggwa({Key? key}) : super(key: key);

  @override
  State<Haggwa> createState() => _DriveList4State();
}

class _DriveList4State extends State<Haggwa> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 1,
          title: const Text(
            "학과/기능/도로주행",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          bottom: ButtonsTabBar(
            backgroundColor: Colors.amber[600],
            unselectedBackgroundColor: Colors.grey[100],
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            labelSpacing: 20,
            radius: 8,
            tabs: const [
              Tab(text: "학과 시험"),
              Tab(text: "기능 시험"),
              Tab(text: "연습면허"),
              Tab(text: "도로주행 시험"),
              Tab(text: "운전면허증 발급"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildWrittenExamTab(),
            _buildPracticalExamTab(),
            _buildPracticeLicenseTab(),
            _buildRoadTestTab(),
            _buildLicenseIssuanceTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildWrittenExamTab() {
    return _buildTabContent([
      _buildSectionTitle("학과시험"),
      _buildContentText(
          "전국 운전면허시험장에서 평일 09:00~17:00 응시접수 가능합니다.(청각장애인 및 비문해자 학과시험은 오전10:30분까지, 오후 16:30분 까지 응시점수 완료)"),
      _buildContentText("※ '21.03.22 학과시험 인터넷 예약제 시행"),
      _buildSectionTitle("합격기준"),
      _buildContentText("70점 (1종보통,1종대형,1종특수,대형견인,소형견인,구난차)"),
      _buildImportantText(
          "1종대형,1종특수,대형견인,소형견인,구난차=19세 이상 1,2종보통면허 취득후 1년 경과한자 (1,2종보통 18세 이상(시험비:10,000원))"),
      _buildContentText("60점 (2종보통,2종소형,원동기)"),
      _buildImportantText("2종보통,2종소형=18세 이상, 원동기 = 16세 이상 (시험비:8,000원)"),
      _buildSectionTitle("준비물"),
      _buildContentText("응시원서(신체검사 완료 또는 건강검진 결과서 조회.제출)"),
      _buildContentText(
          "신청일로부터 6개월 내에 모자를 벗은 상태에서 배경 없이 촬영된 3.5X4.5cm 규격의 상반신 컬러사진 (허용되는 사진규격) 3매,"),
      _buildContentText("신분증 (신분증 인정 범위)"),
      _buildSectionTitle("시험내용"),
      _buildContentText("안전운전에 필요한 교통법규 등 공개된 학과시험 문제은행 중 40문제 출제"),
      _buildSectionTitle("결과발표"),
      _buildContentText("시험 종료 즉시 컴퓨터 모니터에 획득 점수 및 합격 여부 표시"),
      _buildContentText("합격 또는 불합격도장이 찍힌 응시원서를 돌려받아 본인이 보관"),
      _buildContentText(
          "1년경과 시 기존 원서 폐기 후 학과시험부터 신규 접수하여야 하며 이때 교통안전교육 재수강은 불필요"),
      _buildSectionTitle("응시가능언어"),
      _buildContentText("한국어, 영어, 중국어, 베트남어"),
      _buildSectionTitle("비문해자를 위한 PC학과시험"),
      _buildContentText("시험문제와 보기를 음성으로 들을 수 있는 PC학과시험 시험시간 총 80분,"),
      _buildContentText("민원실에서 접수 시 신청 가능"),
      _buildSectionTitle("청각장애인을 위한 수화 PC학과시험"),
      _buildContentText("청각장애인이면서 비문해자를 위한 수화로 보는 PC학과시험"),
      _buildContentText("시험시간 총 80분, 민원실에서 접수 시 신청 가능"),
      const SizedBox(height: 20),
      _buildActionButton(
        '학과시험 인터넷 예약',
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/mainCertification01M.do',
          '학과시험 인터넷 예약',
        ),
      ),
    ]);
  }

  Widget _buildPracticalExamTab() {
    return _buildTabContent([
      _buildLicenseTypeTitle("1종대형"),
      _buildLicenseSection([
        _buildActionButton(
          '1종대형(채점기준)',
          () => _navigateToPage(Daehyeong()),
        ),
        _buildExamInfo("준비물", "온라인 접수 또는 현장 예약 접수 후 시험 당일 응시원서, 신분증 지참"),
        _buildExamInfo("합격기준", "80점 이상"),
        _buildExamInfo("수수료", "25,000원"),
        _buildExamInfo("시험코스",
            "출발코스, 굴절코스, 곡선코스, 방향전환코스, 평행주차코스, 기어변속코스, 교통신호가 있는 십자형 교차로코스, 횡단보도코스, 철길건널목코스, 경사로코스, 종료코스"),
        _buildDisqualificationCriteria([
          "특별한 사유 없이 출발선에서 30초 이내 출발하지 못한 때",
          "경사로코스·굴절코스·방향전환코스·기어변속코스(자동변속기장치 자동차의 경우는 제외) 및 평행주차코스를 어느 하나라도 이행하지 아니한 때",
          "특별한 사유 없이 교차로 내에서 30초 이상 정차한 때",
          "안전사고를 일으키거나 단 1회라도 차로를 벗어난 때",
          "경사로 정지 구간 이행 후 30초를 초과하여 통과하지 못한 때 또는 경사로 정지 구간에서 후진하여 앞 범퍼가 경사로 사면을 벗어난 때",
        ]),
        _buildExamInfo("응시자격", "19세 이상으로 제1∙2종 보통면허 취득 후 1년 이상인자"),
        _buildRetakeInfo(),
        _buildActionButton(
          '시험일정 확인 및 예약',
          () => _navigateToWebView(
            'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
            '시험일정 확인 및 예약',
          ),
        ),
      ]),
      const SizedBox(height: 32),
      _buildLicenseTypeTitle("1종특수"),
      _buildLicenseSection([
        _buildActionButton(
          '대형견인차 (채점기준)',
          () => _navigateToPage(const Daehyeonggyeonincha()),
        ),
        _buildActionButton(
          '구난차 (채점기준)',
          () => _navigateToPage(const Gunancha()),
        ),
        _buildActionButton(
          '소형견인차 (채점기준)',
          () => _navigateToPage(const Sohyeonggyeonincha()),
        ),
        _buildExamInfo("준비물", "온라인 접수 또는 현장 예약 접수 후 시험 당일 응시원서, 신분증 지참"),
        _buildExamInfo("합격기준", "90점 이상"),
        _buildExamInfo("수수료", "25,000원"),
        _buildExamInfo(
            "시험코스", "- 대형 견인차 : 연결·코스·분리\n- 소형 견인차 : 굴절코스·곡선코스·방향전환코스"),
        _buildDisqualificationCriteria([
          "특별한 사유 없이 출발선에서 20초 이내 출발하지 못한 때",
          "특별한 사유 없이 교차로 내에서 30초 이상 정차한 때",
          "시험 중 안전사고를 일으키거나 코스를 벗어난 때",
        ]),
        _buildExamInfo("응시자격", "19세 이상으로 제1∙2종 보통면허 취득 후 1년 이상인자"),
        _buildRetakeInfo(),
        _buildActionButton(
          '시험일정 확인 및 예약',
          () => _navigateToWebView(
            'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
            '시험일정 확인 및 예약',
          ),
        ),
      ]),
      const SizedBox(height: 32),
      _buildLicenseTypeTitle("1,2종보통"),
      _buildLicenseSection([
        _buildActionButton(
          '1,2종보통 (채점기준)',
          () => _navigateToPage(Iljongbotong()),
        ),
        _buildExamInfo("준비물", "온라인 접수 또는 현장 예약 접수 후 시험 당일 응시원서, 신분증 지참"),
        _buildExamInfo("합격기준", "80점 이상"),
        _buildExamInfo("수수료", "25,000원"),
        _buildExamInfo("시험코스",
            "주행거리 300m 이상, 운전장치 조작, 차로 준수·급정지, 경사로-좌·우회전, 직각 주차, 신호교차로, 전진(가속구간)"),
        _buildDisqualificationCriteria([
          "점검이 시작될 때부터 종료될 때까지 좌석 안전띠를 착용하지 아니한 때",
          "시험 중 안전사고를 일으키거나 차의 바퀴 어느 하나라도 연석을 접촉한 때",
          "시험관의 지시나 통제를 따르지 않거나 음주, 과로, 마약·대마 등 약물 등의 영향으로 정상적인 시험 진행이 어려운 때",
          "특별한 사유 없이 출발 지시 후 출발선에서 30초 이내 출발하지 못한 때",
          "각 시험 코스를 어느 하나라도 시도하지 않거나 제대로 이행하지 않을 때(예: 경사로에서 정지하지 않고 통과, 직각 주차에서 차고에 진입해서 확인선을 접촉하지 않음, 가속코스에서 기어변속을 하지 않음)",
          "경사로 정지 구간 이행 후 30초를 초과하여 통과하지 못한 때 또는 경사로 정지 구간에서 후방으로 1미터 이상 밀린 때",
          "신호 교차로에서 신호위반을 하거나 또는 앞 범퍼가 정지선을 넘어간 때",
        ]),
        _buildExamInfo("응시자격", "19세 이상으로 제1∙2종 보통면허 취득 후 1년 이상인자"),
        _buildRetakeInfo(),
        _buildActionButton(
          '시험일정 확인 및 예약',
          () => _navigateToWebView(
            'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
            '시험일정 확인 및 예약',
          ),
        ),
      ]),
      const SizedBox(height: 32),
      _buildLicenseTypeTitle("2종소형(125cc초과 이륜자동차)"),
      _buildLicenseSection([
        _buildActionButton(
          '2종소형 (채점기준)',
          () => _navigateToPage(const Leejonsohyeong()),
        ),
        _buildExamInfo("준비물", "온라인 접수 또는 현장 예약 접수 후 시험 당일 응시원서, 신분증 지참"),
        _buildExamInfo("합격기준", "90점 이상"),
        _buildExamInfo("수수료", "14,000원"),
        _buildExamInfo("시험코스", "굴절코스, 곡선코스, 좁은길코스, 연속진로전환코스"),
        _buildDisqualificationCriteria([
          "운전미숙으로 20초 이내에 출발하지 못한 때",
          "시험 과제를 하나라도 이행하지 아니한 때",
          "시험 중 안전사고를 일으키거나 코스를 벗어난 때",
        ]),
        _buildExamInfo("응시자격", "18세 이상"),
        _buildRetakeInfo(),
        _buildActionButton(
          '시험일정 확인 및 예약',
          () => _navigateToWebView(
            'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
            '시험일정 확인 및 예약',
          ),
        ),
      ]),
      const SizedBox(height: 32),
      _buildLicenseTypeTitle("제2종 원동기장치 자전거"),
      _buildLicenseSection([
        _buildActionButton(
          '원동기 (채점기준)',
          () => _navigateToPage(const Leejonsohyeong()),
        ),
        _buildExamInfo("준비물", "온라인 접수 또는 현장 예약 접수 후 시험 당일 응시원서, 신분증 지참"),
        _buildExamInfo("합격기준", "90점 이상"),
        _buildExamInfo("수수료", "10,000원"),
        _buildExamInfo("시험코스",
            "- 굴절코스, 곡선코스, 좁은길코스, 연속진로전환코스\n※다륜형원동기장치자전거 굴절코스, 곡선코스만 진행"),
        _buildDisqualificationCriteria([
          "운전미숙으로 20초 이내에 출발하지 못한 때",
          "시험 과제를 하나라도 이행하지 아니한 때",
          "시험 중 안전사고를 일으키거나 코스를 벗어난 때",
        ]),
        _buildExamInfo("응시자격", "16세 이상"),
        _buildRetakeInfo(),
        _buildActionButton(
          '시험일정 확인 및 예약',
          () => _navigateToWebView(
            'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
            '시험일정 확인 및 예약',
          ),
        ),
      ]),
    ]);
  }

  Widget _buildPracticeLicenseTab() {
    return _buildTabContent([
      _buildSectionTitle("연습면허"),
      _buildSectionTitle("준비물 및 수수료"),
      _buildContentText("- 응시원서,신분증,수수료 4,000원"),
      _buildContentText("- 대리접수 : 대리인 신분증(원본), 위임장"),
      _buildSectionTitle("연습면허 교환 발급"),
      _buildContentText("연습면허의 유효기간은 1년"),
      _buildSectionTitle("유효기간 산정 안내"),
      _buildContentText(
          "최초 1종 연습면허 소지자가 2종 보통 연습 면허로 격하하여 교환 발급 시 최초 발급받은 연습면허 잔여기간을 유효기간으로 하는 연습 면허가 발급됨"),
      _buildActionButton(
        '연습면허 발급',
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/mainM.do',
          '연습면허 발급',
        ),
      ),
    ]);
  }

  Widget _buildRoadTestTab() {
    return _buildTabContent([
      _buildSectionTitle("도로주행시험"),
      _buildActionButton(
        '도로주행시험 (채점기준)',
        () => _navigateToPage(Iljongbotong()),
      ),
      _buildExamInfo("면허종별", "1종 보통, 2종 보통"),
      _buildExamInfo(
          "준비물", "온라인 접수 또는 현장 예약 접수\n시험 당일 연습면허 발급·부착된 응시원서, 신분증 지참"),
      _buildExamInfo("합격기준", "70점 이상 시 합격"),
      _buildExamInfo("수수료", "30,000원"),
      _buildExamInfo(
          "시험코스", "총 연장거리 5km 이상인 4개 코스 중 추첨을 통한 1개 코스 선택\n내비게이션 음성 길 안내"),
      _buildExamInfo(
          "시험내용", "긴급자동차 양보, 어린이보호구역, 지정 속도 위반 등 안전운전에 필요한 57개 항목을 평가"),
      _buildDisqualificationCriteria([
        "3회 이상 \"출발 불능\", \"클러치 조작 불량으로 인한 엔진 정지\", \"급브레이크 사용\",\"급조작·급출발\" 또는 그 밖의 사유로 운전능력이 현저하게 부족한 것으로 인정할 수 있는 행위를 한 경우",
        "안전거리 미확보나 경사로에서 뒤로 1미터 이상 밀리는 현상 등 운전능력 부족으로 교통사고를 일으킬 위험이 현저한 경우 또는 교통사고를 야기한 경우",
        "음주, 과로, 마약, 대마 등 약물의 영향 이나 휴대전화 사용 등으로 정상적으로 운전하지 못할 우려가 있거나 교통안전과 소통을 위한 시험관의 지시 및 통제에 불응한 경우",
        "신호 또는 지시에 따르지 않은 경우",
        "보행자 보호의무 등을 소홀히 한 경우",
        "어린이 보호구역, 노인 및 장애인 보호구역에 지정되어 있는 최고 속도를 초과한 경우",
        "도로의 중앙으로부터 우측 부분을 통행하여야 할 의무를 위반한 경우",
        "법령 또는 안전표지 등으로 지정되어 있는 최고 속도를 시속 10킬로미터 초과한 경우",
        "긴급자동차의 우선통행 시 일시정지하거나 진로를 양보하지 않은 경우",
        "어린이 통학버스의 특별보호의무를 위반한 경우",
        "시험시간 동안 좌석안전띠를 착용하지 않은 경우",
      ]),
      _buildSectionTitle("주의사항"),
      _buildContentText("연습운전면허 유효기간(발급일로부터 1년) 이내 도로주행시험에 합격하여야 함."),
      _buildContentText(
          "연습운전면허 유효기간이 지났을 경우, 도로주행시험 접수가 불가능하며 학과시험, 기능 시험에 재응시하여야 함."),
      _buildContentText("(응시 전 교통안전교육은 재수강 불필요)"),
      _buildActionButton(
        '시험일정 확인 및 예약',
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/rerrest/rerrestScheduleViewM.do?menuCode=MN-MO-1121',
          '시험일정 확인 및 예약',
        ),
      ),
    ]);
  }

  Widget _buildLicenseIssuanceTab() {
    return _buildTabContent([
      _buildSectionTitle("운전면허증 발급"),
      _buildActionButton(
        '운전면허증 발급',
        () => _navigateToWebView(
          'https://www.safedriving.or.kr/mainM.do',
          '운전면허증 발급',
        ),
      ),
      _buildContentText(
          "각 응시 종별(1종 대형, 1종 보통, 1종 특수, 2종 보통, 2종 소형, 2종원동기장치 자전거)에 따른 응시과목을 최종 합격했을 경우 발급"),
      _buildSectionTitle("발급대상"),
      _buildContentText(
          "1,2종 보통 면허 : 연습면허 발급 후 도로주행시험 (운전전문학원 졸업자는 도로주행 검정)에 합격한 자"),
      _buildContentText("기타 면허 : 학과시험 및 장내기능 시험에 합격한 자"),
      _buildSectionTitle("발급 장소"),
      _buildContentText("운전면허시험장"),
      _buildSectionTitle("구비서류"),
      _buildContentText(
          "최종 합격한 응시원서, 신분증, 최근 6개월 이내 촬영한 컬러 사진 (규격 3.5cm*4.5cm) 1매,"),
      _buildContentText("수수료 : 운전면허증(국문,영문) 10,000원, 모바일 운전면허증(국문,영문) 15,000원"),
      _buildContentText("대리접수 : 대리인 신분증, 위임장"),
    ]);
  }

  // Helper methods
  void _navigateToWebView(String url, String title) {
    Get.to(WebView(url: url, title: title));
  }

  void _navigateToPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Widget _buildExamInfo(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[100]!,
                width: 1,
              ),
            ),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisqualificationCriteria(List<String> criteria) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.red[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "실격기준",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 12),
          ...criteria.map((criterion) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.red[200]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(top: 8, right: 12),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        criterion,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildRetakeInfo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "불합격 후 재응시",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.blue[200]!,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(top: 8, right: 12),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "기능시험 불합격자는(운전전문학원 검정 불합격 포함) 불합격 일로부터 3일 경과 후에 재 응시 가능",
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(top: 8, right: 12),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "예) 1일(월요일)에 불합격하였을 경우, 4일(목요일)부터 재 응시 가능",
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseTypeTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 32, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.drive_eta_rounded,
              color: Colors.grey[700],
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "기능시험",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentText(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildImportantText(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.red[200]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue[600]!,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue[600],
                  size: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[600],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLicenseSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
