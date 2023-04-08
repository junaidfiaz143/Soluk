import 'dart:io';

import 'package:app/core/thumbnail.dart';
import 'package:app/module/influencer/workout/view/video_play_screen.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

class MyWorkoutProgramTile extends StatelessWidget {
  final String image;
  final String mediaType;
  final String title;
  final String details;
  final double progress;
  final bool isCompleted;
  final VoidCallback callback;

  const MyWorkoutProgramTile({
    Key? key,
    required this.image,
    required this.mediaType,
    required this.title,
    required this.details,
    required this.callback,
    required this.progress,
    required this.isCompleted,
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
            width: double.maxFinite,
            height: HEIGHT_5 * 1.5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children: [
                (mediaType == "Image")
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          width: WIDTH_5 * 3,
                          height: HEIGHT_5 * 1.5,
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
                          print(image);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VideoPlayScreen(videoPath: image)));
                        },
                        child: FutureBuilder<String?>(
                            future: getThumbnail(image),
                            builder: (context, snapshot) {
                              print(snapshot.data ?? '');
                              return Container(
                                width: WIDTH_5 * 3,
                                height: HEIGHT_5 * 1.5,
                                decoration: (snapshot.data ?? null) == null
                                    ? BoxDecoration(
                                        borderRadius: BORDER_CIRCULAR_RADIUS)
                                    : BoxDecoration(
                                        borderRadius: BORDER_CIRCULAR_RADIUS,
                                        image: DecorationImage(
                                          image:
                                              FileImage(File(snapshot.data!)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                child: Center(
                                  child: Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 4.h,
                                  ),
                                ),
                              );
                            }),
                      ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: labelTextStyle(context)?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: defaultSize.screenWidth * .049),
                        ),
                        Text(
                          details,
                          maxLines: 1,
                          style: labelTextStyle(context)?.copyWith(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (isCompleted)
                    ? CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: 1,
                        center: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done,
                                color: Colors.lightGreen,
                                size: 13,
                              ),
                              Text(
                                "Completed",
                                style: subTitleTextStyle(context)?.copyWith(
                                  color: Colors.lightGreen,
                                  fontSize: 7.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        progressColor: Colors.blue,
                      )
                    : CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: progress / 100,
                        center: Text(
                          progress.toString(),
                          style: headingTextStyle(context)?.copyWith(
                            color: Colors.black,
                            fontSize: 10.sp,
                          ),
                        ),
                        progressColor: Colors.blue,
                      ),
                SB_1W,
              ],
            ),
          ),
        ),
        SB_1H
      ],
    );
  }
}
