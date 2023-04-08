import 'dart:io';

import 'package:app/core/thumbnail.dart';
import 'package:app/module/influencer/workout/view/video_play_screen.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class MyDownloadTile extends StatelessWidget {
  final String image;
  final String mediaType;
  final String title;
  final String details;
  final String numberOfViews;
  final String excerciseType;
  final String totalSets;
  final String description;
  final VoidCallback callback;

  const MyDownloadTile(
      {Key? key,
      required this.image,
      required this.mediaType,
      required this.title,
      required this.details,
      required this.callback,
      required this.numberOfViews,
      required this.excerciseType,
      required this.totalSets,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    solukLog(logMsg: image);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print(image);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoPlayScreen(videoPath: image)));
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
                        child: image.contains("http")
                            ? CachedNetworkImage(
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
                              )
                            : Image(
                                width: WIDTH_5 * 3,
                                height: HEIGHT_5 * 1.5,
                                fit: BoxFit.cover,
                                image: FileImage(File(image))),
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
                          this.description,
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: labelTextStyle(context)?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 9.sp),
                        ),
                        Text(
                          title,
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: labelTextStyle(context)?.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 13.sp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5.h),
                          child: Row(
                            children: [
                              Text(
                                excerciseType,
                                maxLines: 1,
                                style: labelTextStyle(context)?.copyWith(
                                  color: Colors.grey,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SvgPicture.asset(
                                    "assets/svgs/ic_repeat.svg"),
                              ),
                              Text(
                                totalSets,
                                maxLines: 1,
                                style: labelTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.5.h),
                          child: SvgPicture.asset("assets/svgs/ic_mobile.svg"),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: callback,
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
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
