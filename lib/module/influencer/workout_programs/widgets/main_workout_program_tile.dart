import 'dart:io';

import 'package:app/animations/slide_up_transparent_animation.dart';
import 'package:app/module/influencer/widgets/reward_popup.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/module/user/profile/sub_screen/my_downloads/bloc/my_downloads_cubit.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_alert_dialog.dart';
import '../workout_program_bloc/workout_program_bloc.dart';

class MainWorkoutProgramTile extends StatelessWidget {
  final String image;
  final String mediaType;
  final String title;
  final int id;
  final String details;
  final String numberOfViews;
  final String ratting;
  final VoidCallback callback;

  const MainWorkoutProgramTile({
    Key? key,
    required this.image,
    required this.mediaType,
    required this.title,
    required this.id,
    required this.details,
    required this.callback,
    required this.numberOfViews,
    required this.ratting,
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
            child: Slidable(
              key: Key(image.toString()),
              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: StretchMotion(),

                // A pane can dismiss the Slidable.
                // dismissible: DismissiblePane(onDismissed: () {}),
                // All actions are defined in the children parameter.
                children: [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    icon: Icons.delete,
                    onPressed: (BuildContext context) {
                      showDeleteConfirmationDialog(context, workoutId: id);
                    },

                    // label: "Delete",
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxis,
                children: [
                  Row(
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
                                    const Icon(Icons.error),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                print(image);
                                callback();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             VideoPlayScreen(videoPath: image)));
                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return VideoPlayScreen(
                                //         asDialog: true,
                                //         videoPath: image,
                                //       );
                                //     });
                              },
                              child: SizedBox(
                                width: WIDTH_5 * 3,
                                height: HEIGHT_5 * 1.5,
                                child: WorkoutTileVideoThumbnail(
                                  url: image,
                                  decorated: true,
                                ),
                              )
                              // child: FutureBuilder<String?>(
                              //     future: getThumnail(image ?? ''),
                              //     builder: (context, snapshot) {
                              //       print(snapshot.data ?? '');
                              //       return Container(
                              //         width: WIDTH_5 * 3,
                              //         height: HEIGHT_5 * 1.5,
                              //         decoration:
                              //             (snapshot.data ?? null) == null
                              //                 ? BoxDecoration(
                              //                     borderRadius:
                              //                         BORDER_CIRCULAR_RADIUS)
                              //                 : BoxDecoration(
                              //                     borderRadius:
                              //                         BORDER_CIRCULAR_RADIUS,
                              //                     image: DecorationImage(
                              //                       image: FileImage(
                              //                           File(snapshot.data!)),
                              //                       fit: BoxFit.cover,
                              //                     ),
                              //                   ),
                              //         child: Center(
                              //           child: Icon(
                              //             Icons.play_circle_fill,
                              //             color: Colors.grey,
                              //             size: 4.h,
                              //           ),
                              //         ),
                              //       );
                              //     }),
                              ),
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: defaultSize.screenWidth * 0.42,
                              child: Text(
                                title,
                                maxLines: 2,
                                style: subTitleTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Text(
                              details,
                              maxLines: 1,
                              style: labelTextStyle(context)?.copyWith(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.remove_red_eye_rounded,
                                      color: PRIMARY_COLOR,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      numberOfViews,
                                      maxLines: 1,
                                      style: labelTextStyle(context)?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SB_2W,
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_outlined,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ratting,
                                      maxLines: 1,
                                      style: labelTextStyle(context)?.copyWith(
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: const [
                  //     Icon(
                  //       Icons.arrow_forward_ios_outlined,
                  //       size: 15,
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     )
                  //   ],
                  // )
                  Icon(
                    Icons.arrow_forward_ios,
                    size: WIDTH_3,
                  ),
                  SB_1W,
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

Future<bool> deleteFile({required String path}) async {
  try {
    final file = await File(path);

    await file.delete();
    return true;
  } catch (e) {
    return false;
  }
}

bool? showDeleteConfirmationDialog(BuildContext context,
    {String? path, MyDownloadsCubit? downloadsCubit, int? workoutId}) {
  WorkoutProgramBloc? _workoutProgramBloc;
  if (path == null) {
    _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
  }

  var res;
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
                    // res = await deleteFile(path: path!);
                    if (path == null) {
                      _workoutProgramBloc?.add(DeleteWorkoutProgramsEvent(
                          workoutProgramId: workoutId));
                    }
                    Navigator.pop(navigatorKey.currentContext!, res);
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
                    Navigator.pop(navigatorKey.currentContext!, res);
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
