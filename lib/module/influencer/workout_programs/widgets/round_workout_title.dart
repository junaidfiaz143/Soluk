import 'dart:io';

import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/thumbnail.dart';
import '../../../../res/color.dart';

class RoundWorkoutTile extends StatelessWidget {
  final String image;
  final String description;
  final VoidCallback callback;
  final String exerciseType;
  final String exerciseValue;
  final bool? keepTitleInCenter;
  final bool? isRoundTile;
  final String? mediaType;

  const RoundWorkoutTile(
      {Key? key,
      required this.image,
      required this.description,
      required this.exerciseType,
      required this.exerciseValue,
      required this.callback,
      this.mediaType = "Image",
      this.keepTitleInCenter,
      this.isRoundTile})
      : super(key: key);

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
            height: HEIGHT_5 * (isRoundTile == true ? 1.1 : 1.3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(isRoundTile == true ? 16.0 : 10.0)),
              color: Colors.grey.withOpacity(0.2),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxis,
              children: [
                Row(
                  children: [
                    image != ""
                        ? (mediaType == "Image")
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CachedNetworkImage(
                                  width: WIDTH_5 * 3,
                                  height: HEIGHT_5 * 1.3,
                                  imageUrl: image,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        color: PRIMARY_COLOR,
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  print(image);
                                  callback();
/*                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPlayScreen(
                            videoPath: image!)));*/
                                },
                                child: FutureBuilder<String?>(
                                    future: getThumbnail(image),
                                    builder: (context, snapshot) {
                                      print(snapshot.data ?? '');
                                      return Container(
                                        width: WIDTH_5 * 3,
                                        height: HEIGHT_5 * 1.3,
                                        decoration:
                                            (snapshot.data ?? null) == null
                                                ? BoxDecoration(
                                                    borderRadius:
                                                        BORDER_CIRCULAR_RADIUS)
                                                : BoxDecoration(
                                                    borderRadius:
                                                        BORDER_CIRCULAR_RADIUS,
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          File(snapshot.data!)),
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
                              )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: keepTitleInCenter == true
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: defaultSize.screenWidth * 0.4,
                            child: Text(
                              description,
                              maxLines: 2,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                exerciseType,
                                style: labelTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 8.sp,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                exerciseValue,
                                style: labelTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
