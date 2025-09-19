import 'package:flutter/material.dart';
import 'package:kdrive/models/quiz_model/car_quiz_model.dart';
import 'package:kdrive/pages/1_hagseub/quiz/3_step/quiz_result_page.dart';
import 'package:kdrive/component/video_player.dart';
import 'package:kdrive/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ReplayScreen extends StatelessWidget {
  const ReplayScreen({
    super.key,
    required this.quizModel,
    required this.myAnswer,
    required this.index,
  });

  final CarQuizModel quizModel;
  final List<int> myAnswer;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.replay_title.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                // 문제번호 컨테이너
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
                    // 문제 컨테이너
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 18),
                      Container(
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
                          answerNumber.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
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
