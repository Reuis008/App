import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lms_v_2_0_0/models/study_materials_neet_jee.dart';
import 'package:lms_v_2_0_0/models/topics.dart';
import 'package:lms_v_2_0_0/ui/renderPDF/renderPDF.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SearchBarInput extends StatefulWidget {
  final String? selectedClassId;
  const SearchBarInput(this.selectedClassId, {Key? key}) : super(key: key);

  @override
  State<SearchBarInput> createState() => _SearchBarInputState();
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

class _SearchBarInputState extends State<SearchBarInput> {
  TextEditingController _textController = TextEditingController();
  bool _showClearButton = false;
  var appDB;
  Future<List<Topic>>? videolist;
  Future<List<StudyMaterialsNeetJee>>? booklist;
  String? encryptedVideoPath;
  Future<List<Directory>?>? _externalStorageDirectories;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
    _requestExternalStorageDirectories();
    appDB = appDBFunctions();
  }

  void _requestExternalStorageDirectories() {
    setState(() {
      _externalStorageDirectories = getExternalStorageDirectories();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = _textController.text.isNotEmpty;
    });
  }

  void _clearText() {
    _textController.clear();
    setState(() {
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.outline,
            size: MediaQuery.of(context).size.width < 600 ? 40.sp : 32.sp,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Search',
          style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: MediaQuery.of(context).size.width < 600
                  ? 32.sp
                  : MediaQuery.of(context).size.width < 900
                      ? 24.sp
                      : 28.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                autocorrect: true,
                enableSuggestions: true,
                controller: _textController,
                onChanged: _searchOnChanged,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 30.sp,
                    ),
                  ),
                  suffixIcon: _showClearButton
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onPressed: _clearText,
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            !_showClearButton
                ? SizedBox(
                    height: 700,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 300.h,
                            width: 300.w,
                            child: Lottie.asset('assets/json/search.json'),
                          ),
                          Text(
                            'Search for books and videos from your course library',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.deepOrangeAccent),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: _externalStorageDirectories,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Directory>?>
                            externalStoragesnapshot) {
                      if (externalStoragesnapshot.hasError) {
                        return Center(
                          child: Text(
                            'No SD card found',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.deepOrangeAccent),
                          ),
                        );
                      } else if (externalStoragesnapshot.data == null &&
                          externalStoragesnapshot.connectionState ==
                              ConnectionState.waiting) {
                        return Center(
                          child: Text(
                            'Please wait ...',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.deepOrangeAccent),
                          ),
                        );
                      } else if (externalStoragesnapshot.data != null &&
                          externalStoragesnapshot.data!.length < 2 &&
                          externalStoragesnapshot.connectionState ==
                              ConnectionState.done) {
                        return Center(
                          child: Text(
                            'SD Card not found',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.deepOrangeAccent),
                          ),
                        );
                      } else {
                        encryptedVideoPath =
                            p.join(externalStoragesnapshot.data![1].path);
                        return FutureBuilder(
                          future: videolist,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Topic>> videosSnapshot) {
                            if (videosSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (videosSnapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Error: Something is wrong',
                                  // ${videosSnapshot.error},
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      fontSize: 18.sp),
                                ),
                              );
                            } else {
                              return FutureBuilder(
                                future: booklist,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<StudyMaterialsNeetJee>>
                                        booksSnapshot) {
                                  if (booksSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (booksSnapshot.hasError) {
                                    return Center(
                                        child: Text(
                                            'Error: ${booksSnapshot.error}'));
                                  } else {
                                    return searchList(
                                      videosSnapshot.data ?? [],
                                      booksSnapshot.data ?? [],
                                      encryptedVideoPath,
                                    );
                                  }
                                },
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void _searchOnChanged(String value) {
    videolist = appDB.getSearchedVideoTopics(value, widget.selectedClassId);
    booklist = appDB.getSearchedBookTopics(value);
  }
}

class searchList extends StatefulWidget {
  final List<Topic> videolistData;
  final List<StudyMaterialsNeetJee> booklistData;
  final String? encryptedVideoPath;
  searchList(this.videolistData, this.booklistData, this.encryptedVideoPath,
      {Key? key})
      : super(key: key);

  @override
  State<searchList> createState() => _searchListState();
}

class _searchListState extends State<searchList> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final uniquechapterName = widget.videolistData
        .map((videolsit) => videolsit.chapterName)
        .toSet()
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Videos',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          widget.videolistData.isEmpty
              ? Center(
                  child: Text(
                    'No videos found',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: uniquechapterName.length,
                  itemBuilder: (context, index) {
                    final filteredTopics = widget.videolistData
                        .where((videolist) =>
                            videolist.chapterName == uniquechapterName[index])
                        .toList();
                    return Column(
                      children: [
                        SizedBox(
                          height: 150.h,
                          child: Card.outlined(
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
                                    SizedBox(width: 30.w),
                                    Text(
                                      widget.videolistData[index].subjectName!,
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
                                subtitle: Row(
                                  children: [
                                    SizedBox(width: 30.w),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          uniquechapterName[index]!,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w300,
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    600
                                                ? 24.sp
                                                : MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        900
                                                    ? 16.sp
                                                    : 24.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  selectedIndex == index
                                      ? CupertinoIcons.chevron_up
                                      : CupertinoIcons.chevron_down,
                                  color: Colors.grey,
                                  size: MediaQuery.of(context).size.width < 600
                                      ? 40.sp
                                      : 28.sp,
                                ),
                                onTap: () {
                                  setState(() {
                                    if (selectedIndex == index) {
                                      selectedIndex =
                                          null; // Hide nested list if tapped again
                                    } else {
                                      selectedIndex =
                                          index; // Show nested list for the tapped item
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        if (selectedIndex == index)
                          Column(
                            children: filteredTopics.map((topic) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 8.h, right: 16.w, left: 40.w),
                                child: SizedBox(
                                  height: 80.h,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            const Icon(
                                              Icons.play_circle_fill_rounded,
                                              color: Color(0xff5c6bc0),
                                            ),
                                            SizedBox(width: 20.w),
                                            Flexible(
                                              child: Text(
                                                topic.topicName!,
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          // Handle tap
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    );
                  },
                ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Books',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          widget.booklistData.isEmpty
              ? Center(
                  child: Text(
                    'No books found',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.booklistData.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 150.h,
                      child: Card.outlined(
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
                                Text(
                                  widget.booklistData[index].subjectName!,
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.width < 600
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
                            subtitle: Row(
                              children: [
                                SizedBox(
                                  width: 30.w,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      widget.booklistData[index].documentName!,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w300,
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    600
                                                ? 24.sp
                                                : MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        900
                                                    ? 16.sp
                                                    : 24.sp,
                                      ),
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
                                  size: MediaQuery.of(context).size.width < 600
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
                                      pdfName: widget
                                          .booklistData[index].documentName!,
                                      pdfPath: p.join(
                                          widget.encryptedVideoPath!,
                                          widget.booklistData[index]
                                              .documentPath!),
                                      pdfType: "data"),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
