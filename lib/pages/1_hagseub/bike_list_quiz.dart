// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:kdrive/models/quiz_model/bike_every_quiz_model.dart';
import 'package:kdrive/component/video_player.dart';

class BikeListQuiz extends StatefulWidget {
  const BikeListQuiz({super.key});

  @override
  State<BikeListQuiz> createState() => _BikeListQuizState();
}

class _BikeListQuizState extends State<BikeListQuiz> {
  List<BikeEveryQuizModel> quizList = [];
  List<List<int>> myAnswers = [];

  @override
  void initState() {
    super.initState();
    _loadQuizList();
  }

  Future<void> _loadQuizList() async {
    final loadedQuizList = await getEveryQuizList(BikeEveryQuizLanguage.korea);
    setState(() {
      quizList = loadedQuizList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // ignore: prefer_const_constructors
        title: Row(
          children: const [
            Text('800문제',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(width: 6),
            Text(
              '(2종소형,원동기)',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: quizList.length,
        itemBuilder: (context, index) {
          BikeEveryQuizModel item = quizList[index];
          return Card.outlined(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 문제 번호와 문제 내용
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,

                    /// 왼쪽 글씨와 오른쪽 글씨를 기준선 맞추기
                    children: [
                      Text(
                        '${index + 1}.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${item.question}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (item.image != null) ...[
                    const SizedBox(height: 2),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                            maxHeight: 300,
                          ),
                          child: Image.network(
                            item.image!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (item.video != null) ...[
                    const SizedBox(height: 8),
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        alignment: Alignment.center,
                        child: MP4Player(url: item.video!),
                      ),
                    ),
                  ],
                  if (item.bogi != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...item.bogi!.map((line) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(
                                          right: 8, top: 2),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        line,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'NanumGothic',
                                          // color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],

                  // 보기 목록
                  if (item.example.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          ...item.example.asMap().entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${entry.key + 1}) ',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],

                  // 정답
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '정답:',
                          style: TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${item.answer.map((e) => e.toString()).join(',')}',
                          style: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
