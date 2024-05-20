import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/calculator/scientificCalculator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/dictionary/dictionary.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/historypedia/historypedia.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/periodicTable/pages/Nav.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/providers/asteroid_data.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/providers/comet_data.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/providers/moons.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/providers/planets.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/providers/sundata.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/providers/topics.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/screens/asteroids_overview_screen.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/screens/comets_overview_screen.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/screens/home_page.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/screens/moons_overview_screen.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/screens/planet_detail_screen.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/screens/planets_overview_screen.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/solar_system/screens/sun_detail_screen.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/unit_converter/unit_converterList.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
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

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width < 900 ? 0.h : 60.h,
            ),
            GridView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600
                    ? 1
                    : (MediaQuery.of(context).size.width < 900 ? 2 : 3),
                crossAxisSpacing: 10,
                mainAxisSpacing:
                    MediaQuery.of(context).size.width < 600 ? 10 : 20,
                childAspectRatio:
                    MediaQuery.of(context).size.width < 600 ? 1.80 : 1.29,
              ),
              children: [
                _buildImageCard(context, () {
                  Navigator.of(context).push(
                    ScaleInRoute(
                      page: const Dictionary(),
                    ),
                  );
                },
                    "Dictionary",
                    ['1,77,000 words', 'Synonyms, Source: Wordset'],
                    'assets/img/tools_widget/dictionary.svg'),
                _buildImageCard(context, () {
                  Navigator.of(context).push(
                    ScaleInRoute(
                      page: const ScientificCalculator(),
                    ),
                  );
                }, "Calculator", ['Scientific calculator', 'Normal Calculator'],
                    'assets/img/tools_widget/calculator.svg'),
                _buildImageCard(context, () {
                  Navigator.of(context).push(
                    ScaleInRoute(
                      page: NavPage(),
                    ),
                  );
                },
                    "Periodic Table",
                    ['Element details', 'Interactive, Periodicity Explained'],
                    'assets/img/tools_widget/periodic_table.svg'),
                _buildImageCard(context, () {
                  Navigator.of(context).push(
                    ScaleInRoute(
                      page: MultiProvider(
                        providers: [
                          ChangeNotifierProvider(create: (ctx) => Topics()),
                          ChangeNotifierProvider(create: (ctx) => Planets()),
                          ChangeNotifierProvider(create: (ctx) => Sundata()),
                          ChangeNotifierProvider(
                              create: (ctx) => AsteroidData()),
                          ChangeNotifierProvider(create: (ctx) => CometsData()),
                          ChangeNotifierProvider(create: (ctx) => Moons()),
                        ],
                        child: MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: HomePage(),
                          routes: {
                            SunDetailScreen.routeName: (ctx) =>
                                SunDetailScreen(),
                            PlanetsOverviewScreen.routeName: (ctx) =>
                                PlanetsOverviewScreen(),
                            PlanetDetailScreen.routeName: (ctx) =>
                                PlanetDetailScreen(),
                            MoonsOverviewScreen.routeName: (ctx) =>
                                MoonsOverviewScreen(),
                            CometsOverviewScreen.routeName: (ctx) =>
                                CometsOverviewScreen(),
                            AsteroidsOverviewScreen.routeName: (ctx) =>
                                AsteroidsOverviewScreen(),
                          },
                        ),
                      ),
                    ),
                  );
                }, "Solar System", ['Planetary Bodies', 'Asteroids, Comets'],
                    'assets/img/tools_widget/solar_system.svg'),
                _buildImageCard(context, () {
                  Navigator.of(context).push(
                    ScaleInRoute(
                      page: const HistoryPedia(),
                    ),
                  );
                }, "Historypedia", ['37,000+Events', 'From 300 BC to 2012 AD'],
                    'assets/img/tools_widget/history_pedia.svg'),
                _buildImageCard(context, () {
                  Navigator.of(context).push(
                    ScaleInRoute(
                      page: const UnitConverterList(),
                    ),
                  );
                }, "Unit Converter", ['20 unit converter', 'Scientific Units'],
                    'assets/img/tools_widget/converter.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(
    BuildContext context,
    VoidCallback onTap,
    String title,
    List<String> metaData,
    String svgFile,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 3.0,
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5.h),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 100,
                        child: SvgPicture.asset(
                          svgFile,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width < 600
                                  ? 20.w
                                  : 18.w,
                              top: 10.h),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? 48.sp
                                  : 24.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width < 600
                                  ? 20.w
                                  : 18.w,
                              top: 10.h),
                          child: Text(
                            metaData.join('\n'),
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade500,
                              fontSize: MediaQuery.of(context).size.width < 600
                                  ? 34.sp
                                  : 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width < 600
                                ? 20.w
                                : 18.w,
                            top: 10.h),
                        child: Text(
                          'Learn more',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrangeAccent,
                            //  const Color(0xff98989f),
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? 34.sp
                                : 16.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width < 600
                                ? 20.w
                                : 10.w,
                            top: 10.h),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.deepOrangeAccent,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
