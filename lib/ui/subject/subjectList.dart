import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/ui/subject/unitList.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/subjects.dart';

class SubjectList extends StatefulWidget {
  final String? selectedCourseID;

  const SubjectList(
    this.selectedCourseID, {
    Key? key,
  }) : super(key: key);

  @override
  State<SubjectList> createState() => _SubjectListState();
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

class _SubjectListState extends State<SubjectList> {
  Future<List<Subject>>? subjectList;
  var appDB;

  var courseNameShort;

  @override
  void initState() {
    super.initState();
    _initializeDBAndData(); // Call this method to initialize subjectList
  }

  @override
  void didUpdateWidget(SubjectList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCourseID != widget.selectedCourseID) {
      // The courseID has changed, so we need to re-fetch the subjects.
      _initializeDBAndData();
    }
  }

  void _initializeDBAndData() async {
    final appDB = appDBFunctions();
    final selectedCoursedId = widget.selectedCourseID;
    setState(() {
      subjectList = appDB.getAllSubjects(selectedCoursedId);
    });
  }

  String getSvgFileName(String subjectName) {
    switch (subjectName.toLowerCase()) {
      case 'alternative english':
        return 'assets/img/subject/alternative english.svg';
      case 'anthropology':
        return 'assets/img/subject/anthropology.svg';
      case 'science':
        return 'assets/img/subject/science.svg';
      case 'computer application':
        return 'assets/img/subject/computer application.svg';
      case 'computer science':
        return 'assets/img/subject/computer science.svg';
      case 'economics':
        return 'assets/img/subject/economics.svg';
      case 'education':
        return 'assets/img/subject/education.svg';
      case 'english':
        return 'assets/img/subject/english.svg';
      case 'environmental education':
        return 'assets/img/subject/environmental education.svg';
      case 'geography':
        return 'assets/img/subject/geography.svg';
      case 'history':
        return 'assets/img/subject/history.svg';
      case 'home science':
        return 'assets/img/subject/home science.svg';
      case 'mathematics':
        return 'assets/img/subject/mathematics.svg';
      case 'philosophy':
        return 'assets/img/subject/philosophy.svg';
      case 'political science':
        return 'assets/img/subject/political science.svg';
      case 'statistics':
        return 'assets/img/subject/statistics.svg';
      default:
        return 'assets/img/subject/english.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h),
      child: FutureBuilder<List<Subject>>(
          future: subjectList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width < 600
                            ? 1
                            : (MediaQuery.of(context).size.width < 900 ? 2 : 3),
                        crossAxisSpacing: 10,
                        mainAxisSpacing:
                            MediaQuery.of(context).size.width < 600 ? 10 : 20,
                        childAspectRatio:
                            MediaQuery.of(context).size.width < 600
                                ? 1.80
                                : 1.29,
                      ),
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, bottom: 15.h, right: 15.w),
                          child: Shimmer(
                            duration: const Duration(seconds: 5),
                            child: Container(
                              width: 400.w,
                              height: 280.h,
                              padding: EdgeInsets.only(
                                  top: 15.h,
                                  bottom: 15.h,
                                  left: 15.w,
                                  right: 15.w),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12.5.h),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 3),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                      color: Colors.black.withOpacity(.4)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              );
            } else if (snapshot.hasError) {
              // If an error occurs, display an error message
              return ListTile(
                // ignore: prefer_const_constructors
                leading: Icon(Icons.error),
                title: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width < 600
                          ? 1
                          : (MediaQuery.of(context).size.width < 900 ? 2 : 3),
                      crossAxisSpacing: 10,
                      mainAxisSpacing:
                          MediaQuery.of(context).size.width < 600 ? 10 : 20,
                      childAspectRatio:
                          MediaQuery.of(context).size.width < 600 ? 1.80 : 1.29,
                    ),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            ScaleInRoute(
                              page: SubjectUnitList(
                                snapshot.data[index].subjectID,
                                snapshot.data[index].subjectName,
                                snapshot.data[index].totalChapters,
                                snapshot.data[index].totalVideos,
                                snapshot.data[index].totalBooks,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Theme.of(context).colorScheme.secondary,
                          elevation: 3.0,
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.5.h),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 100,
                                          child: SvgPicture.asset(
                                            getSvgFileName(
                                              snapshot.data[index].subjectName,
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        600
                                                    ? 20.w
                                                    : 18.w,
                                                top: 10.h,
                                                right: 10.w),
                                            child: Text(
                                              snapshot.data[index].subjectName,
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w800,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        600
                                                    ? 48.sp
                                                    : 20.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 20.w
                                                  : 18.w,
                                              top: 10.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Chapter ${snapshot.data[index].totalChapters}',
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade500,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              600
                                                          ? 34.sp
                                                          : 14.sp,
                                                ),
                                              ),
                                              Text(
                                                'Videos ${snapshot.data[index].totalVideos}',
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade500,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              600
                                                          ? 34.sp
                                                          : 14.sp,
                                                ),
                                              ),
                                              Text(
                                                'Books ${snapshot.data[index].totalBooks}',
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade500,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              600
                                                          ? 34.sp
                                                          : 14.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 20.w
                                                  : 18.w,
                                              top: 10.h),
                                          child: Text(
                                            'Learn more',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.deepOrangeAccent,
                                              //  const Color(0xff98989f),
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 34.sp
                                                  : 16.sp,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                          .size
                                                          .width <
                                                      600
                                                  ? 20.w
                                                  : 10.w,
                                              top: 10.h),
                                          child: Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.deepOrangeAccent,
                                            size: 24.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return const ListTile(
                leading: Icon(Icons.import_contacts),
                title: Text("No subject Found"),
              );
            }
          }),
    );
  }
}
