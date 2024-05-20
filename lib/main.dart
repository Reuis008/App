import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:lms_v_2_0_0/ui/theme/theme_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'splashVideo.dart';
import 'splashScreen.dart';
import 'invalid_device.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const SystemUiOverlayStyle(
      statusBarColor: Colors.black, statusBarIconBrightness: Brightness.light);
  SystemChrome.setPreferredOrientations([]).then((_) {
    runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const Myapp(),
    ));
  });
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckImportedDBState createState() => _CheckImportedDBState();
}

class _CheckImportedDBState extends State<Myapp> {
  // late Future<List<Directory>> _externalStorageDirectories;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  int timeElapsed = 0;
  bool configReady = false;
  late BuildContext _context; // Declare a variable to capture the context

  @override
  void initState() {
    super.initState();
    initDevicePlatform();
    Timer(const Duration(seconds: 5), () {
      // Navigate to the splash video after 5 seconds
      Navigator.of(_context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SplashVideo()));
    });
    // _requestExternalStorageDirectories();
  }

  // void _requestExternalStorageDirectories() {
  //   setState(() {
  //   _externalStorageDirectories = getExternalStorageDirectories();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Dynamically adjust the orientation based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    return FutureBuilder(
        future: initPlatformState(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null && _deviceData.isEmpty && !configReady ||
              snapshot.connectionState != ConnectionState.done &&
                  _deviceData.isEmpty &&
                  !configReady) {
            return SplashScreen();
          } else {
            // if ((_deviceData['brand'] == 'Acer' &&
            //         _deviceData['device'] == 'Acer_One_10_T9-1212L' &&
            //         _deviceData['manufacturer'] == 'Acer' &&
            //         _deviceData['model'] == 'Acer_One_10_T9-1212L') ||
            //     (_deviceData['brand'] == 'google' &&
            //         _deviceData['device'] == 'generic_x86' &&
            //         _deviceData['manufacturer'] == 'Google' &&
            //         _deviceData['model'] == 'Android SDK built for x86') ||
            //     (_deviceData['hardware'] == 'mt6739' &&
            //         _deviceData['brand'] == 'LAVA' &&
            //         _deviceData['device'] == 'T71N_M' &&
            //         _deviceData['manufacturer'] == 'LAVA' &&
            //         _deviceData['model'] == 'T71N_M') ||
            //     (_deviceData['brand'] == 'Redmi' &&
            //         _deviceData['device'] == 'xagain' &&
            //         _deviceData['manufacturer'] == 'Xiaomi' &&
            //         _deviceData['model'] == '22041216I')) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'NICE e-Scholar',
              initialRoute: 'splashVideo',
              onGenerateRoute: (settings) {
                return MaterialPageRoute(builder: (_) => const SplashVideo());
              },
              theme: Provider.of<ThemeProvider>(context).themeData,

              // ThemeData(
              //   fontFamily: 'Raleway',
              //   primaryColor: HexColor('#4E73DF'), // Example usage of HexColor
              //   highlightColor:
              //       HexColor('#DFBA4E'), // Example usage of HexColor
              //   scaffoldBackgroundColor: HexColor('#F3F5F7'),
              // ),
            );
            // } else {
            //   return const InvalidDeviceScreen();
            // }

            //Routes.router.navigateTo(context, "/home");
          }
        });
  }

  Future<void> initPlatformState() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "lms_mobile.db");
    if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load("assets/db/lms_mobile.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
    } // this is the location of your large-file now. Use it for anything in your Flutter app.
    setState(() {
      configReady = true;
    });
  }

  Future<void> initDevicePlatform() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.id,
      'systemFeatures': build.systemFeatures,
    };
  }
}

/*class BuiltByHimanshu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NICE e-Scholar',
      initialRoute: 'initCheck',
      onGenerateRoute: Routes.router.generator,
      theme: ThemeData(
        primaryColor: Color(0xFF4E73DF),
        accentColor: Color(0xFFDFBA4E),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
    );
  }
}*/

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
