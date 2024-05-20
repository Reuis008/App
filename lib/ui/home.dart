import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/ui/landingHomePage/landingHomePage.dart';
import 'package:lms_v_2_0_0/ui/search/search.dart';
import 'package:lms_v_2_0_0/ui/sidebar/sidebar.dart';
import 'package:lms_v_2_0_0/ui/tabbar/tabbar.dart';
import 'package:lms_v_2_0_0/ui/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  AppHomeScreenState createState() => AppHomeScreenState();
}

class AppHomeScreenState extends State<AppHomeScreen> {
  String? selectedClassId;
  @override
  void initState() {
    super.initState();
    loadSelectedClassId();
  }

  // Method to load the selected class ID from shared preferences
  Future<void> loadSelectedClassId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedClassId = prefs.getString('selectedClassId') ?? '';
      print('prer $selectedClassId');
    });
  }

  // Method to save the selected class ID to shared preferences
  Future<void> saveSelectedClassId(String classId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedClassId', classId);
    setState(() {
      selectedClassId = classId;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size designSize = MediaQuery.of(context).orientation == Orientation.portrait
        ? const Size(720, 1280)
        : const Size(1280, 720);

    return ScreenUtilInit(
      designSize: designSize,
      builder: (BuildContext context, Widget? child) {
        return selectedClassId != null && selectedClassId!.isNotEmpty
            ? Scaffold(
                backgroundColor: const Color(0xff3F51B5),
                drawer: SideBar(
                  onSelectClass: (classId) {
                    setState(() {
                      selectedClassId = classId;
                    });
                    saveSelectedClassId(classId);
                  },
                ),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60.sp),
                  child: AppBar(
                    shadowColor: Colors.grey,
                    elevation: 2,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.outline,
                          size: 35.sp,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            ScaleInRoute(
                              page: SearchBarInput(selectedClassId),
                            ),
                          );
                        },
                      ),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) {
                          return IconButton(
                            icon: AnimatedCrossFade(
                              duration: const Duration(milliseconds: 300),
                              firstChild: Icon(Icons.wb_sunny,
                                  color: Colors.black, size: 35.sp),
                              secondChild: Icon(Icons.nights_stay,
                                  color: Colors.white, size: 35.sp),
                              crossFadeState:
                                  themeProvider.themeData.brightness ==
                                          Brightness.dark
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                            ),
                            onPressed: () {
                              themeProvider.toggleTheme();
                            },
                          );
                        },
                      ),
                    ],
                    leading: Builder(
                      builder: (context) {
                        return IconButton(
                          padding: EdgeInsets.all(10.sp),
                          iconSize: 35.sp,
                          icon: Icon(
                            CupertinoIcons.text_aligncenter,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        );
                      },
                    ),
                  ),
                ),
                body: HorizontalCategoriesView(
                  selectedClassID: selectedClassId!,
                ),
              )
            : LandingHomePage(
                onSelectClassID: (classId) {
                  setState(() {
                    selectedClassId = classId;
                  });
                  saveSelectedClassId(classId);
                },
              );
      },
    );
  }
}
