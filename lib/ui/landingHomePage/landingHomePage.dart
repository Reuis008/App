import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/courses.dart';

class LandingHomePage extends StatefulWidget {
  final Function(String) onSelectClassID;

  const LandingHomePage({
    super.key,
    required this.onSelectClassID,
  });

  @override
  State<LandingHomePage> createState() => _LandingHomePageState();
}

class _LandingHomePageState extends State<LandingHomePage> {
  int pageNo = 0;
  var appDB;
  Future<List<Course>>? coursesList;
  var _currentSelectedCourseID;

  @override
  void initState() {
    appDB = appDBFunctions();
    coursesList = appDB.getAllCourses();
    super.initState();
  }

  updateCourse() async {
    final appDB = appDBFunctions();
    await appDB.updateCourse(_currentSelectedCourseID);
    if (mounted) {
      setState(() {
        coursesList = appDB.getAllCourses();
      });
    }
  }

  void selectCourse(String courseID, String courseName) {
    if (mounted) {
      setState(() {
        _currentSelectedCourseID = courseID;

        if (_currentSelectedCourseID != null) {
          widget.onSelectClassID(_currentSelectedCourseID);

          updateCourse();
        }
      });
    }
  }

  final List<Widget> _landingPage = [
    const CarouselItem(
      svgPath: 'assets/img/landingHomePage/1.svg',
      title: 'Unlock Your Potential',
      subtitle:
          " Embark on a journey of discovery with our app, offering a treasure trove of educational content. From science, commerce to arts, we're here to guide you through the vast landscape of knowledge, helping you unlock your full potential and achieve your educational goals.",
    ),
    const CarouselItem(
      svgPath: 'assets/img/landingHomePage/2.svg',
      title: 'Empower Your Mind',
      subtitle:
          "Our app serves as a compass for your educational adventure, providing access to a wide array of subjects. With curated educational resources, we empower you to explore new ideas, expand your horizons, and unlock the untapped potential within you.",
    ),
    const CarouselItem(
      svgPath: 'assets/img/landingHomePage/3.svg',
      title: 'Your Path to Knowledge',
      subtitle:
          "Make learning an engaging and accessible experience with our app. We offer a vast library of educational content, meticulously curated to cater to your interests. This ensures you're never left behind in your quest for knowledge, making every step in your educational journey both enlightening and enjoyable.",
    ),
  ];

  void _showDropdownList(String dropdownType) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Select a Subject',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const Divider(
                  thickness: 2,
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
                        shrinkWrap:
                            true, // This is important to avoid the error
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 50.w, left: 10.w),
                            child: SizedBox(
                              height: 90.h,
                              child: ListTile(
                                title: Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      snapshot.data[index].courseName,
                                      style: TextStyle(
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
                                  ],
                                ),
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.auto_stories_rounded,
                                      color: Colors.black,
                                      size: MediaQuery.of(context).size.width <
                                              600
                                          ? 40.sp
                                          : 30.sp,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.7,
                    // aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    enlargeFactor: 0.3,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        setState(() {
                          pageNo = index;
                        });
                      });
                    },
                  ),
                  itemCount: 3,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return _landingPage[index];
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Icon(
                        pageNo == index ? CupertinoIcons.minus : Icons.circle,
                        size: pageNo == index ? 18.0 : 12.0,
                        color: pageNo == index
                            ? Colors.black
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5.h),
                )),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                _showDropdownList('source');
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  final String svgPath;
  final String title;
  final String subtitle;

  const CarouselItem(
      {super.key,
      required this.svgPath,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          child: SvgPicture.asset(
            svgPath,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
