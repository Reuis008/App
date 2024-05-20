import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/assessment_questions.dart';
import 'package:lms_v_2_0_0/ui/subject/assessment/component/assessmentScoreScreen.dart';
import "package:hex/hex.dart";

class AssessmentQuizScreen extends StatefulWidget {
  final classTestID;
  const AssessmentQuizScreen(this.classTestID, {super.key});

  @override
  State<AssessmentQuizScreen> createState() => _AssessmentQuizScreenState();
}

class _AssessmentQuizScreenState extends State<AssessmentQuizScreen> {
  Future<List<AssessmentQuestions>>? assessmentQuestionList;
  var currentQuestionIndex = 0;
  bool isCorrect = false;
  int points = 0;
  List<List<bool>> globalOptionStates = [];
  List<bool> optionStates = List.filled(4, false);

  @override
  @override
  void initState() {
    super.initState();
    var appDB = appDBFunctions();
    assessmentQuestionList =
        appDB.getAssessmentQuizQuestions(widget.classTestID);

    // Initialize globalOptionStates when assessmentQuestionList has data
    assessmentQuestionList!.then((questions) {
      setState(() {
        globalOptionStates = List.generate(
          questions.length,
          (index) => List.filled(4, false),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateOptionState(int questionIndex, int optionIndex, bool isSelected) {
    setState(() {
      globalOptionStates[questionIndex].fillRange(0, 4, false);
      globalOptionStates[questionIndex][optionIndex] = isSelected;
    });
  }

  gotoNextQuestion() {
    if (mounted) {
      setState(
        () {
          currentQuestionIndex++;
        },
      );
    }
  }

  gotoPreviousQuestion() {
    if (mounted && currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
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
        body: FutureBuilder<List<AssessmentQuestions>>(
          future: assessmentQuestionList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              var currentQuestion = data[currentQuestionIndex];
              Uint8List? imageBytes;
              if (currentQuestion.diagram != null) {
                imageBytes =
                    Uint8List.fromList(HEX.decode(currentQuestion.diagram!));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (imageBytes != null)
                      SizedBox(
                        height: 300.h,
                        width: 500.w,
                        child: Image.memory(
                          Uint8List.fromList(imageBytes),
                          fit: BoxFit.contain,
                        ),
                      ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        String optionIndex = '';
                        // List<bool> optionStates = List.filled(4, false);
                        switch (index) {
                          case 0:
                            optionText = currentQuestion.optionA;
                            optionIndex = "optionA";
                            break;
                          case 1:
                            optionText = currentQuestion.optionB;
                            optionIndex = "optionB";
                            break;
                          case 2:
                            optionText = currentQuestion.optionC;
                            optionIndex = "optionC";
                            break;
                          case 3:
                            optionText = currentQuestion.optionD;
                            optionIndex = "optionD";
                            break;
                          default:
                            optionText = "Option not found";
                        }
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              updateOptionState(
                                  currentQuestionIndex, index, true);
                              // Reset all options to not selected
                              optionStates =
                                  List.filled(optionIndex.length, false);
                              // Set the tapped option to selected
                              optionStates[index] = true;
                            });
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
                                  Icon(
                                    globalOptionStates[currentQuestionIndex]
                                            [index]
                                        ? CupertinoIcons
                                            .checkmark_alt_circle_fill
                                        : CupertinoIcons.circle,
                                    color: globalOptionStates[
                                            currentQuestionIndex][index]
                                        ? Colors.green
                                        : Colors
                                            .grey, // Conditionally set the icon color based on the state
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: currentQuestionIndex > 0
                              ? Padding(
                                  padding: EdgeInsets.all(12.sp),
                                  child: InkWell(
                                    onTap: () {
                                      gotoPreviousQuestion();
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: const Text(
                                        "Previous",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 120.w,
                                ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Are you sure you want to Submit the Assessment?',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        for (int i = 0; i < data.length; i++) {
                                          int correctOptionIndex = [
                                            'optionA',
                                            'optionB',
                                            'optionC',
                                            'optionD'
                                          ].indexOf(data[i].answer);
                                          if (globalOptionStates[i]
                                                  .contains(true) &&
                                              globalOptionStates[i]
                                                      .indexOf(true) ==
                                                  correctOptionIndex) {
                                            points++;
                                          }
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AssessmentScoreScreen(
                                                    points,
                                                    data.length,
                                                    globalOptionStates,
                                                    assessmentQuestionList),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: const Text("Submit Assessment",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Container(
                          child: data.length - 1 != currentQuestionIndex
                              ? Padding(
                                  padding: EdgeInsets.all(12.sp),
                                  child: InkWell(
                                    onTap: () {
                                      gotoNextQuestion();
                                    },
                                    child: Container(
                                      width: 100.w,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10.sp),
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF46A0AE),
                                            Color(0xFF00FFCB)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
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
                                )
                              : Container(
                                  width: 120.w,
                                ),
                        ),
                      ],
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
