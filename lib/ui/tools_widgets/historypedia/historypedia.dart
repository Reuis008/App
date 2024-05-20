import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/models/historypedia.dart';
import 'package:lms_v_2_0_0/appDBFunctions.dart';
import 'package:lottie/lottie.dart';

class HistoryPedia extends StatefulWidget {
  const HistoryPedia({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryPedia> createState() => _HistoryPediaState();
}

class _HistoryPediaState extends State<HistoryPedia> {
  final searchFieldController = TextEditingController();
  String noDataText = 'Tap on search button to get started';
  String searchedText = '';
  bool _showClearButton = false;
  var appDB;

  List<SearchHistorypedia> eventsList = []; // Changed to a list
  final int _limit = 20;
  int _offset = 0;

  @override
  void initState() {
    searchFieldController.addListener(_onTextChanged);
    super.initState();
    appDB = appDBFunctions();
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = searchFieldController.text.isNotEmpty;
    });
  }

  void _clearText() {
    searchFieldController.clear();
    setState(() {
      _showClearButton = false;
      noDataText = 'Tap on search button to get started';
    });
  }

  bool hasMoreItems = true;

  Future<void> getEvents(event, int offset) async {
    List<SearchHistorypedia> newEvents = await appDB
        .getSearchedHistorypedia(searchedText, limit: _limit, offset: offset);

    hasMoreItems = newEvents.isNotEmpty;
    setState(() {
      searchedText = event;
      _offset = offset;
      eventsList.addAll(newEvents); // Append new events to the existing list
      eventsList.isEmpty ? noDataText = 'No data found' : noDataText = '';
    });
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              autocorrect: true,
              enableSuggestions: true,
              controller: searchFieldController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {
                    if (searchFieldController.text.isNotEmpty) {
                      setState(() {
                        searchedText = searchFieldController.text;
                        _offset =
                            0; // Reset the offset before starting a new search
                        eventsList.clear(); // Clear the existing list
                      });
                      getEvents(searchedText, _offset);
                    }
                  },
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
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Flexible(
            child: eventsList.isEmpty
                ? SizedBox(
                    height: 700,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Spacer(),
                          SizedBox(
                            width: 300.w,
                            height: 300.h,
                            child: Lottie.asset('assets/json/search.json'),
                          ),
                          Text(
                            noDataText,
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.deepOrangeAccent),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemCount:
                        eventsList.length + 1, // Add 1 for the Load More button
                    itemBuilder: (BuildContext context, int index) {
                      if (index < eventsList.length) {
                        // Existing item builder
                        return Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(40.sp),
                              child: Row(
                                children: [
                                  SizedBox(width: size.width * 0.1),
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: Text(
                                      eventsList[index].date!,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 480.w,
                                      child: Text(
                                        eventsList[index].description!,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 24.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 50.w,
                              child: Container(
                                height: size.height * 0.7,
                                width: 1.0.w,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            Positioned(
                              bottom: 5.h,
                              child: Padding(
                                padding: EdgeInsets.all(40.sp),
                                child: Container(
                                  height: 20.0.h,
                                  width: 20.0.w,
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        if (hasMoreItems) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _offset +=
                                        _limit; // Increase the offset by the limit
                                  });
                                  getEvents(searchedText,
                                      _offset); // Fetch the next set of results
                                },
                                child: const Text('Load More'),
                              ),
                            ),
                          );
                        } else {
                          // If there are no more items to load, show a message instead of the button
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h, top: 20.h),
                            child: const Center(
                              child: Text('No more items to load.',
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent)),
                            ),
                          );
                        }
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
