import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/ui/tools_widgets/unit_converter/unit_converter.dart';

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

class UnitConverterList extends StatelessWidget {
  const UnitConverterList({super.key});
  Widget icon(BuildContext context, int index) {
    // Initialize iconData with a default value
    IconData iconData = Icons.error;
    String labelText = "Error";
    // Replace this logic with your own to determine which icon to show for each index
    switch (index % 20) {
      case 0:
        iconData = CupertinoIcons.speedometer;
        labelText = "Acceleration";
        break;
      case 1:
        iconData = CupertinoIcons.layers;
        labelText = "Area";
        break;
      case 2:
        iconData = CupertinoIcons.gear;
        labelText = "Torque";
        break;
      case 3:
        iconData = CupertinoIcons.battery_charging;
        labelText = "Electricity";
        break;
      case 4:
        iconData = CupertinoIcons.bolt;
        labelText = "Energy";
        break;
      case 5:
        iconData = CupertinoIcons.arrow_right;
        labelText = "Force";
        break;
      case 6:
        iconData = CupertinoIcons.wrench;
        labelText = "Force/Length";
        break;
      case 7:
        iconData = CupertinoIcons.pencil_ellipsis_rectangle;
        labelText = "Length";
        break;
      case 8:
        iconData = CupertinoIcons.lightbulb;
        labelText = "Light";
        break;
      case 9:
        iconData = CupertinoIcons.tray_full;
        labelText = "Mass";
        break;
      case 10:
        iconData = CupertinoIcons.hourglass;
        labelText = "Density & Mass Capacity";
        break;
      case 11:
        iconData = CupertinoIcons.waveform;
        labelText = "Mass Flow";
        break;
      case 12:
        iconData = CupertinoIcons.power;
        labelText = "Power";
        break;
      case 13:
        iconData = CupertinoIcons.rectangle_compress_vertical;
        labelText = "Pressure & Stress";
        break;
      case 14:
        iconData = CupertinoIcons.thermometer;
        labelText = "Temperature";
        break;
      case 15:
        iconData = CupertinoIcons.clock;
        labelText = "Time";
        break;
      case 16:
        iconData = CupertinoIcons.gauge;
        labelText = "Velocity & Speed";
        break;
      case 17:
        iconData = CupertinoIcons.drop;
        labelText = "Viscosity";
        break;
      case 18:
        iconData = CupertinoIcons.cube;
        labelText = "Volumn & Capacity";
        break;
      case 19:
        iconData = CupertinoIcons.drop_triangle;
        labelText = "Volumn Flow";
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 50.sp, color: Colors.deepOrangeAccent),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(labelText,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.outline,
                )),
          ],
        ),
      ],
    );
  }

  String getLabelText(int index) {
    String labelText = "Error";
    switch (index % 20) {
      case 0:
        labelText = "Acceleration";
        break;
      case 1:
        labelText = "Area";
        break;
      case 2:
        labelText = "Torque";
        break;
      case 3:
        labelText = "Electricity";
        break;
      case 4:
        labelText = "Energy";
        break;
      case 5:
        labelText = "Force";
        break;
      case 6:
        labelText = "Force / Length";
        break;
      case 7:
        labelText = "Length";
        break;
      case 8:
        labelText = "Light";
        break;
      case 9:
        labelText = "Mass";
        break;
      case 10:
        labelText = "Density & Mass capacity";
        break;
      case 11:
        labelText = "Mass Flow";
        break;
      case 12:
        labelText = "Power";
        break;
      case 13:
        labelText = "Pressure & Stress";
        break;
      case 14:
        labelText = "Temperature";
        break;
      case 15:
        labelText = "Time";
        break;
      case 16:
        labelText = "Velocity & Speed";
        break;
      case 17:
        labelText = "Viscosity";
        break;
      case 18:
        labelText = "Volume & Capacity";
        break;
      case 19:
        labelText = "Volume Flow";
        break;

      // Add all other cases as in your original switch statement
    }
    return labelText;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    var responsive = MediaQuery.of(context).size;
    return Scaffold(
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
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: responsive.width > 800
                        ? SingleChildScrollView(
                            child: Center(
                              child: GridView.count(
                                controller: _scrollController,
                                crossAxisCount: 6,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                                shrinkWrap: true,
                                key: UniqueKey(),
                                children: List.generate(
                                  20,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: InkWell(
                                        onTap: () {
                                          // Use getLabelText to get the label text based on the index
                                          String labelText =
                                              getLabelText(index);
                                          // Navigate to UnitConverterPage and pass the labelText
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UnitConverter(
                                                containerName: labelText,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors
                                                .transparent, // Change here
                                          ),
                                          child: icon(context, index),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : responsive.width < 600
                            ? Center(
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  shrinkWrap: true,
                                  key: UniqueKey(),
                                  children: List.generate(
                                    20,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () {
                                            // Use getLabelText to get the label text based on the index
                                            String labelText =
                                                getLabelText(index);
                                            // Navigate to UnitConverterPage and pass the labelText
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UnitConverter(
                                                  containerName: labelText,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .transparent, // Change here
                                            ),
                                            child: icon(context, index),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Center(
                                child: GridView.count(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  shrinkWrap: true,
                                  key: UniqueKey(),
                                  children: List.generate(
                                    20,
                                    (index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: InkWell(
                                          onTap: () {
                                            // Use getLabelText to get the label text based on the index
                                            String labelText =
                                                getLabelText(index);
                                            // Navigate to UnitConverterPage and pass the labelText
                                            Navigator.of(context).push(
                                              ScaleInRoute(
                                                page: UnitConverter(
                                                  containerName: labelText,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .transparent, // Change here
                                            ),
                                            child: icon(context, index),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
