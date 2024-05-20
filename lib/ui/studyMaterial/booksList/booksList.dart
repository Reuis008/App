import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/models/study_materials_neet_jee.dart';
import 'package:lms_v_2_0_0/ui/renderPDF/renderPDF.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BooksUnitList extends StatefulWidget {
  final String unitName;
  final Future<List<StudyMaterialsNeetJee>>? booksList;
  final List<String>? metawords;
  final String? name;
  final String? selectedValue;
  final String endColor;
  const BooksUnitList(this.unitName, this.booksList, this.metawords, this.name,
      this.selectedValue, this.endColor,
      {super.key});

  @override
  State<BooksUnitList> createState() => _BooksUnitListState();
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

class _BooksUnitListState extends State<BooksUnitList> {
  String? encryptedVideoPath;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<StudyMaterialsNeetJee>>(
        future: widget.booksList,
        builder: (BuildContext context,
            AsyncSnapshot<List<StudyMaterialsNeetJee>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<StudyMaterialsNeetJee> booksarr = [];

            for (int i = 0; i < snapshot.data!.length; i++) {
              if (snapshot.data![i].subjectName == widget.unitName) {
                booksarr.add(snapshot.data![i]);
              }
            }
            // print('booksarr $booksarr');
            return FutureBuilder(
              future: _externalStorageDirectories,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Directory>?> snapshot) {
                if (snapshot.data == null || snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Reading SD Card....',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                } else if (snapshot.data != null &&
                    snapshot.data!.length < 2 &&
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text(
                      'Please wait ...',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                } else if (snapshot.data != null &&
                    snapshot.data!.length < 2 &&
                    snapshot.connectionState == ConnectionState.done) {
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
                        )));
                      });
                } else {
                  encryptedVideoPath = p.join(snapshot.data![1].path);
                  return ListView.builder(
                    itemCount: booksarr.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 12.h, top: 15.h, right: 16.w, left: 16.w),
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
                                        booksarr[index].documentName!,
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
                                      page: PdfRender(
                                          pdfName:
                                              booksarr[index].documentName!,
                                          pdfPath: p.join(encryptedVideoPath!,
                                              booksarr[index].documentPath!),
                                          pdfType: "data"),
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
              },
            );
          }
        },
      ),
    );
  }
}
