// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/periodicTable/Components/Data.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/periodicTable/Components/elementno.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/periodicTable/pages/Element.dart';

import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

bool show = false;
bool showbutton = false;
bool found = false;
String noDataText = 'Search an element from the periodic table';

class _SearchPageState extends State<SearchPage> {
  TextEditingController _filter = TextEditingController();
  List names = [];
  late List filteredNames;
  List res = [];
  bool _showClearButton = false;

  @override
  void initState() {
    setState(() {
      _filter.addListener(_onTextChanged);
      show = false;
      found = false;
    });
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = _filter.text.isNotEmpty;
    });
  }

  void _clearText() {
    _filter.clear();
    setState(() {
      noDataText = 'Search an element from the periodic table';
      _showClearButton = false;
    });
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: size.width > 800
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    SizedBox(
                      width: 600.w,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 80.h, left: 20.w, right: 30.w),
                              child: TextField(
                                autocorrect: true,
                                enableSuggestions: true,
                                controller: _filter,
                                onChanged: (_filter) {
                                  if (_filter.isEmpty) {
                                    setState(() {
                                      showbutton = false;
                                      _filter = '';
                                    });
                                  } else {
                                    setState(() {
                                      showbutton = true;
                                      _getNames(_filter.toLowerCase());
                                    });
                                  }
                                },
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
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20.0),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black45),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 500.h,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 80),
                              child: showscreen(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 600.w,
                          height: 600.w,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 275.w,
                                          height: 600.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 300.w.w,
                                                height: 60.h,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.brown,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.sp),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'Alkali Metals',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40.w,
                                                          height: 40.h,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26.sp),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '6',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300.w,
                                                height: 60.h,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'Alkaline Earth Metals',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40.w,
                                                          height: 40.h,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26.sp),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '6',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300.w,
                                                height: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.pink,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Transition Metal',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                '31',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300.w,
                                                height: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Post-transition Metal',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                '12',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300.w,
                                                height: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.teal,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Metalloid',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                '6',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 275.w,
                                          height: 600,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 300.w,
                                                height: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green[900],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Reactive Non-Metal',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                '10',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300.w,
                                                height: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Noble Gas',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                '6',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300.w,
                                                height: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.purple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Lanthanide',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                '15',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300.w,
                                                height: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red[900],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Actinide',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                '15',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 300.w,
                                                height: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[700],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Unknown',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          height: 40,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                '10',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 80, left: 20, right: 30),
                          child: TextField(
                            autocorrect: true,
                            enableSuggestions: true,
                            controller: _filter,
                            onChanged: (_filter) {
                              if (_filter.isEmpty) {
                                setState(() {
                                  showbutton = false;
                                  _filter = '';
                                });
                              } else {
                                setState(() {
                                  showbutton = true;
                                  _getNames(_filter.toLowerCase());
                                });
                              }
                            },
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: showscreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  void _getNames(String name) async {
    int check = 0;
    if (name.isEmpty) {
      setState(() {
        show = false;
      });
    } else {
      Period period = Period();
      var data = period.period;
      setState(() {
        res = [];
        for (int i = 0; i < 118; i++) {
          var temp = data[i]['name'].toString();
          names.add(temp);
        }
      });
      for (int i = 0; i < 118; i++) {
        String ele = '';
        ele = names[i];
        ele = ele.toLowerCase();

        if (ele.contains(name)) {
          setState(() {
            res.add(ele);
            check = 1;
          });
        }
      }
      if (check == 1) {
        setState(() {
          show = true;
          found = true;
        });
      } else {
        setState(() {
          found = false;
          noDataText = "Element not found";
        });
      }
    }
  }

  Widget showscreen() {
    Widget out;
    if (show == true && found == true) {
      out = _buildlist();
    } else if (show == false && found == false) {
      out = const Search_something();
    } else {
      out = Notfound();
    }
    return out;
  }

  Widget _buildlist() {
    int atnum;
    elementno elno = elementno();
    var n = elno.element;
    return ListView.builder(
      key: UniqueKey(),
      itemCount: res.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                atnum = int.parse(n[res[index].substring(0, 1).toUpperCase() +
                    res[index].substring(1)]);
                atnum -= 1;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ElementPage(
                      atomicnum: atnum,
                    ),
                  ),
                );
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                res[index].substring(0, 1).toUpperCase() +
                                    res[index].substring(1),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                'Tap to know more',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(
                                child: Lottie.asset('assets/json/atom.json')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Search_something extends StatelessWidget {
  const Search_something({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300.w,
          height: 300.w,
          child: Lottie.asset('assets/json/search.json'),
        ),
        Text(
          noDataText,
          style: TextStyle(fontSize: 18.sp, color: Colors.deepOrangeAccent),
        ),
      ],
    );
  }
}

class Notfound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 300.w,
            height: 300.w,
            child: Lottie.asset('assets/json/search.json'),
          ),
          Text(
            noDataText,
            style: TextStyle(fontSize: 18.sp, color: Colors.deepOrangeAccent),
          ),
        ],
      ),
    );
  }
}
