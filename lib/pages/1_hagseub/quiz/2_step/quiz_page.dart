// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_declarations, deprecated_member_use
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:kdrive/generated/locale_keys.g.dart';
import 'package:kdrive/models/quiz_model/bike_quiz_model.dart';
import 'package:kdrive/models/quiz_model/car_quiz_model.dart';
import 'package:kdrive/models/quiz_model/quiz_model.dart';
import 'package:kdrive/pages/1_hagseub/quiz/3_step/quiz_result_page.dart';
import 'package:kdrive/pages/1_hagseub/quiz/3_step/quiz_result_page1.dart';
import 'package:kdrive/component/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import 'package:kdrive/pages/1_hagseub/quiz/quiz_score.dart';

import '../3_step/quiz_result_page_bike.dart';

class QuizPage extends StatefulWidget {
  ///퀴즈 페이지로 보내는 모든 자료 (변하지 않는 변수)
  const QuizPage({
    super.key,
    required this.quizList,
    required this.licenseType,
    required this.language,
    required this.bikeLanguage,
  });

  final List<QuizModel> quizList;
  final DriverLicenseType licenseType;
  final CarQuizLanguage language;
  final BikeQuizLanguage bikeLanguage;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /// 카운트다운 타이머 관련 변수
  int _remainingTime = 2400; // 40분으로 설정

  /// 타이머
  Timer? _timer;

  /// 페이지 컨트롤러
  late PageController _pageController;

  /// 현재페이지
  int _currentPage = 0;

  /// 마지막페이지
  late int _lastPage;

  /// 답변
  List<List<int>> answers = [];

  /// 비디오 컨트롤러 캐시
  final Map<String, VideoPlayerController> _videoControllers = {};

  /// 비디오 캐시 매니저
  // final VideoCacheManager _videoCacheManager = VideoCacheManager();

  /// 메모리 최적화 타이머
  Timer? _memoryOptimizationTimer;

  // final LanguageController languageController = Get.find<LanguageController>();

