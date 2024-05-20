// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/courses.dart';
import '../../appDBFunctions.dart';

class SideBar extends StatefulWidget {
  final Function(String) onSelectClass; // Callback to handle class selection

  const SideBar({
    Key? key,
    required this.onSelectClass,
  }) : super(key: key);

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  var appDB;
  late Future<List<Course>> coursesList;
  late Course preSelectedCourse;
  var _currentSelectedCourseID;

  late Course course;

  Future update_currentSelectedCourse() async {
    final appDB = appDBFunctions();
    appDB.getSelectedCourse().then((selectedCourse) {
      if (mounted) {
        setState(() {
          preSelectedCourse = selectedCourse;
          _currentSelectedCourseID = selectedCourse.courseID;

          widget.onSelectClass(_currentSelectedCourseID);
        });
      }
    });
  }

  updateCourse() async {
    final appDB = appDBFunctions();
    await appDB.updateCourse(_currentSelectedCourseID);
    if (mounted) {
      setState(() {
        coursesList = appDB.getAllCourses();
        update_currentSelectedCourse();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeDBAndData();
  }

  void _initializeDBAndData() async {
    final appDB = appDBFunctions();
    if (mounted) {
      setState(() {
        coursesList = appDB.getAllCourses();
        update_currentSelectedCourse();
      });
    }
  }

  void selectCourse(String courseID, String courseName) {
    if (mounted) {
      setState(() {
        _currentSelectedCourseID = courseID;

        final selectedCourseID = _currentSelectedCourseID;

        widget.onSelectClass(selectedCourseID);

        updateCourse();
      });
    }
  }

  String getSvgFileName(String courseName) {
    switch (courseName.toLowerCase()) {
      case 'arts':
        return 'assets/img/class/arts.svg';
      case 'commerce':
        return 'assets/img/class/commerce.svg';
      case 'science':
        return 'assets/img/class/science.svg';
      default:
        return 'assets/img/class/arts.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width < 900
          ? MediaQuery.of(context).size.width * 0.7
          : MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 300.h,
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  "Nice e Scholar",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w800),
                ),
                accountEmail: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "www.niceinfotech.com",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                currentAccountPicture: const Image(
                  image: AssetImage(
                    'assets/img/logo_main.png',
                  ),
                  fit: BoxFit.contain,
                ),
                currentAccountPictureSize: const Size(150, 120),
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ),
            FutureBuilder<List<Course>>(
              future: coursesList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is loading, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If an error occurs, show an error message.
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 50.w, left: 10.w),
                        child: SizedBox(
                          height: 90.h,
                          child: Align(
                            alignment: Alignment.center,
                            child: ListTile(
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    snapshot.data[index].courseName,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width <
                                              600
                                          ? 24.sp
                                          : MediaQuery.of(context).size.width <
                                                  900
                                              ? 20.sp
                                              : 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40.h,
                                    width: 40.w,
                                    child: SvgPicture.asset(
                                      getSvgFileName(
                                          snapshot.data[index].stream),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                selectCourse(snapshot.data[index].courseID,
                                    snapshot.data[index].courseName);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const ListTile(
                    leading: Icon(Icons.import_contacts),
                    title: Text("No Courses Found"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
