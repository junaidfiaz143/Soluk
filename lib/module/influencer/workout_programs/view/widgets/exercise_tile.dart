import 'dart:io';

import 'package:app/core/thumbnail.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/default_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../res/constants.dart';
import '../../../../../services/localisation.dart';
import '../../../more/widget/custom_alert_dialog.dart';
import '../../../widgets/reward_popup.dart';
import '../../../widgets/saluk_gradient_button.dart';
import '../../../widgets/workout_tile_video_thumbnail.dart';

class ExerciseTile extends StatelessWidget {
  final String? title;
  final String? type;
  final String? duration;
  final VoidCallback? callback;
  final String? image;
  final String? mediaType;
  final String? timebase;
  const ExerciseTile(
      {Key? key,
      this.timebase,
      this.title,
      this.type,
      this.duration,
      this.mediaType = "Image",
      this.callback,
      this.image})
      : super(key: key);

  bool? showDeleteConfirmationDialog(BuildContext context, {String? name}) {
    bool? res = true;
    navigatorKey.currentState
        ?.push(
      SlideUpTransparentRoute(
        enterWidget: CustomAlertDialog(
          contentWidget: RewardPopUp(
            iconPath: 'assets/images/ic_dialog_delete.png',
            title: AppLocalisation.getTranslated(context, LKDelete),
            content: AppLocalisation.getTranslated(
                context, LKConfirmDeleteWorkOutProgram),
            actionButtons: Row(
              children: [
                SizedBox(
                  width: defaultSize.screenWidth * .37,
                  child: SalukGradientButton(
                    title: AppLocalisation.getTranslated(context, LKYes),
                    onPressed: () async {
                      Navigator.of(navigatorKey.currentContext!).pop();
                    },
                    buttonHeight: HEIGHT_3,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: defaultSize.screenWidth * .37,
                  child: SalukGradientButton(
                    title: AppLocalisation.getTranslated(context, LKNo),
                    onPressed: () {
                      Navigator.of(navigatorKey.currentContext!).pop();
                    },
                    buttonHeight: HEIGHT_3,
                    linearGradient: const LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        routeName: CustomAlertDialog.id,
      ),
    )
        .then((value) {
      if (value != null) {
        return value;
      } else {
        return false;
      }
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            callback!();
          },
          child: Container(
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
            child: Slidable(
              key: Key(image.toString()),
              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: showDeleteConfirmationDialog,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    icon: Icons.delete,
                    // label: "Delete",
                  ),
                ],
              ),
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
                                imageUrl: image!,
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
                                print(image);
                                callback!();
                                /*                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayScreen(
                              videoPath: image!)));*/
                              },

                              child: SizedBox(
                                width: WIDTH_5 * 3,
                                height: HEIGHT_5 * 1.3,
                                child: WorkoutTileVideoThumbnail(
                                    decorated: true,
                                    playBack: false,
                                    url: image ?? ''),
                              ),
                              // child: FutureBuilder<String?>(
                              //     future: getThumbnail(image ?? ''),
                              //     builder: (context, snapshot) {
                              //       print(snapshot.data ?? '');
                              //       return Container(
                              //         width: WIDTH_5 * 3,
                              //         height: HEIGHT_5 * 1.3,
                              //         decoration: (snapshot.data ?? null) == null
                              //             ? BoxDecoration(
                              //                 borderRadius:
                              //                     BORDER_CIRCULAR_RADIUS)
                              //             : BoxDecoration(
                              //                 borderRadius:
                              //                     BORDER_CIRCULAR_RADIUS,
                              //                 image: DecorationImage(
                              //                   image: FileImage(
                              //                       File(snapshot.data!)),
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
                        width: 10,
                      ),
                      SizedBox(
                        width: DefaultSize.defaultSize.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title!,
                              overflow: TextOverflow.ellipsis,
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              type!,
                              maxLines: 1,
                              style: labelTextStyle(context)?.copyWith(
                                color: Colors.grey,
                                fontSize: 10.sp,
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              timebase == null
                                  ? ((type == "Supersets" || type == "Circuit")
                                      ? "$duration Rounds"
                                      : "$duration  min")
                                  : timebase!,
                              maxLines: 1,
                              style: labelTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
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
        ),
        SB_1H
      ],
    );
  }
}
