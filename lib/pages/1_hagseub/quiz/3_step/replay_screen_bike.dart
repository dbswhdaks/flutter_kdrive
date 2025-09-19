import 'package:flutter/material.dart';
import 'package:kdrive/models/quiz_model/bike_quiz_model.dart';
import 'package:kdrive/pages/1_hagseub/quiz/3_step/quiz_result_page.dart';
import 'package:kdrive/component/video_player.dart';

class ReplayScreenBike extends StatelessWidget {
  const ReplayScreenBike({
    super.key,
    required this.quizModel,
    required this.myAnswer,
    required this.index,
  });

  final BikeQuizModel quizModel;
  final List<int> myAnswer;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('다시보기'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //문제번호
                    "${index + 1}.",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      //문제
                      quizModel.question,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              if (quizModel.image != null) ...[
                Image.network(quizModel.image!),
                const SizedBox(height: 16),
              ],
              if (quizModel.video != null) ...[
                // VideoApp(videoPath: quizModel.video!),
                MP4Player(url: quizModel.video!),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 16),
              ListView.separated(
                // 답변번호 리스트
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quizModel.example.length,
                itemBuilder: (context, index) {
                  // 답변번호
                  int answerNumber = index + 1;
                  bool isSelected = myAnswer.contains(answerNumber);
                  AnswerType type = quizModel.answer.contains(answerNumber)
                      ? AnswerType.correct
                      : AnswerType.basic;
                  return Row(
                    // 답변번호 컨테이너
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 18),
                      Container(
                        // 답변번호 컨테이너
                        decoration: BoxDecoration(
                          color: isSelected ? type.color : null,
                          border: Border.all(
                            color: type.color,
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Text(
                          // 답변번호
                          answerNumber.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        // 보기 컨테이너
                        child: Text(
                          //보기
                          quizModel.example[index],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 2.2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  // 답변번호 사이 간격
                  return const SizedBox(height: 16);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
