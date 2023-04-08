import 'dart:io';

import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/default_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../../animations/slide_up_transparent_animation.dart';
import '../../../../core/thumbnail.dart';
import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../../more/widget/custom_alert_dialog.dart';
import '../../widgets/reward_popup.dart';
import '../../widgets/saluk_gradient_button.dart';
import '../view/bloc/day_bloc/daybloc_bloc.dart';

class PlanTile extends StatelessWidget {
  final String image;
  final int? dayId;
  final int? workoutId;
  final int? weekId;
  final String title;
  final String? description;
  final String mediaType;
  final VoidCallback callback;

  const PlanTile(
      {Key? key,
      required this.image,
      required this.title,
      this.dayId,
      this.weekId,
      this.workoutId,
      this.description,
      this.mediaType = "Image",
      required this.callback})
      : super(key: key);

  bool? showDeleteConfirmationDialog(BuildContext context,
      {required int workoutId, required int dayId, required int weekId}) {
    DayblocBloc? _bloc;
    _bloc = BlocProvider.of<DayblocBloc>(context);

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
                    onPressed: () {
                      _bloc?.add(DeleteWorkoutDayEvent(
                          dayId: dayId, weekId: weekId, workoutId: workoutId));
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
            child: Slidable(
              key: Key(image.toString()),
              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      showDeleteConfirmationDialog(context,
                          dayId: dayId ?? 0,
                          weekId: weekId ?? 0,
                          workoutId: workoutId ?? 0);
                    },
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
                                  callback();
                                },
                                child: FutureBuilder<String?>(
                                    future: getThumbnail(image),
                                    builder: (context, snapshot) {
                                      return Container(
                                        width: WIDTH_5 * 3,
                                        height: HEIGHT_5 * 1.3,
                                        decoration: (snapshot.data) == null
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20))
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: FileImage(
                                                      File(snapshot.data!)),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        child: Center(
                                          child: (snapshot.data) == null
                                              ? const CircularProgressIndicator(
                                                  color: PRIMARY_COLOR,
                                                )
                                              : Icon(
                                                  Icons.play_circle_fill,
                                                  color: Colors.white,
                                                  size: 4.h,
                                                ),
                                        ),
                                      );
                                    }),
                              ),

                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: DefaultSize.defaultSize.width * 0.45,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  overflow: TextOverflow.ellipsis,
                                  style: subTitleTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Visibility(
                                  visible: description != null ? true : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      description!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: labelTextStyle(context)?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),

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
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: defaultSize.screenHeight * .02,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        SB_1H
      ],
    );
  }
}
