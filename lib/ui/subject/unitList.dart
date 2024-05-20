import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/chapters.dart';
import 'package:lms_v_2_0_0/ui/subject/bookvideolist/chapterList.dart';

class SubjectUnitList extends StatefulWidget {
  final dynamic subjectID;
  final subjectName;
  final totalChapters;
  final totalVideos;
  final totalBooks;
  const SubjectUnitList(this.subjectID, this.subjectName, this.totalChapters,
      this.totalVideos, this.totalBooks,
      {super.key});

  @override
  State<SubjectUnitList> createState() => _SubjectUnitListState();
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

class _SubjectUnitListState extends State<SubjectUnitList>
    with SingleTickerProviderStateMixin {
  int count = 0;

  Future<List<Chapter>>? chaptersList;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _initializeDBAndData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initializeDBAndData() async {
    final appDB = appDBFunctions();
    final selectedSubjectId = widget.subjectID;
    setState(() {
      chaptersList = appDB.getChapters(selectedSubjectId);
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
    final screenWidth = MediaQuery.of(context).size.width;
    double scrollHeight = screenWidth < 600
        ? MediaQuery.of(context).size.height * 1.1.h
        : (screenWidth < 900
            ? MediaQuery.of(context).size.height * 0.84.h
            : MediaQuery.of(context).size.height * 0.64.h);
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: innerBoxIsScrolled
                ? Text(
                    widget.subjectName!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: MediaQuery.of(context).size.width < 600
                            ? 32.sp
                            : MediaQuery.of(context).size.width < 900
                                ? 24.sp
                                : 28.sp,
                        fontWeight: FontWeight.bold),
                  )
                : null,
            centerTitle: true,
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
            pinned: true,
            expandedHeight: 400.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 90.h),
                          Text(
                            widget.subjectName!.contains(' ')
                                ? widget.subjectName!.replaceFirst(' ', '\n')
                                : widget.subjectName!,
                            softWrap: true,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: MediaQuery.of(context).size.width <
                                        600
                                    ? 48.sp
                                    : MediaQuery.of(context).size.width < 900
                                        ? 34.sp
                                        : 38.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Chapters ${widget.totalChapters}',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: MediaQuery.of(context).size.width <
                                        600
                                    ? 32.sp
                                    : MediaQuery.of(context).size.width < 900
                                        ? 20.sp
                                        : 28.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Videos ${widget.totalVideos}',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: MediaQuery.of(context).size.width <
                                        600
                                    ? 32.sp
                                    : MediaQuery.of(context).size.width < 900
                                        ? 20.sp
                                        : 28.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Books ${widget.totalBooks}',
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: MediaQuery.of(context).size.width <
                                        600
                                    ? 32.sp
                                    : MediaQuery.of(context).size.width < 900
                                        ? 20.sp
                                        : 28.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 250,
                        width: 300,
                        child: SvgPicture.asset(
                          getSvgFileName(
                            widget.subjectName!,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: SizedBox(
        height: scrollHeight,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FutureBuilder<List<Chapter>>(
            future: chaptersList,
            builder:
                (BuildContext context, AsyncSnapshot<List<Chapter>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // Extract unique unit numbers
                final uniqueUnitNumbers = snapshot.data!
                    .map((chapter) => chapter.unitNo)
                    .toSet()
                    .toList();
                // Filter data based on unique unit numbers

                return ListView.builder(
                  itemCount: uniqueUnitNumbers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 12.h, right: 16.w, left: 16.w),
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
                                      'Unit ${uniqueUnitNumbers[index]}',
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
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.right_chevron,
                                    color: Colors.grey,
                                    size:
                                        MediaQuery.of(context).size.width < 600
                                            ? 40.sp
                                            : 28.sp,
                                  ),
                                ],
                              ),
                              onTap: () {
                                final filteredData = snapshot.data!
                                    .where((chapter) =>
                                        chapter.unitNo ==
                                        uniqueUnitNumbers[index])
                                    .toList();

                                Navigator.push(
                                  context,
                                  ScaleInRoute(
                                    page: ChapterList(
                                        filteredData, uniqueUnitNumbers[index]),
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
          ),
        ),
      ),
    );
  }
}
