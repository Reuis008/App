import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/models/videos_category_neet_jee.dart';
import 'package:lms_v_2_0_0/ui/studyMaterial/videoList/chapterList.dart';

import 'package:lms_v_2_0_0/models/videos_subject_neet_jee.dart';

class UnitList extends StatefulWidget {
  final String unitName;
  final Future<List<VideosSubjectNEETJEE>>? videosSubjectUnitList;
  final List<String>? metawords;
  final String? name;
  final String? selectedValue;
  final String imageUrl;
  final String endColor;
  const UnitList(this.unitName, this.videosSubjectUnitList, this.metawords,
      this.name, this.selectedValue, this.imageUrl, this.endColor,
      {super.key});

  @override
  State<UnitList> createState() => _UnitListState();
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

class _UnitListState extends State<UnitList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          // print(mathVids);
          FutureBuilder<List<VideosSubjectNEETJEE>>(
              future: widget.videosSubjectUnitList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<VideosSubjectNEETJEE>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<VideosCategoryNEETJEE> vidsarr = [];

                  for (int i = 0; i < snapshot.data!.length; i++) {
                    if (snapshot.data![i].subjectName == widget.unitName) {
                      for (int j = 0;
                          j < snapshot.data![i].unitNames!.length;
                          j++) {
                        vidsarr.add(snapshot.data![i].unitNames![j]);
                      }
                    }
                  }
                  return ListView.builder(
                    itemCount: vidsarr.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 8.h, right: 16.w, left: 16.w),
                        child: SizedBox(
                          height: 150.h,
                          child: Card.outlined(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(
                                  7), // Adjust the border radius as needed
                            ), // Adjust the elevation as needed
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
                                        vidsarr[index].unitName!,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.right_chevron,
                                      color: Colors.grey,
                                      size: MediaQuery.of(context).size.width <
                                              600
                                          ? 40.sp
                                          : 28.sp,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    ScaleInRoute(
                                      page: ChapterList(
                                        vidsarr[index],
                                        widget.unitName,
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
                    },
                  );
                }
              }),
    );
  }
}
