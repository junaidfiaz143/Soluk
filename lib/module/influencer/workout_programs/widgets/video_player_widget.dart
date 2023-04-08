import 'dart:io';

import 'package:app/res/color.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget(
      {Key? key,
      required this.url,
      this.mediaTypeisLocalVideo = false,
      this.autoPlay = true,
      this.file})
      : super(key: key);
  final String url;
  final bool? mediaTypeisLocalVideo;
  final bool? autoPlay;
  final File? file;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  Color mainColor = DROPDOWN_BORDER_COLOR;
  Color mainColorBorder = Colors.grey;
  Color tileColor = Colors.white;

  var _videoPlayerController;

  bool isLoading = true;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    if (widget.mediaTypeisLocalVideo == false) {
      _videoPlayerController = VideoPlayerController.network(widget.url);
    } else {
      _videoPlayerController = VideoPlayerController.file(widget.file!);
    }

    _videoPlayerController.initialize().then((value) {
      setState(() {
        isLoading = false;
      });

      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          showControls: true,
          showControlsOnInitialize: true,
          autoPlay: widget.autoPlay??true,
          allowFullScreen: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: isLoading
          ? Center(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(mainColorBorder),
                      backgroundColor: tileColor,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'loading',
                      style: TextStyle(color: tileColor),
                    ),
                  ],
                ),
              ),
            )
          : Chewie(
              controller: _chewieController,
            ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
