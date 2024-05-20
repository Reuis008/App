import 'package:flutter/material.dart';

class InvalidDeviceScreen extends StatefulWidget {
  const InvalidDeviceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InvalidDeviceScreenState createState() => _InvalidDeviceScreenState();
}

class _InvalidDeviceScreenState extends State<InvalidDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    double invalidWidth = MediaQuery.of(context).size.width;
    double invalidText1;
    double invalidText2;
    if (invalidWidth <= 800) {
      invalidText1 = 4;
      invalidText2 = 17;
    } else {
      invalidText1 = 2.8;
      invalidText2 = 4.8;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4E73DF),
        hintColor: const Color(0xFFFF5733),
        scaffoldBackgroundColor: const Color(0xFFF3F5F7),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xfff3e1e1),
                Color(0xffd9d9f5),
                Color(0xffd7d7fc),
              ],
            ),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 400,
                      minHeight: 200,
                      maxWidth: 400,
                      maxHeight: 200,
                    ),
                    child: Image.asset(
                        'assets/img/niceescholarlogo_transparent_shadow.png',
                        fit: BoxFit.contain),
                  ),
                  const Icon(
                    Icons.error,
                    size: 30,
                    color: Color(0xff072f4a),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / invalidText1,
                      right: MediaQuery.of(context).size.width / invalidText1,
                    ),
                    child: const SizedBox(
                        width: 800,
                        child: Text(
                          "Sorry, Invalid Device.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Courgette-Regular',
                            color: Color(0xff072f4a),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / invalidText2,
                      right: MediaQuery.of(context).size.width / invalidText2,
                    ),
                    child: const SizedBox(
                        width: 600,
                        child: Text(
                          "This App is not supported in this device",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Courgette-Regular',
                            color: Color(0xff072f4a),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShadowTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final Color shadowColor;

  ShadowTextPainter({
    required this.text,
    required this.textStyle,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Draw shadow
    textPainter.paint(
      canvas,
      const Offset(0, 2), // Shift shadow slightly down and to the right
    );

    // Draw text
    textPainter.paint(
      canvas,
      const Offset(0, 0), // Original position
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
