import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/ui/renderPDF/renderPDF.dart';
import 'package:lms_v_2_0_0/ui/studyMaterial/jeeNeetBooks.dart';
import 'package:lms_v_2_0_0/ui/studyMaterial/jeeNeetVideos.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:lms_v_2_0_0/models/study_materials.dart';
import 'package:url_launcher/url_launcher.dart';

class StudyMaterialsList extends StatefulWidget {
  const StudyMaterialsList({super.key});

  @override
  State<StudyMaterialsList> createState() => _StudyMaterialsListState();
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

class _StudyMaterialsListState extends State<StudyMaterialsList> {
  final List<StudyMaterials> studymaterialsList =
      StudyMaterials.studyMaterialsList;
  var appDB;
  int pageNo = 0;
  var courseNameShort;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 20));
    return true;
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://ncert.nic.in/textbook.php');
    try {
      await launch(url.toString(), forceWebView: true);
    } catch (e) {
      throw Exception('Could not launch $url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: MediaQuery.of(context).size.width < 900
                              ? 28 / 9
                              : 45 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                        itemCount: 3,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, bottom: 15.h, right: 15.w),
                            child: Shimmer(
                              duration: const Duration(seconds: 2),
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
                                      Theme.of(context).colorScheme.secondary,
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
                // If data is available, display the list of subjects
                return Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        aspectRatio: MediaQuery.of(context).size.width < 900
                            ? 28 / 9
                            : 45 / 9,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        enlargeFactor: 0.3,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction:
                            MediaQuery.of(context).size.width < 600
                                ? 0.5
                                : (MediaQuery.of(context).size.width < 900
                                    ? 0.6
                                    : 0.4),
                        onPageChanged: (index, reason) {
                          setState(() {
                            setState(() {
                              pageNo = index;
                            });
                          });
                        },
                      ),
                      itemCount: studymaterialsList.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return GestureDetector(
                          onTap: () {
                            if (studymaterialsList[index].type == 'widget') {
                              if (studymaterialsList[index].value == 'NCERT') {
                                _launchURL();
                              } else if (studymaterialsList[index].value ==
                                      'JEE' ||
                                  studymaterialsList[index].value == 'NEET') {
                                Navigator.push(
                                  context,
                                  ScaleInRoute(
                                    page: JeeNeetBooks(
                                      studymaterialsList[index].value,
                                      studymaterialsList[index].name,
                                      studymaterialsList[index].metawords,
                                      studymaterialsList[index].imageUrl,
                                      studymaterialsList[index].endColor,
                                      studymaterialsList[index].startColor,
                                    ),
                                  ),
                                );
                              } else if (studymaterialsList[index].value ==
                                      'JEEVid' ||
                                  studymaterialsList[index].value ==
                                      'NEETVid') {
                                Navigator.push(
                                  context,
                                  ScaleInRoute(
                                    page: JeeNeetVideos(
                                      studymaterialsList[index].value,
                                      studymaterialsList[index].name,
                                      studymaterialsList[index].metawords,
                                      studymaterialsList[index].imageUrl,
                                      studymaterialsList[index].endColor,
                                      studymaterialsList[index].startColor,
                                    ),
                                  ),
                                );
                              } else if (studymaterialsList[index].value ==
                                  'FormulaeHandbook1') {
                                Navigator.push(
                                  context,
                                  ScaleInRoute(
                                    page: PdfRender(
                                      pdfName: studymaterialsList[index].name,
                                      pdfPath:
                                          'assets/books/Mathematical_Formulae-IX-X.pdf',
                                      pdfType: "asset",
                                    ),
                                  ),
                                );
                              } else if (studymaterialsList[index].value ==
                                  'FormulaeHandbook2') {
                                Navigator.push(
                                  context,
                                  ScaleInRoute(
                                    page: PdfRender(
                                      pdfName: studymaterialsList[index].name,
                                      pdfPath:
                                          'assets/books/Mathematical_Formulae-XI-XII.pdf',
                                      pdfType: "asset",
                                    ),
                                  ),
                                );
                              }
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
                                    // gradient: LinearGradient(
                                    //   colors: [
                                    //     Color(
                                    //       int.parse(
                                    //         studymaterialsList[index]
                                    //             .endColor
                                    //             .replaceFirst('#', '0xFF'),
                                    //       ),
                                    //     ),
                                    //     Color(
                                    //       int.parse(
                                    //         studymaterialsList[index]
                                    //             .startColor
                                    //             .replaceFirst('#', '0xFF'),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              studymaterialsList[index].name,
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
                                                    : 24.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              studymaterialsList[index]
                                                  .metawords
                                                  .join('\n'),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade500,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        600
                                                    ? 34.sp
                                                    : 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                  shape:
                                                      MaterialStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.5.h),
                                                  )),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  )),
                                              onPressed: () {
                                                if (studymaterialsList[index]
                                                        .type ==
                                                    'widget') {
                                                  if (studymaterialsList[index]
                                                          .value ==
                                                      'NCERT') {
                                                    _launchURL();
                                                  } else if (studymaterialsList[
                                                                  index]
                                                              .value ==
                                                          'JEE' ||
                                                      studymaterialsList[index]
                                                              .value ==
                                                          'NEET') {
                                                    Navigator.push(
                                                      context,
                                                      ScaleInRoute(
                                                        page: JeeNeetBooks(
                                                          studymaterialsList[
                                                                  index]
                                                              .value,
                                                          studymaterialsList[
                                                                  index]
                                                              .name,
                                                          studymaterialsList[
                                                                  index]
                                                              .metawords,
                                                          studymaterialsList[
                                                                  index]
                                                              .imageUrl,
                                                          studymaterialsList[
                                                                  index]
                                                              .endColor,
                                                          studymaterialsList[
                                                                  index]
                                                              .startColor,
                                                        ),
                                                      ),
                                                    );
                                                  } else if (studymaterialsList[
                                                                  index]
                                                              .value ==
                                                          'JEEVid' ||
                                                      studymaterialsList[index]
                                                              .value ==
                                                          'NEETVid') {
                                                    Navigator.push(
                                                      context,
                                                      ScaleInRoute(
                                                        page: JeeNeetVideos(
                                                          studymaterialsList[
                                                                  index]
                                                              .value,
                                                          studymaterialsList[
                                                                  index]
                                                              .name,
                                                          studymaterialsList[
                                                                  index]
                                                              .metawords,
                                                          studymaterialsList[
                                                                  index]
                                                              .imageUrl,
                                                          studymaterialsList[
                                                                  index]
                                                              .endColor,
                                                          studymaterialsList[
                                                                  index]
                                                              .startColor,
                                                        ),
                                                      ),
                                                    );
                                                  } else if (studymaterialsList[
                                                              index]
                                                          .value ==
                                                      'FormulaeHandbook1') {
                                                    Navigator.push(
                                                      context,
                                                      ScaleInRoute(
                                                        page: PdfRender(
                                                          pdfName:
                                                              studymaterialsList[
                                                                      index]
                                                                  .name,
                                                          pdfPath:
                                                              'assets/books/Mathematical_Formulae-IX-X.pdf',
                                                          pdfType: "asset",
                                                        ),
                                                      ),
                                                    );
                                                  } else if (studymaterialsList[
                                                              index]
                                                          .value ==
                                                      'FormulaeHandbook2') {
                                                    Navigator.push(
                                                      context,
                                                      ScaleInRoute(
                                                        page: PdfRender(
                                                          pdfName:
                                                              studymaterialsList[
                                                                      index]
                                                                  .name,
                                                          pdfPath:
                                                              'assets/books/Mathematical_Formulae-XI-XII.pdf',
                                                          pdfType: "asset",
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Learn more',
                                                    style: TextStyle(
                                                      fontFamily: 'Raleway',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                      //  const Color(0xff98989f),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width <
                                                                  600
                                                              ? 34.sp
                                                              : 16.sp,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.w),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_rounded,
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                      size: 24.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: SvgPicture.asset(
                                        studymaterialsList[index].imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
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
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            studymaterialsList.length,
            (index) => Container(
              margin: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.circle,
                size: 12.0,
                color: pageNo == index
                    ? Colors.deepOrangeAccent
                    : Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
