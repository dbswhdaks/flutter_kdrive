import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:kdrive/generated/locale_keys.g.dart';
import 'package:kdrive/models/quiz_model/bike_quiz_model.dart';
import 'package:kdrive/models/quiz_model/car_quiz_model.dart';
import 'package:kdrive/models/quiz_model/quiz_model.dart';
import 'package:kdrive/pages/1_hagseub/quiz/2_step/quiz_page.dart';
import 'package:kdrive/pages/1_hagseub/quiz/quiz_score.dart';

class China extends StatelessWidget {
  const China({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0,
        title: Text(
          LocaleKeys.select_quiz_list.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더 섹션
              _buildHeader(),
              const SizedBox(height: 32),

              // 면허 버튼들
              Expanded(
                child: _buildLicenseButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildLicenseButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _LicenseCard(
          title: LocaleKeys.class_1_driver_license.tr(),
          subtitle: '',
          icon: Icons.local_shipping,
          color: Colors.blue,
          onTap: () => _navigateToQuiz(
            DriverLicenseType.type1Common,
            false,
          ),
        ),
        const SizedBox(height: 16),
        _LicenseCard(
          title: LocaleKeys.class_2_driver_license.tr(),
          subtitle: '',
          icon: Icons.directions_car_filled,
          color: Colors.green,
          onTap: () => _navigateToQuiz(
            DriverLicenseType.type2Common,
            false,
          ),
        ),
        const SizedBox(height: 16),
        _LicenseCard(
          title: LocaleKeys.class_bike.tr(),
          subtitle: '',
          icon: Icons.pedal_bike,
          color: Colors.teal,
          onTap: () => _navigateToQuiz(
            DriverLicenseType.typeBike,
            true,
          ),
        ),
      ],
    );
  }

  Future<void> _navigateToQuiz(
    DriverLicenseType licenseType,
    bool isBike,
  ) async {
    if (isBike) {
      final response = await getBikeQuizList(BikeQuizLanguage.china);
      Get.to(
        () => QuizPage(
          quizList: response.cast<QuizModel>(),
          licenseType: licenseType,
          language: CarQuizLanguage.china,
          bikeLanguage: BikeQuizLanguage.china,
        ),
      );
    } else {
      final response = await getCarQuizList(CarQuizLanguage.china);
      Get.to(
        () => QuizPage(
          quizList: response.cast<QuizModel>(),
          licenseType: licenseType,
          language: CarQuizLanguage.china,
          bikeLanguage: BikeQuizLanguage.china,
        ),
      );
    }
  }
}

class _LicenseCard extends StatelessWidget {
  const _LicenseCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
