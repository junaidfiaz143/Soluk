import 'dart:io';

import 'package:app/core/thumbnail.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../res/color.dart';
import '../../user/workout_programs/bloc/user_workout_bloc.dart';
import '../workout/view/video_play_screen.dart';

class WorkoutTileVideoThumbnail extends StatelessWidget {
  WorkoutTileVideoThumbnail(
      {Key? key,
      required this.url,
      this.playBack = false,
      this.decorated = false,
      this.height = 0.0,
      this.workoutId})
      : super(key: key);
  final String? url;
  final bool? playBack;
  final bool? decorated;
  final double height;
  final String? workoutId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: getThumbnail(url!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: this.height > 0.0 ? height : HEIGHT_5 + HEIGHT_5,
                  width: double.maxFinite,
                  // width: HEIGHT_5 * 1.2,
                  decoration: decorated!
                      ? (snapshot.data ?? null) == null
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: FileImage(File(snapshot.data!)),
                                fit: BoxFit.cover,
                              ),
                            )
                      : BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(snapshot.data!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                playBack!
                    ? SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // if (workoutId != null) {
                                // UserWorkoutBloc _userWorkoutBloc =
                                //     BlocProvider.of(context);
                                // }

                                if (playBack == true) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return VideoPlayScreen(
                                          asDialog: true,
                                          videoPath: url!,
                                        );
                                      });
                                }
                              },
                              child: Icon(
                                Icons.play_circle_fill,
                                color: TOGGLE_BACKGROUND_COLOR,
                                size: 5.h,
                              ),
                            )
                          ],
                        ),
                      )
                    : Icon(
                        Icons.play_circle_fill,
                        color: TOGGLE_BACKGROUND_COLOR,
                        size: 5.h,
                      ),
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator(color: PRIMARY_COLOR));
          }
        });
    // : Container(
    //     width: double.maxFinite,
    //     height: HEIGHT_5 * 1.5,
    //     decoration: BoxDecoration(
    //       borderRadius: const BorderRadius.all(
    //         Radius.circular(30.0),
    //       ),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.5),
    //           spreadRadius: 3,
    //           blurRadius: 4,
    //           offset: const Offset(0, 3), // changes position of shadow
    //         ),
    //       ],
    //       image: DecorationImage(
    //         image: AssetImage(url!),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     clipBehavior: Clip.antiAliasWithSaveLayer,
    //     child: CachedNetworkImage(
    //       imageUrl: url!,
    //       fit: BoxFit.cover,
    //       progressIndicatorBuilder: (context, url, downloadProgress) =>
    //           Center(
    //         child: CircularProgressIndicator(
    //             color: PRIMARY_COLOR, value: downloadProgress.progress),
    //       ),
    //       errorWidget: (context, url, error) => Icon(Icons.error),
    //     ),
    //   );
  }
}
