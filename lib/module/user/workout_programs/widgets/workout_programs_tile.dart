import 'dart:io';

import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/module/user/workout_programs/model/user_workouts_model.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/default_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/thumbnail.dart';

class WorkoutProgramTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String mediaType;
  final MyWorkoutStats? myWorkoutStats;
  final VoidCallback callback;
  const WorkoutProgramTile({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    this.mediaType = "Image",
    this.myWorkoutStats,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            callback();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            height: HEIGHT_5 * 1.3,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (mediaType == "Image")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            width: WIDTH_5 * 3,
                            height: HEIGHT_5 * 1.3,
                            imageUrl: image,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  color: PRIMARY_COLOR,
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            callback();
                          },
                          child: SizedBox(
                              width: WIDTH_5 * 3,
                              height: HEIGHT_5 * 1.3,
                              child: WorkoutTileVideoThumbnail(
                                url: image,
                                playBack: false,
                                decorated: true,
                              ))

                          // child: FutureBuilder<String?>(
                          //     future: getThumbnail(image),
                          //     builder: (context, snapshot) {
                          //       print(snapshot.data ?? '');
                          //       return Container(
                          //         width: WIDTH_5 * 3,
                          //         height: HEIGHT_5 * 1.3,
                          //         decoration: (snapshot.data ?? null) == null
                          //             ? BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(20))
                          //             : BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(20),
                          //                 image: DecorationImage(
                          //                   image:
                          //                       FileImage(File(snapshot.data!)),
                          //                   fit: BoxFit.cover,
                          //                 ),
                          //               ),
                          //         child: Center(
                          //           child: Icon(
                          //             Icons.play_circle_fill,
                          //             color: Colors.white,
                          //             size: 4.h,
                          //           ),
                          //         ),
                          //       );
                          //     }),
                          ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          width: DefaultSize.defaultSize.width * 0.48,
                          child: Text(
                            title,
                            // overflow: TextOverflow.ellipsis,
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          width: DefaultSize.defaultSize.width * 0.48,
                          child: Text(
                            description,
                            overflow: TextOverflow.ellipsis,
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.grey,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  myWorkoutStats != null
                      ? CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 5.0,
                          percent: double.parse(
                                  myWorkoutStats!.progress.toString()) /
                              100,
                          center: Text("${myWorkoutStats!.progress ?? 0}%"),
                          progressColor: Colors.blue,
                        )
                      : Container(),
                  SB_1W,
                ]),
          ),
        ),
        SB_1H
      ],
    );
  }
}
