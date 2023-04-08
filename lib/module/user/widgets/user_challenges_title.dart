import 'dart:io';

import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/default_size.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/thumbnail.dart';

class UserChallengesTile extends StatelessWidget {
  final String image;
  final String title;
  final String mediaType;
  final VoidCallback callback;
  const UserChallengesTile({
    Key? key,
    required this.image,
    required this.title,
    this.mediaType = "Image",
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
                                    Icon(Icons.error),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                callback();
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
                            ),

                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: DefaultSize.defaultSize.width * 0.48,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: subTitleTextStyle(context)?.copyWith(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: defaultSize.screenHeight * .02,
                        ),
                      ),
                      SB_1W,

                      // Row(
                      //   children: [
                      //     Container(
                      //       width: WIDTH_5 * 3,
                      //       height: HEIGHT_5 * 1.3,
                      //       decoration: BoxDecoration(
                      //         borderRadius: const BorderRadius.only(
                      //             bottomRight: Radius.circular(20.0),
                      //             bottomLeft: Radius.circular(20.0),
                      //             topLeft: Radius.circular(20.0),
                      //             topRight: Radius.circular(20.0)),
                      //         image: DecorationImage(
                      //             image: NetworkImage(image), fit: BoxFit.cover),
                      //         color: Colors.white,
                      //       ),
                      //       // child: Image(
                      //       //   image: AssetImage(
                      //       //     image,
                      //       //   ),
                      //       //   fit: BoxFit.fill,
                      //       // ),
                      //     ),
                      //     const SizedBox(
                      //       width: 15,
                      //     ),
                      //     Text(
                      //       title,
                      //       style: subTitleTextStyle(context)?.copyWith(
                      //         color: Colors.black,
                      //         fontSize: 14.sp,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: const [
                      //     Icon(
                      //       Icons.arrow_forward_ios_outlined,
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     )
                      //   ],
                      // )
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
