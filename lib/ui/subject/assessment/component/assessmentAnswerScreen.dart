import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/models/assessment_questions.dart';

class AssessmentAnswerScreen extends StatefulWidget {
  final Future<List<AssessmentQuestions>>? assessmentQuestionList;
  final List<List<bool>> globalOptionStates;
  const AssessmentAnswerScreen(
      this.assessmentQuestionList, this.globalOptionStates,
      {super.key});

  @override
  State<AssessmentAnswerScreen> createState() => _AssessmentAnswerScreenState();
}

class _AssessmentAnswerScreenState extends State<AssessmentAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.outline,
              size: MediaQuery.of(context).size.width < 600 ? 40.sp : 32.sp,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: FutureBuilder<List<AssessmentQuestions>>(
            future: widget.assessmentQuestionList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var question = snapshot.data[index];
                    List<bool> optionStates = widget.globalOptionStates[index];
                    // print(snapshot.data);
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 12.h, top: 15.h, right: 16.w, left: 16.w),
                      child: SizedBox(
                        height: 400.h,
                        child: Card.outlined(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 12.w, top: 12.w),
                                  child: Text(
                                    snapshot.data[index].question,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 12.w, left: 12.w),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder: (BuildContext context, int idx) {
                                    String optionText;
                                    bool isCorrect = false;
                                    // List<bool> optionStates = List.filled(4, false);
                                    switch (idx) {
                                      case 0:
                                        optionText = question.optionA;
                                        isCorrect =
                                            question.answer == "optionA";
                                        break;
                                      case 1:
                                        optionText = question.optionB;
                                        isCorrect =
                                            question.answer == "optionB";
                                        break;
                                      case 2:
                                        optionText = question.optionC;
                                        isCorrect =
                                            question.answer == "optionC";
                                        break;
                                      case 3:
                                        optionText = question.optionD;
                                        isCorrect =
                                            question.answer == "optionD";
                                        break;
                                      default:
                                        optionText = "Option not found";
                                    }
                                    bool isSelected = optionStates[idx];
                                    return Container(
                                      // alignment: Alignment.center,
                                      margin: const EdgeInsets.only(bottom: 10),
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isSelected && optionStates[idx]
                                            ? isCorrect
                                                ? Colors.green
                                                : Colors.red
                                            : isCorrect
                                                ? Colors.green
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              optionText,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }
}
