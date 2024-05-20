import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/models/question_bank.dart';
import 'package:lms_v_2_0_0/ui/renderPDF/renderPDF.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class QuestionBankMboseNcertTopic extends StatefulWidget {
  final String title;
  final String? uniqueYear;
  final List<QuestionBank> filteredData;
  const QuestionBankMboseNcertTopic(
      this.filteredData, this.title, this.uniqueYear,
      {super.key});

  @override
  State<QuestionBankMboseNcertTopic> createState() =>
      _QuestionBankMboseNcertTopicState();
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

class _QuestionBankMboseNcertTopicState
    extends State<QuestionBankMboseNcertTopic> {
  int? selectedIndex;
  int count = 0;
  String? encryptedPath;
  Future<List<Directory>?>? _externalStorageDirectories;
  List<QuestionBank>? filteredByCourseID;
  @override
  void initState() {
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
    int compareCourseIDs(String a, String b) {
      switch (a) {
        case 'MBGEN10':
          return -1;
        case 'MBART12':
          return 1;
        case 'MBSCI12':
          return 2;
        case 'MBCOM12':
          return 3;
        default:
          return 0;
      }
    }

    var courseIDsList =
        widget.filteredData.map((item) => item.courseID!).toList();

    courseIDsList.sort(compareCourseIDs);

    Set<String> uniqueCourseIDs = courseIDsList.toSet();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '${widget.title} ${widget.uniqueYear}',
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
                  itemCount: uniqueCourseIDs.length,
                  itemBuilder: (context, index) {
                    String courseID = uniqueCourseIDs.elementAt(index);
                    String CourseName;
                    switch (courseID) {
                      case 'MBGEN10':
                        CourseName = 'Class-X';
                        break;
                      case 'MBART12':
                        CourseName = 'XII-Arts';
                        break;
                      case 'MBSCI12':
                        CourseName = 'XII-Science';
                        break;
                      case 'MBCOM12':
                        CourseName = 'XII-Commerce';
                        break;
                      default:
                        CourseName = '';
                    }

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
                                              CourseName,
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
                                      trailing: Icon(
                                        selectedIndex == index
                                            ? CupertinoIcons.chevron_up
                                            : CupertinoIcons.chevron_down,
                                        color: Colors.grey,
                                        size:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 40.sp
                                                : 28.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (selectedIndex == index) {
                                      selectedIndex = null;
                                    } else {
                                      selectedIndex = index;
                                    }
                                    filteredByCourseID = widget.filteredData
                                        .where(
                                            (item) => item.courseID == courseID)
                                        .toList();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        if (selectedIndex == index)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50.h,
                                child: Card(
                                  color: const Color(0xffFFF3E0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  elevation: 0,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 45.w, top: 5.h, bottom: 5.h),
                                    child: Text(
                                      'Read',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filteredByCourseID!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 8.h, right: 16.w, left: 40.w),
                                      child: SizedBox(
                                        height: 80.h,
                                        child: Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          elevation: 2,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: ListTile(
                                              title: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.picture_as_pdf,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      filteredByCourseID![index]
                                                          .documentName!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  ScaleInRoute(
                                                    page: PdfRender(
                                                        pdfName:
                                                            filteredByCourseID![
                                                                    index]
                                                                .documentName!,
                                                        pdfPath: p.join(
                                                          encryptedPath!,
                                                          filteredByCourseID![
                                                                  index]
                                                              .documentPath!,
                                                        ),
                                                        pdfType: "data"),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
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
