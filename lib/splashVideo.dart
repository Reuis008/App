import 'dart:async';
import 'package:flutter/material.dart';
import 'package:duration_button/duration_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:lms_v_2_0_0/ui/home.dart';

class SplashVideo extends StatefulWidget {
  const SplashVideo({Key? key}) : super(key: key);

  @override
  _SplashVideoState createState() => _SplashVideoState();
}

class _SplashVideoState extends State<SplashVideo> {
  late ChewieController _chewieController;
  late VideoPlayerController videoPlayer;
  bool videoReady = false;
  bool showSkipButton = false;
  bool moduleLoaded = false;

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', false);
      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    isFirstTime().then((isFirstTime) {
      setState(() {
        showSkipButton = !isFirstTime;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        videoPlayer =
            VideoPlayerController.asset("assets/splash_video/cm_speech.mp4");
        _chewieController = ChewieController(
          videoPlayerController: videoPlayer,
          aspectRatio: 960 / 540,
          autoInitialize: true,
          allowFullScreen: true,
          autoPlay: true,
          looping: false,
          showControls: false,
          deviceOrientationsAfterFullScreen: [
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.red,
            handleColor: Colors.blue,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.lightGreen,
          ),
        );
        videoPlayer.addListener(videoListener);
      });
    });

    Timer.periodic(const Duration(milliseconds: 0), (Timer t) {
      setState(() {
        moduleLoaded = true;
        t.cancel();
      });
    });
  }

  void videoListener() {
    if (videoPlayer.value.position == videoPlayer.value.duration) {
      _navigateToHome();
    } else if (videoPlayer.value.position == Duration.zero) {
      setState(() {
        videoReady = true;
      });
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AppHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: Stack(
                children: <Widget>[
                  videoReady
                      ? Chewie(controller: _chewieController)
                      : AnimatedContainer(
                          alignment: moduleLoaded
                              ? const Alignment(0.0, 0.0)
                              : const Alignment(1.0, 0.0),
                          duration: const Duration(milliseconds: 2000),
                          curve: Curves.easeInOut,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                                'assets/img/niceescholarlogo_transparent.png',
                                fit: BoxFit.contain),
                          ),
                        ),
                  videoReady && showSkipButton ? skipBtn() : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget skipBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, right: 10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: DurationButton(
          duration: const Duration(seconds: 3),
          onPressed: _navigateToHome,
          backgroundColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          onComplete: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("onCompleteCalled!"))),
          child: const Text(
            "Skip intro",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayer.removeListener(videoListener);
    videoPlayer.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
