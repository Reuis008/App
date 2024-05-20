import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/videos_category_neet_jee.dart';
import 'package:lms_v_2_0_0/models/videos_neet_jee.dart';
import 'package:lms_v_2_0_0/ui/videoPlayer/studyVideoPlayerDialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ChapterList extends StatefulWidget {
  final VideosCategoryNEETJEE vidsarr;
  final String subjectName;
  final String? name;
  final List<String>? metawords;
  final String? selectedValue;
  final String? imageUrl;

  const ChapterList(
    this.vidsarr,
    this.subjectName,
    this.name,
    this.metawords,
    this.selectedValue,
    this.imageUrl, {
    super.key,
  });

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
  int? selectedIndex; // State to track the selected item

  Future<List<VideosNEETJEE>>? videosNEETJEEList;
  String? encryptedVideoPath;
  Future<List<Directory>?>? _externalStorageDirectories;
  int count = 0;
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
      videosNEETJEEList = appDB.getNEETJEETopics(
          widget.subjectName, widget.vidsarr.unitName, chapterName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.vidsarr.unitName!,
          style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: MediaQuery.of(context).size.width < 600
                  ? 32.sp
                  : MediaQuery.of(context).size.width < 900
                      ? 24.sp
                      : 28.sp,
              fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80.h,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
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
          ListView.builder(
            itemCount: widget.vidsarr.chapterNames!.length,
            itemBuilder: (context, index) {
              final chapterName = widget.vidsarr.chapterNames![index];
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 8.h, top: 8.h, right: 16.w, left: 16.w),
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
                                        fontSize:
                                            MediaQuery.of(context).size.width <
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
                                size: MediaQuery.of(context).size.width < 600
                                    ? 40.sp
                                    : 28.sp,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex =
                                  null; // Hide nested list if tapped again
                            } else {
                              selectedIndex =
                                  index; // Show nested list for the tapped item
                              _showChapterName(chapterName);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  if (selectedIndex == index)
                    FutureBuilder<List<VideosNEETJEE>>(
                      future: videosNEETJEEList,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<VideosNEETJEE>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return FutureBuilder(
                            future: _externalStorageDirectories,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Directory>?>
                                    directorySnapshot) {
                              if (directorySnapshot.data == null ||
                                  directorySnapshot.hasError) {
                                return const Center(
                                  child: Text(
                                    'Reading SD Card....',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              } else if (directorySnapshot.data != null &&
                                  directorySnapshot.data!.length < 2 &&
                                  directorySnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                return const Center(
                                  child: Text(
                                    'Please wait ...',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              } else if (directorySnapshot.data != null &&
                                  directorySnapshot.data!.length < 2 &&
                                  directorySnapshot.connectionState ==
                                      ConnectionState.done) {
                                return const Center(
                                  child: Text(
                                    'SD Card not found',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              } else {
                                encryptedVideoPath =
                                    p.join(directorySnapshot.data![1].path);

                                return Column(
                                  children: snapshot.data!.map((topic) {
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
                                                    Icons
                                                        .play_circle_fill_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Text(
                                                    topic.topicName!
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  ScaleInRoute(
                                                    page:
                                                        studyVideoPlayerDialog(
                                                      encryptedVideoPath,
                                                      topic.path,
                                                      widget.vidsarr,
                                                      widget.subjectName,
                                                      widget.name,
                                                      widget.metawords,
                                                      widget.selectedValue,
                                                      widget.imageUrl,
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
                            },
                          );
                        }
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
