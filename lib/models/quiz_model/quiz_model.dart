// import 'dart:convert';

class QuizModel {
  final int? id;
  final String question;
  final List<String>? bogi;
  final List<String> example;
  final List<int> answer;
  final int? score;
  final String division;
  final String problemtype;
  final String? image;
  final String? video;
  final String language;

  QuizModel({
    required this.id,
    required this.question,
    required this.bogi,
    required this.example,
    required this.answer,
    required this.score,
    required this.division,
    required this.problemtype,
    required this.image,
    required this.video,
    required this.language,
  });
}
