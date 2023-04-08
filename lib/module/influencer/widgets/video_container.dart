import 'dart:io';

import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/module/influencer/workout_programs/widgets/video_player_widget.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/thumbnail.dart';
import '../workout/view/video_play_screen.dart';

class VideoContainer extends StatelessWidget {
  final Function()? closeButton;
  final Function()? playVideo;
  final String? netUrl;
  final File? file;
  final double? width;
  final double? height;
  final bool? isCloseShown;
  final bool? dottedBorders;

  const VideoContainer(
      {Key? key,
      this.closeButton,
      this.playVideo,
      this.file,
      this.netUrl,
      this.width,
      this.height,
      this.isCloseShown,
      this.dottedBorders = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: playVideo,
          child: Container(
            height: HEIGHT_5 * 2,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(WIDTH_3),
            ),
            // child: Icon(
            //   Icons.play_circle_fill,
            //   size: 45,
            // ),netUrl != null && netUrl != "" ? netUrl! : file!.path
            child: WorkoutTileVideoThumbnail(
                decorated: true,
                playBack: true,
                url: netUrl != null && netUrl != "" ? netUrl! : file!.path),
            width: defaultSize.screenWidth,
          ),
        ),
        Visibility(
          visible: isCloseShown == null || isCloseShown == true,
          child: Positioned(
            top: 1.h,
            right: 3.w,
            child: GestureDetector(
              onTap: closeButton,
              child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5)),
                  child: const Icon(
                    Icons.close,
                    size: 15,
                    color: TOGGLE_BACKGROUND_COLOR,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
