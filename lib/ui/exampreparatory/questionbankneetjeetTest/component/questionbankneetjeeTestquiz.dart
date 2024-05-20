import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/exampreparartory_questions.dart';
import 'package:lms_v_2_0_0/ui/exampreparatory/questionbankneetjeetTest/component/QuestionbankneetjeeTestquizScreen.dart';

class NeetJeeQuizScreen extends StatefulWidget {
  final String exampreparatoryID;
  final String quizName;
  const NeetJeeQuizScreen(this.exampreparatoryID, this.quizName, {super.key});

  @override
  State<NeetJeeQuizScreen> createState() => _NeetJeeQuizScreenState();
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

class _NeetJeeQuizScreenState extends State<NeetJeeQuizScreen> {
  Future<List<ExampreparatoryQuestions>>? exampreparatoryTestQuestionList;
  @override
  void initState() {
    super.initState();
    _initializeDBAndData();
  }

  void _initializeDBAndData() async {
    final appDB = appDBFunctions();
    setState(() {
      exampreparatoryTestQuestionList =
          appDB.getExampreparatoryQuizQuestions(widget.exampreparatoryID);
    });
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: SizedBox(
                  height: 500.h,
                  width: 500.w,
                  child: SvgPicture.asset(
                    'assets/img/exampreparatory/mock_test_screen.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.quizName,
                  textAlign: TextAlign.center,
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
                        page: ExampreparatoryNeetJeeQuizScreen(
                            exampreparatoryTestQuestionList),
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
                    child: const Text("Start Mock Test",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
