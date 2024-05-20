import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/models/exampreparartory_questions.dart';
import 'package:lms_v_2_0_0/ui/exampreparatory/questionbankneetjeetTest/component/questionbankneetjeeTestquizAnswerScreen.dart';

class ExampreparatoryNeetJeeQuizScoreScreen extends StatefulWidget {
  final length;
  final int points;
  final List<List<bool>> globalOptionStates;
  final Future<List<ExampreparatoryQuestions>>? exampreparatoryTestQuestionList;
  const ExampreparatoryNeetJeeQuizScoreScreen(this.points, this.length,
      this.globalOptionStates, this.exampreparatoryTestQuestionList,
      {super.key});

  @override
  State<ExampreparatoryNeetJeeQuizScoreScreen> createState() =>
      _ExampreparatoryNeetJeeQuizScoreScreenState();
}

class ScaleInRoute extends PageRouteBuilder {
  final Widget page;

  ScaleInRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        );
}

class _ExampreparatoryNeetJeeQuizScoreScreenState
    extends State<ExampreparatoryNeetJeeQuizScoreScreen> {
  int count = 0;
  int notattemt = 0;
  int attemt = 0;
  @override
  void initState() {
    for (List<bool> optionState in widget.globalOptionStates) {
      if (!optionState.contains(true) && optionState.contains(false)) {
        notattemt++;
      }
      attemt = widget.length - notattemt;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: Column(
          children: [
            Center(
              child: SizedBox(
                height: 250.h,
                width: 250.w,
                child: SvgPicture.asset(
                  'assets/img/exampreparatory/exampreparatoryScore.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Text(
                'Your Mock Test have been submitted!',
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Your score is ${widget.points} out of ${widget.length}!!',
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Container(
              height: 250.h,
              padding: EdgeInsets.all(12.sp),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '${widget.length}',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 24.sp),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height < 800
                                  ? MediaQuery.of(context).size.height * 0.25
                                  : MediaQuery.of(context).size.height * 0.1,
                              child: CircularProgressIndicator(
                                value: 60,
                                valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Total questions',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              "$attemt",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 24.sp),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height < 800
                                  ? MediaQuery.of(context).size.height * 0.25
                                  : MediaQuery.of(context).size.height * 0.1,
                              child: CircularProgressIndicator(
                                value: 60,
                                valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Attempted questions',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              "$notattemt",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: 24.sp),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height < 800
                                  ? MediaQuery.of(context).size.height * 0.25
                                  : MediaQuery.of(context).size.height * 0.1,
                              child: CircularProgressIndicator(
                                value: 60,
                                valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Unattempted questions',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      ScaleInRoute(
                        page: ExampreparatoryNeetJeeQuizAnswerScreen(
                            widget.exampreparatoryTestQuestionList,
                            widget.globalOptionStates),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.sp), // 15
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      "Review Answers",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).popUntil((_) => count++ >= 4);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.sp), // 15
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      "Go Back",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