  @override
  void initState() {
    super.initState();
    _lastPage = widget.quizList.length - 1;
    answers = List.generate(widget.quizList.length, (_) => []);

    ///마지막페이지 가져오는 코드
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
      // 페이지 변경 시 다음 비디오 프리로딩
      _preloadNextVideos();
      // 원거리 비디오 정리 (백그라운드에서)
      _cleanupDistantVideos();
      // 페이지 이동 시 다음 이미지 프리로딩
      _preloadNextImages();
      // 페이지 이동 시 비디오 프리로딩 및 메모리 최적화
      _preloadNextVideoControllers();
      _cleanupUnusedVideoControllers();
    });
    startTimer(); // 타이머 시작

    // 초기 비디오 프리로딩
    _preloadInitialVideos();

    // 초기 이미지 프리로딩
    _preloadInitialImages();

    // 초기 비디오 프리로딩 및 메모리 최적화
    _preloadNextVideoControllers();
    _cleanupUnusedVideoControllers();

    // 메모리 최적화 타이머 시작 (3분마다)
    _startMemoryOptimization();
  }

  /// 초기 비디오 프리로딩 (현재 페이지와 다음 2개 페이지)
  Future<void> _preloadInitialVideos() async {
    final videoUrls = <String>[];

    // 현재 페이지와 다음 2개 페이지의 비디오 URL 수집
    for (int i = 0; i < 3 && i < widget.quizList.length; i++) {
      final item = widget.quizList[i];
      if (item.video != null && item.video!.isNotEmpty) {
        videoUrls.add(item.video!);
      }
    }

    if (videoUrls.isNotEmpty) {
      // await _videoCacheManager.preloadVideos(videoUrls);
    }
  }

  /// 다음 비디오들 프리로딩 (스마트 프리로딩)
  Future<void> _preloadNextVideos() async {
    final videoUrls = <String>[];

    // 현재 페이지 이후 5개 페이지의 비디오 URL 수집 (범위 확장)
    for (int i = _currentPage + 1;
        i < _currentPage + 6 && i < widget.quizList.length;
        i++) {
      final item = widget.quizList[i];
      if (item.video != null && item.video!.isNotEmpty) {
        videoUrls.add(item.video!);
      }
    }

    if (videoUrls.isNotEmpty) {
      if (kDebugMode) {}
    }
  }

  /// 비디오 프리로딩 (현재 페이지와 다음 2개)
  Future<void> _preloadNextVideoControllers() async {
    for (int i = _currentPage;
        i < _currentPage + 3 && i < widget.quizList.length;
        i++) {
      final item = widget.quizList[i];
      if (item.video != null &&
          item.video!.isNotEmpty &&
          !_videoControllers.containsKey(item.video!)) {
        final controller = VideoPlayerController.network(item.video!);
        await controller.initialize();
        _videoControllers[item.video!] = controller;
      }
    }
  }

  /// 비디오 컨트롤러 메모리 최적화 (현재 페이지 기준 ±2)
  void _cleanupUnusedVideoControllers() {
    final keepRange = List.generate(5, (i) => _currentPage - 2 + i)
        .where((i) => i >= 0 && i < widget.quizList.length);
    final keepUrls = keepRange
        .map((i) => widget.quizList[i].video)
        .where((url) => url != null && url.isNotEmpty)
        .map((url) => url!)
        .toSet();
    final removeUrls =
        _videoControllers.keys.where((url) => !keepUrls.contains(url)).toList();
    for (final url in removeUrls) {
      _videoControllers[url]?.dispose();
      _videoControllers.remove(url);
    }
  }

  /// 초기 이미지 프리로딩 (현재 페이지와 다음 2개 페이지)
  Future<void> _preloadInitialImages() async {
    for (int i = 0; i < 3 && i < widget.quizList.length; i++) {
      final item = widget.quizList[i];
      if (item.image != null && item.image!.isNotEmpty) {
        await precacheImage(CachedNetworkImageProvider(item.image!), context);
      }
    }
  }

  /// 다음 이미지들 프리로딩 (현재 페이지 이후 3개)
  Future<void> _preloadNextImages() async {
    for (int i = _currentPage + 1;
        i < _currentPage + 4 && i < widget.quizList.length;
        i++) {
      final item = widget.quizList[i];
      if (item.image != null && item.image!.isNotEmpty) {
        await precacheImage(CachedNetworkImageProvider(item.image!), context);
      }
    }
  }

  /// 메모리 최적화 (더 자주 실행)
  void _startMemoryOptimization() {}

  void _cleanupDistantVideos() {}

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _memoryOptimizationTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Text timerText() {
    return Text(
        '${LocaleKeys.time_left.tr()}  ${getFormattedTime(_remainingTime)}',
        style: const TextStyle(
            fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold));
  }

  /// 타이머 시작
  void startTimer() {
    _remainingTime = 2400;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
        _showTimeUpDialog();
      }
    });
  }

  /// 타이머 초기화
  void resetTimer() {
    _timer?.cancel();
    startTimer();
  }

  /// 초를 분으로 변환
  String getFormattedTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _showTimeUpDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('time_up'.tr()),
          content: Text('time_up_message'.tr()),
          actions: <Widget>[
            TextButton(
              child: Text('ok'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.licenseType == DriverLicenseType.type2Common) {
                  Get.offAll(QuizResultPage1(
                    quizList: widget.quizList.cast<CarQuizModel>(),
                    myAnswers: answers,
                    licenseType: widget.licenseType,
                  ));
                } else if (widget.licenseType == DriverLicenseType.typeBike) {
                  Get.offAll(QuizResultPageBike(
                    quizList: widget.quizList.cast<BikeQuizModel>(),
                    myAnswers: answers,
                    licenseType: widget.licenseType,
                  ));
                } else {
                  Get.offAll(QuizResultPage(
                    licenseType: widget.licenseType,
                    quizList: widget.quizList,
                    myAnswers: answers,
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blueAccent,
        // title: Text('1종보통(40문항) 70↑)',
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_getTitleText(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       _pageController.jumpToPage(40);
        //     },
        //     icon: const Icon(
        //       Icons.settings,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: widget.quizList.length,
                itemBuilder: (context, index) {
                  QuizModel item = widget.quizList[index];
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        timerText(),
                        // Text(
                        //     '${item.problemtype} ${item.answer.toString()}'), // 문제 타입 및 답변 확인용
                        const SizedBox(height: 16),
                        questionText(index, item),
                        const SizedBox(height: 16),
                        if (item.image != null) ...[
                          Center(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.8,
                                maxHeight: 300,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: item.image!,
                                fit: BoxFit.contain,
                                memCacheWidth: 800, // 메모리 캐시 크기 제한
                                memCacheHeight: 600,
                                maxWidthDiskCache: 1200, // 디스크 캐시 크기 제한
                                maxHeightDiskCache: 900,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.error_outline,
                                    color: Colors.grey,
                                    size: 48,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (item.video != null) ...[
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: MP4Player(url: item.video!),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (item.bogi != null) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (String text in item.bogi as List<String>)
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Text(
                                    text,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ],
                        exampleListView(index, item),
                        const SizedBox(height: 50), // 버튼과의 간격
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: previousAndNextButton(),
          ),
        ],
      ),
    );
  }

  ListView exampleListView(int questionIndex, QuizModel item) {
    // 문제번호
    int questionNumber = questionIndex + 1;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: item.example.isNotEmpty ? item.example.length : 0,
      itemBuilder: (context, index) {
        // 답변번호
        int answerNumber = index + 1;
        return InkWell(
          onTap: () {
            // if문의 경우 답변이 하나인 경우 로직
            if (item.answer.length == 1) {
              setState(() {
                answers[questionIndex] = [answerNumber];
              });
            } else {
              // 내가 선택한 답변중에 중복선택했는지 확인
              if (answers[questionIndex].contains(answerNumber)) {
                setState(() {
                  // 답변선택후 취소시
                  answers[questionIndex].remove(answerNumber);
                });
              } else {
                // 답변 갯수보다 선택한 답변 갯수가 적을때
                if (answers[questionIndex].length < item.answer.length) {
                  setState(() {
                    answers[questionIndex] = [
                      ...answers[questionIndex],
                      answerNumber
                    ];
                  });
                }
              }
            }
            debugPrint('문제번호:$questionNumber, 답변번호:${answers[questionIndex]}');
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 18),
              Text(
                //보기번호
                "$answerNumber)",
                style: TextStyle(
                  fontSize: 20,

                  ///보기번호 사이즈
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: answers[questionIndex].contains(answerNumber)
                      ? Colors.blue
                      : Colors.black,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  ///보기 글씨크기
                  item.example[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: answers[questionIndex].contains(answerNumber)
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
    );
  }

  Row questionText(int index, QuizModel item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          //문제번호 사이즈
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
            //문제 사이즈
            item.question,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Container previousAndNextButton() {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 4, vertical: 44), // 버튼 사이 간격
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage != 0)
            ElevatedButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300), // 애니메이션 시간
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // 버튼 크기
              ),
              child: Text(
                // 이전 버튼 텍스트
                LocaleKeys.previous.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22, // 버튼 텍스트 크기
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            const SizedBox(width: 30), // 이전 버튼이 없을 때 공간 확보

          if (_currentPage == _lastPage)
            ElevatedButton(
              // 제출 버튼
              onPressed: () {
                showDialog<void>(
                  // 제출 버튼 다이얼로그 띄우기
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      // 제출 버튼 다이얼로그
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              // 제출 버튼 텍스트
                              LocaleKeys.answer_sheet_submit_confirm.tr(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            // 제출 버튼 취소 텍스트
                            LocaleKeys.answer_sheet_submit_confirm_cancel.tr(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            // 제출 버튼 텍스트
                            LocaleKeys.answer_sheet_submit_confirm_button.tr(),
                            style: const TextStyle(fontSize: 22),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // 다이얼로그 닫기
                            if (widget.licenseType ==
                                DriverLicenseType.type2Common) {
                              Get.offAll(() => QuizResultPage1(
                                    quizList:
                                        widget.quizList.cast<CarQuizModel>(),
                                    myAnswers: answers,
                                    licenseType: widget.licenseType,
                                  ));
                            } else if (widget.licenseType ==
                                DriverLicenseType.typeBike) {
                              Get.offAll(() => QuizResultPageBike(
                                    quizList:
                                        widget.quizList.cast<BikeQuizModel>(),
                                    myAnswers: answers,
                                    licenseType: widget.licenseType,
                                  ));
                            } else {
                              Get.offAll(() => QuizResultPage(
                                  licenseType: widget.licenseType,
                                  quizList: widget.quizList,
                                  myAnswers: answers));
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                // 제출 버튼 스타일
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                LocaleKeys.submit.tr(), // 제출 버튼
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            ElevatedButton(
              onPressed: () {
                _pageController.nextPage(
                  // 다음 버튼 눌렀을 때
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                // 다음 버튼 스타일
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                // 다음 버튼 텍스트
                LocaleKeys.next.tr(), // 다음 버튼
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22, // 버튼 텍스트 크기
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getTitleText() {
    // 면허종류 텍스트 반환
    switch (widget.licenseType) {
      case DriverLicenseType.type1Common:
        return LocaleKeys.title_1.tr(namedArgs: {
          // 1종보통(40문항) 70↑)
          'quiz_count': widget.licenseType.totalQuestions.toString(),
          'passing_score': widget.licenseType.passingScore.toString(),
        });
      case DriverLicenseType.type2Common:
        return LocaleKeys.title_2.tr(namedArgs: {
          // 2종보통(40문항) 60↑)
          'quiz_count': widget.licenseType.totalQuestions.toString(),
          'passing_score': widget.licenseType.passingScore.toString(),
        });

      case DriverLicenseType.typeBike:
        return LocaleKeys.title_3.tr(namedArgs: {
          // 오토바이(40문항) 60↑)
          'quiz_count': widget.licenseType.totalQuestions.toString(),
          'passing_score': widget.licenseType.passingScore.toString(),
        });
    }
  }
}

void test() {
  ColorType colorType = ColorType.red;

  if (colorType == ColorType.red) {
    print('red');
  } else {
    print('blue');
  }

  switch (colorType) {
    case ColorType.red:
      print('red');
      break;
    case ColorType.blue:
      print('blue');
      break;
    case ColorType.green:
      print('green');
      break;
  }
}

enum ColorType { red, blue, green }
