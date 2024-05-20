import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/models/exampreparatoryquiz.dart';
import 'package:lms_v_2_0_0/ui/exampreparatory/questionbankneetjeetTest/component/questionbankneetjeeTestquiz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class QuestionBankNeetJeetTestTopic extends StatefulWidget {
  final String? uniqueSubjectID;
  final List<Exampreparatory> filteredData;
  const QuestionBankNeetJeetTestTopic(this.filteredData, this.uniqueSubjectID,
      {super.key});

  @override
  State<QuestionBankNeetJeetTestTopic> createState() =>
      _QuestionBankNeetJeetTestTopicState();
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

class _QuestionBankNeetJeetTestTopicState
    extends State<QuestionBankNeetJeetTestTopic> {
  int? selectedIndex;
  int count = 0;
  String? SubjectName;
  String? encryptedPath;
  Future<List<Directory>?>? _externalStorageDirectories;
  @override
  void initState() {
    switch (widget.uniqueSubjectID) {
      case 'MBSCI12PHY157':
        SubjectName = 'XII-Science Physics';
        break;
      case 'MBSCI12BIO358':
        SubjectName = 'XII-Science Biology';
        break;
      case 'MBSCI12CHE153':
        SubjectName = 'XII-Science Chemistry';
        break;
      case 'MBSCI11CHE514':
        SubjectName = 'XI-Science Chemistry';
        break;
      case 'MBSCI11MAT151':
        SubjectName = 'XI-Science Mathematics';
        break;
      case 'MBSCI12MAT873':
        SubjectName = 'XII-Science Mathematics';
        break;
      default:
        SubjectName = '';
    }
    _requestExternalStorageDirectories();
    super.initState();
  }

  void _requestExternalStorageDirectories() {
    setState(() {
      _externalStorageDirectories = getExternalStorageDirectories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          SubjectName!,
          style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: MediaQuery.of(context).size.width < 600
                  ? 32.sp
                  : MediaQuery.of(context).size.width < 900
                      ? 24.sp
                      : 28.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.outline,
            size: MediaQuery.of(context).size.width < 600 ? 40.sp : 32.sp,
          ),
          onPressed: () {
            Navigator.of(context).popUntil((_) => count++ >= 1);
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _externalStorageDirectories,
            builder: (BuildContext externalContext,
                AsyncSnapshot<List<Directory>?> externalSnapshot) {
              if (externalSnapshot.data == null || externalSnapshot.hasError) {
                return const Center(
                  child: Text(
                    'Reading SD Card....',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              } else if (externalSnapshot.data != null &&
                  externalSnapshot.data!.length < 2 &&
                  externalSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text(
                    'Please wait ...',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              } else if (externalSnapshot.data != null &&
                  externalSnapshot.data!.length < 2 &&
                  externalSnapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      title: Center(
                        child: Text(
                          'SD Card not found',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                encryptedPath = p.join(externalSnapshot.data![1].path);

                return ListView.builder(
                  itemCount: widget.filteredData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 8.h, top: 8.h, right: 16.w, left: 16.w),
                          child: SizedBox(
                            height: 150.h,
                            child: SizedBox(
                              height: 150.h,
                              child: InkWell(
                                child: Card.outlined(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          Flexible(
                                            child: Text(
                                              widget.filteredData[index]
                                                  .quizName!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        600
                                                    ? 24.sp
                                                    : MediaQuery.of(context)
                                                                .size
                                                                .width <
                                                            900
                                                        ? 20.sp
                                                        : 24.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.right_chevron,
                                            color: Colors.grey,
                                            size: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    600
                                                ? 40.sp
                                                : 28.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    ScaleInRoute(
                                      page: NeetJeeQuizScreen(
                                        widget.filteredData[index]
                                            .exampreparatoryID!,
                                        widget.filteredData[index].quizName!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
