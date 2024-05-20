import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/assessmentquiz.dart';
import 'package:lms_v_2_0_0/models/chapters.dart';
import 'package:lms_v_2_0_0/models/topics.dart';
import 'package:lms_v_2_0_0/ui/renderPDF/renderPDF.dart';
import 'package:lms_v_2_0_0/ui/subject/assessment/assessmentQuiz.dart';
import 'package:lms_v_2_0_0/ui/videoPlayer/subjectVideoPlayer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ChapterList extends StatefulWidget {
  final List<Chapter> filteredData;
  final String? uniqueUnitNumber;

  const ChapterList(this.filteredData, this.uniqueUnitNumber, {super.key});

  @override
  State<ChapterList> createState() => _ChapterListState();
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

class _ChapterListState extends State<ChapterList> {
  int? selectedIndex;
  int count = 0;
  var SubjectID;

  var UnitNo;
  var ChapterNo;

  Future<List<Topic>>? videoTopicList;
  Future<List<Topic>>? pdfTopicList;
  Future<List<Assessment>>? assessmentList;
  String? encryptedPath;
  Future<List<Directory>?>? _externalStorageDirectories;
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

  void _showChapterName(String chapterName) {
    final appDB = appDBFunctions();
    setState(() {
      videoTopicList = appDB.getTopics(SubjectID, UnitNo, ChapterNo);
      pdfTopicList = appDB.getPDFTopics(SubjectID, UnitNo, ChapterNo);
      assessmentList = appDB.getAssessmentQuiz(SubjectID, chapterName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Unit ${widget.uniqueUnitNumber}',
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
                    final chapterName = widget.filteredData[index].chapterName!;
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
                                              chapterName,
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
                                  SubjectID =
                                      widget.filteredData[index].subjectID;
                                  UnitNo = widget.filteredData[index].unitNo;
                                  ChapterNo =
                                      widget.filteredData[index].chapterNo;
                                  setState(() {
                                    if (selectedIndex == index) {
                                      selectedIndex = null;
                                    } else {
                                      selectedIndex = index;
                                      _showChapterName(chapterName);
                                    }
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
                              FutureBuilder<List<Topic>>(
                                future: pdfTopicList,
                                builder: (BuildContext pdfContext,
                                    AsyncSnapshot<List<Topic>> pdfSnapshot) {
                                  if (pdfSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (pdfSnapshot.hasError) {
                                    return Center(
                                        child: Text(
                                            'Error: ${pdfSnapshot.error}'));
                                  } else {
                                    if (pdfSnapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'No Books Found For This Chapter',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children:
                                            pdfSnapshot.data!.map((pdfTopic) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 8.h,
                                                right: 16.w,
                                                left: 40.w),
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
                                                            pdfTopic.topicName!
                                                                .toLowerCase(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        ScaleInRoute(
                                                          page: PdfRender(
                                                            pdfName: pdfTopic
                                                                .chapterName!,
                                                            pdfPath: p.join(
                                                                encryptedPath!,
                                                                pdfTopic.path),
                                                            pdfType:
                                                                pdfTopic.type!,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                  }
                                },
                              ),
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
                                      'Learn',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              FutureBuilder<List<Topic>>(
                                future: videoTopicList,
                                builder: (BuildContext videoContext,
                                    AsyncSnapshot<List<Topic>> videoSnapshot) {
                                  if (videoSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (videoSnapshot.hasError) {
                                    return Center(
                                        child: Text(
                                            'Error: ${videoSnapshot.error}'));
                                  } else {
                                    if (videoSnapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'No Video Found For This Chapter',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children:
                                            videoSnapshot.data!.map((topic) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 8.h,
                                                right: 16.w,
                                                left: 40.w),
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
                                                          Icons
                                                              .play_circle_fill_rounded,
                                                          color: Colors.black,
                                                        ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            topic.topicName!
                                                                .toLowerCase(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        ScaleInRoute(
                                                            page:
                                                                subjectVideoPlayer(
                                                          encryptedPath,
                                                          topic.path,
                                                          widget.filteredData,
                                                          widget
                                                              .uniqueUnitNumber,
                                                        )),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                  }
                                },
                              ),
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
                                      'Assessments',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              FutureBuilder<List<Assessment>>(
                                future: assessmentList,
                                builder: (BuildContext assessmentContext,
                                    AsyncSnapshot assessmentSnapshot) {
                                  if (assessmentSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (assessmentSnapshot.hasError) {
                                    return ListTile(
                                      leading: const Icon(Icons.error),
                                      title: Text(
                                        "Error: ${assessmentSnapshot.error}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                        ),
                                      ),
                                    );
                                  } else if (assessmentSnapshot.hasData) {
                                    if (assessmentSnapshot.data.length == 0) {
                                      return Center(
                                        child: Text(
                                          'No Assessment Found For This Chapter',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children: assessmentSnapshot.data!
                                            .map<Widget>((assessmentTopic) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 8.h,
                                                right: 16.w,
                                                left: 40.w),
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
                                                            Icons
                                                                .assignment_rounded,
                                                            color:
                                                                Colors.black),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            assessmentTopic
                                                                .chapterName,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Text(
                                                      assessmentTopic.level,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        ScaleInRoute(
                                                          page:
                                                              AssessmentQuizStartScreen(
                                                            assessmentTopic
                                                                .classTestID,
                                                            assessmentTopic
                                                                .chapterName,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                  } else {
                                    return const ListTile(
                                      title: Text(
                                        "No Assemssment Found",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
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
