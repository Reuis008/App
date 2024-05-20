import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/study_materials_neet_jee.dart';
import 'package:lms_v_2_0_0/ui/studyMaterial/booksList/booksList.dart';

class JeeNeetBooks extends StatefulWidget {
  final String? selectedValue;
  final String? name;
  final List<String>? metawords;
  final String imageUrl;
  final String endColor;
  final String startColor;
  const JeeNeetBooks(this.selectedValue, this.name, this.metawords,
      this.imageUrl, this.endColor, this.startColor,
      {super.key});

  @override
  State<JeeNeetBooks> createState() => _JeeNeetBooksState();
}

class _JeeNeetBooksState extends State<JeeNeetBooks>
    with SingleTickerProviderStateMixin {
  int count = 0;
  Future<List<StudyMaterialsNeetJee>>? booksList;
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
    final selectedCategory = widget.selectedValue;
    final appDB = appDBFunctions();
    setState(() {
      booksList = appDB.getStudyMaterialsNEETJEE(selectedCategory);
    });
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
                    widget.name!,
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
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 130.h),
                          Text(
                            widget.name!,
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
                            widget.metawords!.join('\n'),
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
                      Padding(
                        padding: EdgeInsets.only(bottom: 60.h),
                        child: SizedBox(
                          height: 250,
                          width: 300,
                          child: SvgPicture.asset(
                            widget.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70.h + 30.0),
              child: Container(
                height: 80.h,
                color: const Color(0xffFBE9E7),
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Colors.black,
                  labelColor: Color(
                    int.parse(
                      widget.endColor.replaceFirst('#', '0xFF'),
                    ),
                  ),
                  indicatorColor: Color(
                    int.parse(
                      widget.endColor.replaceFirst('#', '0xFF'),
                    ),
                  ),
                  tabs: [
                    Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Text(
                        'Physics',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 24.sp
                                : 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      'Chemistry',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < 600
                              ? 24.sp
                              : 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      widget.selectedValue == "JEE" ? 'Mathematics' : 'Biology',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < 600
                              ? 24.sp
                              : 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: SizedBox(
        height: scrollHeight,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: TabBarView(
              controller: _tabController,
              children: [
                BooksUnitList(
                  'Physics',
                  booksList,
                  widget.metawords,
                  widget.name,
                  widget.selectedValue,
                  widget.endColor,
                ),
                BooksUnitList(
                  'Chemistry',
                  booksList,
                  widget.metawords,
                  widget.name,
                  widget.selectedValue,
                  widget.endColor,
                ),
                BooksUnitList(
                  widget.selectedValue == "JEE" ? 'Mathematics' : 'Biology',
                  booksList,
                  widget.metawords,
                  widget.name,
                  widget.selectedValue,
                  widget.endColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
