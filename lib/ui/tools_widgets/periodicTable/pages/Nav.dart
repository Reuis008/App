// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/periodicTable/pages/Search.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/periodicTable/pages/Table.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const TablePage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double navGap = MediaQuery.of(context).size.width < 900 ? 250 : 400;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: navGap, vertical: 20),
            child: GNav(
                rippleColor: Colors.grey.shade300,
                hoverColor: Colors.grey.shade100,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey.shade800,
                color: Theme.of(context).colorScheme.outline,
                tabs: const [
                  GButton(
                    iconActiveColor: Colors.white,
                    iconSize: 34,
                    icon: Icons.home,
                    text: 'Elements',
                  ),
                  GButton(
                    iconActiveColor: Colors.white,
                    iconSize: 34,
                    icon: Icons.search,
                    text: 'Search',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
