// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizScoreScreen extends StatefulWidget {
  final length;
  final int points;

  const QuizScoreScreen(this.points, this.length, {super.key});

  @override
  State<QuizScoreScreen> createState() => _QuizScoreScreenState();
}

class _QuizScoreScreenState extends State<QuizScoreScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Column(
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/img/quiz/quiz_score.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                'Congratulations!!',
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
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).popUntil((_) => count++ >= 4);
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
                  child: Text("Go Back",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
