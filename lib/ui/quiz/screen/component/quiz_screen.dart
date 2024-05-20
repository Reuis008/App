import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/models/quiz_trivia.dart';
import 'package:lms_v_2_0_0/ui/quiz/screen/component/quiz_scoreScreen.dart';

class QuizScreen extends StatefulWidget {
  final Future<List<QuizTrivia>>? quizTriviaQuestionList;

  const QuizScreen(this.quizTriviaQuestionList, {super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var currentQuestionIndex = 0;
  int seconds = 60;
  late Timer timer;
  bool isCorrect = false;
  int points = 0;

  var optionsColors =
      List.filled(4, Colors.black); // List to store colors for each option

  // Add a boolean list to track the clickability of each option
  bool optionsClicked = false;
  // Add a list to track the state of each option
  List<bool> optionStates = List.filled(4, false);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  resetColors() {
    if (mounted) {
      // Check if the widget is still mounted
      setState(
        () {
          optionsColors = List.filled(4, Colors.black);
          optionsClicked = false;
          optionStates = List.filled(4, false);
        },
      );
    }
  }

  startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (mounted) {
          setState(
            () {
              if (seconds > 0) {
                seconds--;
              } else {
                widget.quizTriviaQuestionList!.then(
                  (questions) {
                    if (currentQuestionIndex < questions.length - 1) {
                      gotoNextQuestion();
                    } else {
                      timer.cancel();

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Quiz Time Over',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      );
                      Future.delayed(
                        const Duration(microseconds: 50),
                        () {
                          if (mounted) {
                            widget.quizTriviaQuestionList!.then(
                              (questions) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizScoreScreen(
                                      points,
                                      questions.length,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  gotoNextQuestion() {
    if (mounted) {
      setState(
        () {
          currentQuestionIndex++;
          resetColors();
          timer.cancel();
          seconds = 60;
          startTimer();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          toolbarHeight: 80.h,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.outline, size: 32.sp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        body: FutureBuilder<List<QuizTrivia>>(
          future: widget.quizTriviaQuestionList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              var currentQuestion = data[currentQuestionIndex];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "$seconds",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    fontSize: 24.sp),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width < 600
                                    ? 120.w
                                    : 90.w,
                                height: 90.h,
                                child: CircularProgressIndicator(
                                  value: seconds / 60,
                                  valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Question no ${currentQuestionIndex + 1} of ${data.length}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 18.sp),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (data.length - 1 != currentQuestionIndex)
                          Padding(
                            padding: EdgeInsets.all(12.sp),
                            child: InkWell(
                              onTap: () {
                                gotoNextQuestion();
                              },
                              child: Container(
                                width: 100.w,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10.sp), // 15
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF46A0AE),
                                      Color(0xFF00FFCB)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        currentQuestion.question,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        String optionText;
                        switch (index) {
                          case 0:
                            optionText = currentQuestion.optionA;
                            break;
                          case 1:
                            optionText = currentQuestion.optionB;
                            break;
                          case 2:
                            optionText = currentQuestion.optionC;
                            break;
                          case 3:
                            optionText = currentQuestion.optionD;
                            break;
                          default:
                            optionText = "Option not found";
                        }
                        return GestureDetector(
                          onTap: () {
                            if (!optionsClicked) {
                              setState(
                                () {
                                  optionsClicked = true;
                                  // Determine if the selected option is correct
                                  isCorrect = currentQuestion.correctAnswer ==
                                      optionText;

                                  if (optionsClicked) {
                                    // Find the index of the correct answer
                                    int correctAnswerIndex = currentQuestion
                                                .correctAnswer ==
                                            currentQuestion.optionA
                                        ? 0
                                        : currentQuestion.correctAnswer ==
                                                currentQuestion.optionB
                                            ? 1
                                            : currentQuestion.correctAnswer ==
                                                    currentQuestion.optionC
                                                ? 2
                                                : 3;
                                    // Mark the correct answer as correct
                                    optionStates[correctAnswerIndex] = true;
                                  }

                                  // Increment points if the answer is correct
                                  if (isCorrect) {
                                    points = points + 1;
                                  }
                                },
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 20),
                              width: MediaQuery.of(context).size.width - 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Center(
                                      child: Text(
                                        optionText,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  // Decide which icon to show based on the option's state
                                  optionsClicked
                                      ? Icon(
                                          optionStates[index]
                                              ? CupertinoIcons
                                                  .checkmark_alt_circle_fill
                                              : CupertinoIcons
                                                  .xmark_circle_fill,
                                          color: optionStates[index]
                                              ? Colors.green
                                              : Colors.red,
                                        )
                                      : const Icon(
                                          CupertinoIcons.circle,
                                        )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Are you sure you want to Submit the quiz?',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuizScoreScreen(
                                          points,
                                          data.length,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 200.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20.sp),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: const Text("Submit Quiz",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
