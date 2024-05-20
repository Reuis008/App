import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/models/quiz_trivia_category.dart';
import 'package:lms_v_2_0_0/ui/quiz/quiz_setList.dart';
import 'package:lms_v_2_0_0/ui/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class QuizList extends StatefulWidget {
  const QuizList({super.key});

  @override
  State<QuizList> createState() => _QuizListState();
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

class _QuizListState extends State<QuizList> {
  final List<QuizTriviaCategory> quizList = QuizTriviaCategory.quizTriviaList;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 20));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Padding(
        padding: EdgeInsets.only(left: 15.h, right: 15.h),
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading, display a loading indicator
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width < 600
                                  ? 1
                                  : (MediaQuery.of(context).size.width < 900
                                      ? 2
                                      : 3),
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
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  // gradient: const LinearGradient(colors: [
                                  //   Color(0xffab47bc),
                                  //   Color(0xffba68c8),
                                  // ]),
                                  borderRadius: BorderRadius.circular(12.5.h),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       offset: const Offset(0, 3),
                                  //       blurRadius: 10,
                                  //       spreadRadius: 1,
                                  //       color: Colors.black.withOpacity(.4)),
                                  // ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // If an error occurs, display an error message
              return ListTile(
                // ignore: prefer_const_constructors
                leading: Icon(Icons.error),
                title: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: quizList.length,
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
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (quizList[index].type == 'webview') {
                            } else if (quizList[index].type == 'widget') {
                              var totalSets =
                                  (int.parse(quizList[index].totalQuestions) /
                                          10)
                                      .ceil()
                                      .toString();
                              Navigator.of(context).push(
                                ScaleInRoute(
                                  page: QuizSetList(
                                    title: quizList[index].name,
                                    metawords: quizList[index].metawords,
                                    totalSets: totalSets,
                                    value: quizList[index].value,
                                    totalQuestions:
                                        quizList[index].totalQuestions,
                                    image: quizList[index].imageUrl,
                                  ),
                                ),
                              );
                            }
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
                                              quizList[index].imageUrl,
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
                                                  top: 10.h),
                                              child: Text(
                                                quizList[index].name,
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontWeight: FontWeight.w800,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width <
                                                              600
                                                          ? 48.sp
                                                          : 24.sp,
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
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                              .size
                                                              .width <
                                                          600
                                                      ? 20.w
                                                      : 18.w,
                                                  top: 10.h),
                                              child: Text(
                                                quizList[index]
                                                    .metawords
                                                    .join('\n'),
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
                ),
              );
            } else {
              return const ListTile(
                leading: Icon(Icons.import_contacts),
                title: Text("No Quiz Found"),
              );
            }
          },
        ),
      );
    });
  }
}
