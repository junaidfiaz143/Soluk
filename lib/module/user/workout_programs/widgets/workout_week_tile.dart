import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/default_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WorkoutWeekTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String mediaType;
  final String state;
  final VoidCallback callback;

  const WorkoutWeekTile({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    this.mediaType = "Image",
    this.state = "pending",
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
            margin: const EdgeInsets.symmetric(horizontal: 5),
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
                  Row(
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
                                    const Icon(Icons.error),
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
                                  )),
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: DefaultSize.defaultSize.width * 0.48,
                            child: Text(
                              description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.grey,
                                fontSize: 8.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            width: DefaultSize.defaultSize.width * 0.48,
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SB_1W,
                      state == "completed"
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: defaultSize.screenWidth * .06,
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                ]),
          ),
        ),
        SB_1H
      ],
    );
  }
}
