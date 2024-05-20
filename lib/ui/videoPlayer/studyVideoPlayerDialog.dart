// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_v_2_0_0/models/videos_category_neet_jee.dart';
import 'package:lms_v_2_0_0/ui/studyMaterial/videoList/chapterList.dart';
import 'package:pip_view/pip_view.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:path/path.dart' as p;

class studyVideoPlayerDialog extends StatefulWidget {
  final String? encryptedVideoPath;
  final String? path;

  final VideosCategoryNEETJEE vidsarr;
  final String subjectName;
  final String? name;
  final List<String>? metawords;
  final String? selectedValue;
  final String? imageUrl;
  const studyVideoPlayerDialog(
      this.encryptedVideoPath,
      this.path,
      this.vidsarr,
      this.subjectName,
      this.name,
      this.metawords,
      this.selectedValue,
      this.imageUrl,
      {super.key});

  @override
  studyVideoPlayerDialogState createState() => studyVideoPlayerDialogState();
}

class studyVideoPlayerDialogState extends State<studyVideoPlayerDialog> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  static ChewieController? _activeChewieController;

  @override
  void initState() {
    super.initState();

    _initializeVideo();
  }

  void _initializeVideo() {
    _activeChewieController?.dispose();
    _activeChewieController = null;
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(p.join(widget.encryptedVideoPath!, widget.path)))
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            autoInitialize: true,
            autoPlay: true,
            looping: false,
            allowFullScreen: false,
            showControls: true,
            aspectRatio: 16 / 9,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  "Video not found",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                ),
              );
            },
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
              DeviceOrientation.portraitDown,
              DeviceOrientation.portraitUp,
            ],
          );
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          _activeChewieController = _chewieController;
        });
      });
  }

  void closeVideo() {
    _chewieController!.pause();
    _videoPlayerController!.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    if (_activeChewieController == _chewieController) {
      _activeChewieController = null;
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    if (_activeChewieController == _chewieController) {
      _activeChewieController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PIPView(
        avoidKeyboard: true,
        floatingWidth: 400.w,
        floatingHeight: 400.h,
        builder: (context, isFloating) {
          return Stack(
            children: [
              Center(
                child: _chewieController != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              Positioned(
                bottom: 50.0,
                right: 35.0,
                child: MaterialButton(
                  child: Icon(
                    Icons.picture_in_picture,
                    size: 40.sp,
                  ),
                  onPressed: () {
                    PIPView.of(context)!.presentBelow(
                      ChapterList(
                        widget.vidsarr,
                        widget.subjectName,
                        widget.name,
                        widget.metawords,
                        widget.selectedValue,
                        widget.imageUrl,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 25.0,
                left: 10.0,
                child: MaterialButton(
                  onPressed: closeVideo,
                  child: Icon(
                    CupertinoIcons.back,
                    size: 30.sp,
                  ),
                ),
              ),
              // if (isFloating) // Render the cross button only in PIP mode
              //   Positioned(
              //     top: 50.0,
              //     right: 300.0,
              //     child: MaterialButton(
              //       onPressed: () {
              //         PIPView.of(context)!.dispose();
              //         closeVideo();
              //       },
              //       child: Icon(
              //         Icons.close,
              //         size: 50.sp,
              //       ),
              //     ),
              //   ),
            ],
          );
        },
      ),
    );
  }
}
