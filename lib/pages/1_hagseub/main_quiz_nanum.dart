// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kdrive/models/quiz_model/bike_quiz_model.dart';
import 'package:kdrive/models/quiz_model/car_quiz_model.dart';
import 'package:kdrive/pages/1_hagseub/quiz/1_step/china.dart';
import 'package:kdrive/pages/1_hagseub/quiz/1_step/english.dart';
import 'package:kdrive/pages/1_hagseub/quiz/1_step/korea.dart';
import 'package:kdrive/pages/1_hagseub/quiz/1_step/vietnam.dart';

class MainQuizNanum extends StatelessWidget {
  MainQuizNanum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        shadowColor: Colors.black26,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange.shade400,
                Colors.orange.shade600,
                Colors.deepOrange.shade400,
              ],
            ),
          ),
        ),
        title: Row(
          children: [
            Icon(
              Icons.quiz_outlined,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(width: 12),
            Text(
              "응시면허 시험선택",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.shade50,
                        Colors.green.shade100,
                        Colors.lightGreen.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.green.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.quiz_rounded,
                        color: Colors.green.shade600,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '응시할 문제를 선택하세요',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: ElevatedButton(
                          onPressed: () async {
                            var newLocale = Locale('ko');
                            await context.setLocale(newLocale);
                            Get.updateLocale(newLocale);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Korea(
                                        language: CarQuizLanguage.korea,
                                        bikeLanguage: BikeQuizLanguage.korea,
                                      )),
                            ).then((value) {
                              context.resetLocale();
                              newLocale = context.locale;
                              Get.updateLocale(newLocale);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: Size(200, 150),
                          ),
                          child: Column(
                            children: [
                              Text('한국어',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.lightBlueAccent)),
                              Text('Korean',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                        child: GestureDetector(
                      child: ElevatedButton(
                        onPressed: () async {
                          var newLocale = Locale('zh');
                          await context.setLocale(newLocale);
                          Get.updateLocale(newLocale);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => China(),
                            ),
                          ).then((value) {
                            context.resetLocale();
                            newLocale = context.locale;
                            Get.updateLocale(newLocale);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(200, 150),
                        ),
                        child: Column(
                          children: [
                            Text('중국어',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.orange)),
                            Text(
                              'China',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: ElevatedButton(
                          onPressed: () async {
                            var newLocale = Locale('en');
                            await context.setLocale(newLocale);
                            Get.updateLocale(newLocale);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => English(
                                        language: CarQuizLanguage.english,
                                        bikeLanguage: BikeQuizLanguage.english,
                                      )),
                            ).then((value) {
                              context.resetLocale();
                              newLocale = context.locale;
                              Get.updateLocale(newLocale);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: Size(200, 150),
                          ),
                          child: Column(
                            children: [
                              Text('영 어',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.black87)),
                              Text('English',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                        child: GestureDetector(
                      child: ElevatedButton(
                        onPressed: () async {
                          var newLocale = Locale('vi');
                          await context.setLocale(newLocale);
                          Get.updateLocale(newLocale);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Vietnam()),
                          ).then((value) {
                            context.resetLocale();
                            newLocale = context.locale;
                            Get.updateLocale(newLocale);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(200, 150),
                        ),
                        child: Column(
                          children: [
                            Text('베트남어',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.teal)),
                            Text(
                              'Vietnamese',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
