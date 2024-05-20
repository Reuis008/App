import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/question_bank.dart';
import 'package:lms_v_2_0_0/ui/exampreparatory/questionbankmbosencert/questionbankMboseNcertTopic.dart';

class QuestionBankMboseNcert extends StatefulWidget {
  final String selectedBoardType;
  final String title;
  final List<String> metawords;
  final String imageUrl;
  const QuestionBankMboseNcert(
      this.selectedBoardType, this.title, this.metawords, this.imageUrl,
      {super.key});

  @override
  State<QuestionBankMboseNcert> createState() => _QuestionBankMboseNcertState();
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

class _QuestionBankMboseNcertState extends State<QuestionBankMboseNcert> {
  Future<List<QuestionBank>>? questionBankList;

  @override
  void initState() {
    super.initState();
    _initializeDBAndData();
  }

  void _initializeDBAndData() async {
    final appDB = appDBFunctions();
    setState(() {
      questionBankList = appDB.getQuestionBank(widget.selectedBoardType);
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
                    widget.title,
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
                Navigator.pop(context);
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
                          SizedBox(height: 130.h),
                          Text(
                            widget.title,
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
                            widget.metawords.join('\n'),
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
                          widget.imageUrl,
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
          body: FutureBuilder<List<QuestionBank>>(
            future: questionBankList,
            builder: (BuildContext context,
                AsyncSnapshot<List<QuestionBank>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final uniqueYears =
                    snapshot.data!.map((year) => year.year).toSet().toList();
                return ListView.builder(
                  itemCount: uniqueYears.length,
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
                                      uniqueYears[index]!,
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
                                    .where((year) =>
                                        year.year == uniqueYears[index])
                                    .toList();
                                Navigator.push(
                                  context,
                                  ScaleInRoute(
                                    page: QuestionBankMboseNcertTopic(
                                        filteredData,
                                        widget.title,
                                        uniqueYears[index]),
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
