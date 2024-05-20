import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lms_v_2_0_0/ui/exampreparatory/examPreparatoryList.dart';
import 'package:lms_v_2_0_0/ui/quiz/quiz_list.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/home_widget.dart';
import 'package:lms_v_2_0_0/ui/studyMaterial/studyMaterialsList.dart';
import 'package:lms_v_2_0_0/ui/subject/subjectList.dart';

// ignore: must_be_immutable
class HorizontalCategoriesView extends StatefulWidget {
  String selectedClassID;

  HorizontalCategoriesView({
    Key? key,
    required this.selectedClassID,
  }) : super(key: key);

  @override
  State<HorizontalCategoriesView> createState() =>
      _HorizontalCategoriesViewState();
}

class _HorizontalCategoriesViewState extends State<HorizontalCategoriesView> {
  int _selectedIndex = 0;

  List<Widget> _pages = []; // Initialize _pages as an empty list

  @override
  void initState() {
    super.initState();
    _rebuildPages(); // Call a method to rebuild _pages with the current values
  }

  @override
  void didUpdateWidget(HorizontalCategoriesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedClassID != widget.selectedClassID) {
      _rebuildPages(); // Rebuild _pages if selectedClassID or selectedClassName changes
    }
  }

  void _rebuildPages() {
    setState(() {
      _pages = <Widget>[
        SingleChildScrollView(
          child: Column(
            children: [
              const StudyMaterialsList(),
              SubjectList(
                widget.selectedClassID,
              ),
            ],
          ),
        ),
        ExamPreparatorylist(
          widget.selectedClassID,
        ),
        const QuizList(),
        const HomeWidget(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    double navGap = MediaQuery.of(context).size.width < 900 ? 160 : 330;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: navGap, vertical: 20),
            child: GNav(
              rippleColor: Colors.grey.shade300,
              hoverColor: Colors.grey.shade100,
              gap: 8,
              activeColor: Theme.of(context).colorScheme.outline,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Theme.of(context).colorScheme.onPrimary,
              color: Theme.of(context).colorScheme.outline,
              tabs: const [
                GButton(
                  iconActiveColor: Colors.deepOrangeAccent,
                  iconSize: 34,
                  icon: Icons.home_rounded,
                  text: 'Home',
                ),
                GButton(
                  iconActiveColor: Colors.deepOrangeAccent,
                  iconSize: 34,
                  icon: Icons.border_color_rounded,
                  text: 'Examify',
                ),
                GButton(
                  iconActiveColor: Colors.deepOrangeAccent,
                  iconSize: 34,
                  icon: Icons.quiz_rounded,
                  text: 'Quiz',
                ),
                GButton(
                  iconActiveColor: Colors.deepOrangeAccent,
                  iconSize: 34,
                  icon: Icons.plumbing_rounded,
                  text: 'Tools',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
