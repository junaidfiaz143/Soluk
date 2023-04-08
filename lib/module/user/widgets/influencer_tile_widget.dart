import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';
import 'package:app/res/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../res/constants.dart';
import '../../../res/globals.dart';

class InfluencerTile extends StatelessWidget {
  final String name, imgUrl;
  final VoidCallback? onPressed;
  final Data? model;
  const InfluencerTile(
      {Key? key,
      this.name = "Umair",
      this.imgUrl =
          "https://static.toiimg.com/thumb/resizemode-4,msid-76729750,imgsize-249247,width-720/76729750.jpg",
      this.onPressed = null, this.model })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: double.maxFinite,
          height: HEIGHT_4 + HEIGHT_4,
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 0.8.h,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 3.w,
                ),
                Container(
                  width: 80,
                  height: 80,
                  child: ClipOval(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
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
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontFamily: FONT_FAMILY),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 4.w,
                ),
                SizedBox(
                  width: 4.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
