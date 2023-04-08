// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:app/module/influencer/workout/model/blog_modal.dart';

import 'package:app/module/user/models/dashboard/tag_search_influencer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/thumbnail.dart';
import '../../../../res/color.dart';
import '../../../../res/globals.dart';

class InfluencerCardTagSearch extends StatelessWidget {
  InfluencerCardTagSearch({
    Key? key,
    this.influencer,
    this.blog,
    required this.isBlog,
    required this.courseIndex,
    required this.onItemPress,
  }) : super(key: key);

  final InfluencersInfo? influencer;
  final Data? blog;
  final int courseIndex;
  final bool isBlog;
  final Function onItemPress;

  @override
  Widget build(BuildContext context) {
    bool isVideo = influencer?.imageUrl?.contains(".mp4") ?? false;

    return InkWell(
      onTap: () {
        onItemPress();
      },
      child: Container(
        width: 160,
        height: 160,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ((influencer != null && influencer?.imageUrl != "") ||
                      (blog != null && blog?.imageUrl != ""))
                  ? (isBlog || !isVideo)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            width: WIDTH_5 * 3,
                            height: HEIGHT_5 * 1.3,
                            imageUrl: isBlog
                                ? blog?.imageUrl ?? ""
                                : influencer?.imageUrl ?? "",
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
                      : FutureBuilder<String?>(
                          future: getThumbnail(influencer?.imageUrl ?? ""),
                          builder: (context, snapshot) {
                            return Container(
                              width: WIDTH_5 * 3,
                              height: HEIGHT_5 * 1.3,
                              decoration: (snapshot.data ?? null) == null
                                  ? BoxDecoration(
                                      borderRadius: BORDER_CIRCULAR_RADIUS)
                                  : BoxDecoration(
                                      borderRadius: BORDER_CIRCULAR_RADIUS,
                                      image: DecorationImage(
                                        image: FileImage(File(snapshot.data!)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              child: Center(
                                child: (snapshot.data ?? null) == null
                                    ? CircularProgressIndicator(
                                        color: PRIMARY_COLOR,
                                      )
                                    : Icon(
                                        Icons.play_circle_fill,
                                        color: Colors.white,
                                        size: 4.h,
                                      ),
                              ),
                            );
                          })
                  : SizedBox.shrink(),
              Positioned(
                bottom: 14,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBlog ? blog?.title ?? '' : influencer?.fullname ?? '',
                      style: subTitleTextStyle(context)
                          ?.copyWith(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    isBlog
                        ? SizedBox()
                        : Text(
                            /*influencer?.intro ?? */
                            '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: labelTextStyle(context)
                                ?.copyWith(fontSize: 10, color: Colors.white),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
