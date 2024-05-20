import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/quiz_trivia.dart';
import 'package:lms_v_2_0_0/ui/quiz/screen/component/quiz_screen.dart';

class QuizStartScreen extends StatefulWidget {
  final String curentCategory;
  final int curentSet;

  const QuizStartScreen({
    super.key,
    required this.curentCategory,
    required this.curentSet,
  });

  @override
  State<QuizStartScreen> createState() => _QuizStartScreenState();
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

class _QuizStartScreenState extends State<QuizStartScreen> {
  var appDB;
  Future<List<QuizTrivia>>? quizTriviaQuestionList;

  @override
  void initState() {
    super.initState();
    appDB = appDBFunctions();
    quizTriviaQuestionList =
        appDB.getQuizTriviaQuestions(widget.curentCategory, widget.curentSet);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/img/quiz/quiz_start_screen.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  "Train your brain",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "and raise your IQ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      ScaleInRoute(
                        page: QuizScreen(
                          quizTriviaQuestionList,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 400.w,
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
                    child: const Text("Start Quiz",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              const Spacer(flex: 2), // it will take 2/6 spaces
            ],
          ),
        ),
      ),
    );
  }
}
