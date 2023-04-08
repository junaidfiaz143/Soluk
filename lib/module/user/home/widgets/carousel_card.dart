import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/thumbnail.dart';
import '../../../../res/color.dart';
import '../../../../res/globals.dart';
import '../../models/dashboard/user_dashboard_model.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({Key? key, required this.singleItem}) : super(key: key);
  final FeaturedInfluencers singleItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 11),
      width: 208,
      height: 239,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              singleItem.assetUrl != ""
                  ? (singleItem.assetType == "Image")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            width: WIDTH_5 * 3,
                            height: HEIGHT_5 * 1.3,
                            imageUrl: singleItem.assetUrl!,
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
                          future: getThumbnail(singleItem.assetUrl!),
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
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 4.h,
                                ),
                              ),
                            );
                          })
                  : SizedBox.shrink(),
              Positioned(
                bottom: 20.0,
                left: 16.0,
                right: 16.0,
                child: Text(
                  singleItem.influencer?.fullname ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Container(color: ?Colors.white.withOpacity(0.7):Colors.transparent,),
            ],
          )),
    );
  }
}
