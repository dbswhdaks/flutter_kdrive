// ignore_for_file: camel_case_types, unnecessary_cast, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class Id_Card extends StatelessWidget {
  const Id_Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified_user,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              '신분증명서 종류',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 메인 카드
              _buildMainCard(
                title: '신분확인이 가능한 신분증명서',
                icon: Icons.verified_user,
                color: Colors.green[600]!,
                children: [
                  _buildInfoItem('주민등록증',
                      '주민등록증 모바일 확인 서비스, 사진에 간인 후 주요 기재사항에 테이프가 부착된 주민등록증 발급신청 확인서'),
                  _buildInfoItem('재외국민 주민등록증', ''),
                  _buildInfoItem('운전면허증', ''),
                  _buildInfoItem('여권', ''),
                  _buildInfoItem('청소년증', '유효기간 이내'),
                ],
              ),

              const SizedBox(height: 16),

              // 여권 관련 카드
              _buildMainCard(
                title: '주민등록번호가 기재되지 않은 여권',
                icon: Icons.credit_card,
                color: Colors.orange[600]!,
                children: [
                  _buildInfoItem('신분확인 방법', '지문인식시스템을 통해 본인확인 (본인 동의 필요)'),
                  _buildInfoItem('미성년자', '여권정보증명서 제출 또는 행망조회'),
                ],
              ),

              const SizedBox(height: 16),

              // 기타 신분증 카드
              _buildMainCard(
                title: '기타 공공기관 발행 신분증',
                icon: Icons.badge,
                color: Colors.purple[600]!,
                children: [
                  _buildInfoItem('공무원증', ''),
                  _buildInfoItem('선원수첩', ''),
                  _buildInfoItem('국가기술자격증', ''),
                  _buildInfoItem('학생증', '재학증명서 첨부'),
                  _buildInfoItem('장애인복지카드', ''),
                  _buildInfoItem('전역증', '전역 후 1년이내'),
                  _buildInfoItem('외국인등록증', ''),
                  _buildInfoItem('국가유공자증', ''),
                ],
              ),

              const SizedBox(height: 16),

              // 추가 증빙 카드
              _buildMainCard(
                title: '추가 증빙자료가 필요한 경우',
                icon: Icons.warning,
                color: Colors.red[600]!,
                children: [
                  _buildInfoItem('사진/생년월일/이름 식별곤란', '지문 조회 또는 추가 신분증 제출'),
                  _buildInfoItem('지문 훼손/누락', '주민등록번호 뒷자리 확인 가능한 증빙자료'),
                  _buildInfoItem('신분증 미소지자', '본인 동의 시 지문 조회 가능'),
                  _buildInfoItem('주소확인 어려움', '주민등록등본 등 추가 서류 제출'),
                ],
              ),

              const SizedBox(height: 20),

              // 주의사항 카드
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: Colors.blue[600], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '주의사항',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '유효기간이 명시된 신분증은 유효기간이 경과하지 않아야 합니다\n'
                      '사진이 본인과 현저히 다르거나 손괴된 경우 추가 신분증 제출이 필요합니다\n'
                      '시도지부 안전교육부에서는 지문 조회가 불가합니다',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
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

  Widget _buildInfoItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.blue[400],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
