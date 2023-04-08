import 'dart:io';
import 'dart:ui';

import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/back_button.dart';

class VideoPlayScreen extends StatefulWidget {
  final String videoPath;
  final bool? asDialog;
  final String title;

  const VideoPlayScreen({
    Key? key,
    required this.videoPath,
    this.title = "",
    this.asDialog,
  }) : super(key: key);
  @override
  VideoPlayScreenState createState() => VideoPlayScreenState();
}

class VideoPlayScreenState extends State<VideoPlayScreen>
    with WidgetsBindingObserver {
  late VideoPlayerController? _videoPlayerController;

  late ChewieController _chewieController;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();


    try {
      if (widget.videoPath.contains("http")) {
        solukLog(logMsg: "video path is http");
        _videoPlayerController = VideoPlayerController.network(widget.videoPath,
            videoPlayerOptions: VideoPlayerOptions());
      } else {
        _videoPlayerController =
            VideoPlayerController.file(File(widget.videoPath));
      }
    }catch(e){
      debugPrint("Error: $e");
    }
    _videoPlayerController!.initialize().then((value) {
      setState(() {
        isLoading = false;
      });

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        showControls: true,
        showControlsOnInitialize: true,
        fullScreenByDefault: true,
        // autoPlay: true,
        allowFullScreen: true,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        allowedScreenSleep: false,
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        _chewieController.enterFullScreen();
        _chewieController.play();
      });

      _chewieController.addListener(() {
        if (_chewieController.isPlaying) {
          _chewieController.pause();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.asDialog != null && widget.asDialog == true
          ? Colors.transparent
          : backgroundColor,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Stack(
          // alignment: Alignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
                left: 5.w, top: 4.h, child: SolukBackButton(callback: () {})),
            Positioned(
              left: 5.w,
              top: 10.h,
              child: Text(
                widget.title,
                style: subTitleTextStyle(context)?.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
            // Expanded(
            //   child: GestureDetector(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: Container(color: Colors.transparent)),
            // ),
            isLoading
                ? Center(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Colors.grey.shade500),
                            backgroundColor: Colors.blue,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'loading',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: GestureDetector(
                        onTap: () {
                          if (_chewieController.isPlaying) {
                            _chewieController.pause();
                          } else {
                            _chewieController.enterFullScreen();
                            _chewieController.play();
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20)),
                          width: defaultSize.screenWidth,
                          child: IgnorePointer(
                            // ignoring: false,
                            child: Chewie(
                              controller: _chewieController,
                            ),
                          ),
                        ),
                      ),
                      // widget.videoPath.contains('http')
                      //     ? BetterPlayer.network(
                      //         widget.videoPath,
                      //         betterPlayerConfiguration:
                      //             const BetterPlayerConfiguration(
                      //                 aspectRatio: 16 / 9, autoPlay: false),
                      //       )
                      //     : BetterPlayer.file(
                      //         widget.videoPath,
                      //         betterPlayerConfiguration:
                      //             const BetterPlayerConfiguration(
                      //                 aspectRatio: 16 / 9, autoPlay: false),
                      //       ),
                    ),
                  ),
            // Expanded(
            //   child: GestureDetector(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: Container(color: Colors.transparent)),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController!.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
