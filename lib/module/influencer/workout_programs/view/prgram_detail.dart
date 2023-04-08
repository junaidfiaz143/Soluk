import 'package:app/module/influencer/challenges/challenge_const.dart/challenge_const.dart';
import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/widgets/info_dialog_box.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/module/influencer/workout_programs/view/add_workout_program.dart';
import 'package:app/module/influencer/workout_programs/view/media_screen.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../animations/slide_up_transparent_animation.dart';
import '../../more/widget/custom_alert_dialog.dart';
import '../../widgets/reward_popup.dart';
import '../../widgets/saluk_gradient_button.dart';
import '../../workout/view/video_play_screen.dart';
import '../../workout/widgets/tag.dart';
import '../model/AddWorkoutPlanRequestModel.dart';
import '../model/get_workout_plan_response.dart';

class ProgramDetail extends StatefulWidget {
  static const id = 'ProgramDetail';

  final WorkoutPlan data;

  const ProgramDetail({Key? key, required this.data}) : super(key: key);

  @override
  State<ProgramDetail> createState() => _ProgramDetailState();
}

class _ProgramDetailState extends State<ProgramDetail> {
  bool _switchValue = false;
  String myWorkoutPlan = "";

  @override
  void initState() {
    super.initState();
    _switchValue = widget.data.isActive == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    workoutProgramBloc.add(WorkoutPrerequisitesLoadingEvent());
    return BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
        listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is ErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else if (state is InternetErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        // top: defaultSize.screenHeight * 0.1,
                        // left: defaultSize.screenWidth / 2 - 2.5.h,
                        child: InkWell(
                          onTap: () {
                            if (widget.data.assetType == "Image") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MediaScreen(
                                          videoUrl: widget.data.assetUrl ?? "",
                                          title: widget.data.title ?? "",
                                          mediaTypeisVideo:
                                              widget.data.assetType == 'Image'
                                                  ? false
                                                  : true,
                                        )),
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return VideoPlayScreen(
                                      title: widget.data.title ?? "",
                                      asDialog: true,
                                      videoPath: widget.data.assetUrl ?? "",
                                    );
                                  });
                            }
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: defaultSize.screenHeight * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5)
                                // image: DecorationImage(
                                //   image: AssetImage(WORKOUT_COVER2),
                                // fit: BoxFit.cover,
                                // ),
                                ),
                            child: widget.data.assetType == "Image"
                                ? CachedNetworkImage(
                                    imageUrl: widget.data.assetUrl ?? "",
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
                                  )
                                : WorkoutTileVideoThumbnail(
                                    url: widget.data.assetUrl,
                                    height: double.maxFinite,
                                  ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SolukBackButton(
                                  callback: () {},
                                ),
                                Text(
                                  widget.data.title ?? "",
                                  style: subTitleTextStyle(context)?.copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    var startTime = widget.data
                                        .createdAt; // TODO: change this to your DateTime from firebase
                                    var currentTime = DateTime.now();
                                    var diff = currentTime
                                        .difference(startTime!)
                                        .inHours;
                                    var showDeleteReason = false;
                                    if (diff > 72) {
                                      showDeleteReason = true;
                                    }

                                    showDeleteConfirmationDialog(
                                        context, showDeleteReason,
                                        (deletionReason) {
                                      //makeAPi call
                                      var request = AddWorkoutPlanRequestModel(
                                          difficultyLevel: "",
                                          media: null,
                                          assetType: "",
                                          workoutTitle: "",
                                          completionBadgeId: "",
                                          description: "",
                                          isEditing: true,
                                          isActive: 2,
                                          programType: "",
                                          rejection_reason: deletionReason);

                                      workoutProgramBloc.add(
                                          AddWorkoutProgramEvent(
                                              addWorkoutPlanRequestModel:
                                                  request));
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    height: defaultSize.screenWidth * .09,
                                    width: defaultSize.screenWidth * .09,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete_outline_outlined,
                                        color: Colors.red,
                                        size: defaultSize.screenWidth * .05,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: defaultSize.screenHeight * 0.17,
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 15, right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Program Title',
                                            maxLines: 1,
                                            style: hintTextStyle(context)
                                                ?.copyWith(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.data.title ?? "",
                                            maxLines: 1,
                                            style: hintTextStyle(context)
                                                ?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    AddWorkoutProgram(
                                                      isEditScreen: true,
                                                      data: widget.data,
                                                    )),
                                          );
                                        },
                                        child: Visibility(
                                          visible: true,
                                          child: Container(
                                            height:
                                                defaultSize.screenWidth * .09,
                                            width:
                                                defaultSize.screenWidth * .09,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(30.0),
                                                topLeft: Radius.circular(30.0),
                                                bottomLeft:
                                                    Radius.circular(30.0),
                                                bottomRight:
                                                    Radius.circular(30.0),
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                                size: defaultSize.screenWidth *
                                                    .05,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SB_1H,
                                  Text(
                                    AppLocalisation.getTranslated(
                                        context, LKDescription),
                                    maxLines: 1,
                                    style: hintTextStyle(context)?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.data.description ?? "",
                                    style: hintTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  (widget.data.workoutPlanTags!.length > 0)
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SB_1H,
                                            Text(
                                              "Select Tags",
                                              style: subTitleTextStyle(context)!
                                                  .copyWith(
                                                fontSize:
                                                    defaultSize.screenWidth *
                                                        .05,
                                              ),
                                            ),
                                            SizedBox(
                                              height: WIDTH_1,
                                            ),
                                            Text(
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                                              style: labelTextStyle(context)!
                                                  .copyWith(
                                                      color: const Color(
                                                          0xFFa4a2aa)),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            (widget.data.workoutPlanTags!
                                                    .isNotEmpty)
                                                ? Wrap(
                                                    spacing: 10,
                                                    runSpacing: 8,
                                                    children: List.generate(
                                                      widget
                                                          .data
                                                          .workoutPlanTags!
                                                          .length,
                                                      (index) {
                                                        return Tag(
                                                            text: widget
                                                                    .data
                                                                    .workoutPlanTags![
                                                                        index]
                                                                    .tags
                                                                    ?.name ??
                                                                '',
                                                            callback: () {
                                                              /*
                                          addTagsDialog(
                                              context, _tagsBloc.state.tagsModel,
                                              alreadySelectedList: tags,
                                              selectedTags: (val) {
                                                List<int> selectedIdsList = [];
                                                tags.forEach((element) {
                                                  selectedIdsList.add(element.id!);
                                                });
                                                print(val);
                                                selectedTags(
                                                    _tagsBloc.state.tagsModel
                                                        ?.responseDetails?.data ??
                                                        [],
                                                    val);
                                              });
                  */
                                                            });
                                                      },
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        )
                                      : Container(),
                                  SB_1H,
                                  Container(
                                    height: defaultSize.screenHeight * .08,
                                    width: defaultSize.screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              defaultSize.screenHeight * .025,
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height:
                                                defaultSize.screenHeight * .08,
                                            width:
                                                defaultSize.screenWidth * 0.5,
                                            child: Text(
                                              AppLocalisation.getTranslated(
                                                  context, LKPublished),
                                              style: subTitleTextStyle(context)
                                                  ?.copyWith(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                          CupertinoSwitch(
                                            value: _switchValue,
                                            activeColor: Colors.blue,
                                            onChanged: (value) async {
                                              bool isActive =
                                                  await workoutProgramBloc
                                                      .updatePublishStatus(
                                                          widget.data.id,
                                                          value == true
                                                              ? 1
                                                              : 0);
                                              if (isActive == true) {
                                                _switchValue = value;
                                                setState(() {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return InfoDialogBox(
                                                          icon:
                                                              'assets/images/tick_ss.png',
                                                          title: AppLocalisation
                                                              .getTranslated(
                                                                  context,
                                                                  LKSuccessful),
                                                          description:
                                                              AppLocalisation
                                                                  .getTranslated(
                                                                      context,
                                                                      LKYourWorkoutPrgramisPublic),
                                                          onPressed: () async {
                                                            workoutProgramBloc.add(
                                                                GetWorkoutProgramsEvent());
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        );
                                                      });
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SB_1H,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalisation.getTranslated(
                                                  context, LKCompleteBadge),
                                              style: hintTextStyle(context)
                                                  ?.copyWith(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                              ),
                                              maxLines: 1,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                    '${ChallengeConst.badges["${widget.data.completionBadge}"]}',
                                                    height: 25,
                                                    width: 25),
                                                SB_1W,
                                                Text(
                                                  '${ChallengeConst.title["${widget.data.completionBadge}"]}',
                                                  style: hintTextStyle(context)
                                                      ?.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10.sp,
                                                  ),
                                                  maxLines: 2,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalisation.getTranslated(
                                                  context, LKRatings),
                                              style: hintTextStyle(context)
                                                  ?.copyWith(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                              ),
                                              maxLines: 1,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: double.parse(
                                                      widget.data.rating
                                                          .toString()),
                                                  minRating: 1,
                                                  ignoreGestures: true,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemSize: 15,
                                                  itemCount: 5,
                                                  //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  widget.data.rating.toString(),
                                                  style: hintTextStyle(context)
                                                      ?.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SB_1H,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalisation.getTranslated(
                                                  context, LKProgramType),
                                              style: hintTextStyle(context)
                                                  ?.copyWith(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                              ),
                                              maxLines: 1,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              widget.data.programType ?? "",
                                              style: hintTextStyle(context)
                                                  ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                              ),
                                              maxLines: 2,
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalisation.getTranslated(
                                                  context, LKDifficultLevel),
                                              style: hintTextStyle(context)
                                                  ?.copyWith(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                              ),
                                              maxLines: 1,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              widget.data.difficultyLevel ?? "",
                                              style: hintTextStyle(context)
                                                  ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                              ),
                                              maxLines: 2,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SB_1H,
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 10),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           // Text(
                                  //           //   AppLocalisation.getTranslated(
                                  //           //       context, LKViews),
                                  //           //   style: hintTextStyle(context)
                                  //           //       ?.copyWith(
                                  //           //     color: Colors.grey,
                                  //           //     fontWeight: FontWeight.w500,
                                  //           //     fontSize: 10.sp,
                                  //           //   ),
                                  //           //   maxLines: 1,
                                  //           // ),
                                  //           // const SizedBox(
                                  //           //   height: 7,
                                  //           // ),
                                  //           // Row(
                                  //           //   mainAxisAlignment:
                                  //           //       MainAxisAlignment.start,
                                  //           //   children: [
                                  //           //     const Icon(
                                  //           //       Icons.remove_red_eye,
                                  //           //       color: Colors.blue,
                                  //           //     ),
                                  //           //     SB_1W,
                                  //           //     Text(
                                  //           //       widget.data.userViews
                                  //           //           .toString(),
                                  //           //       style: hintTextStyle(context)
                                  //           //           ?.copyWith(
                                  //           //         color: Colors.black,
                                  //           //         fontWeight: FontWeight.w500,
                                  //           //         fontSize: 10.sp,
                                  //           //       ),
                                  //           //       maxLines: 2,
                                  //           //     ),
                                  //           //   ],
                                  //           // )
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )),
      );
    });
  }
}

void showDeleteConfirmationDialog(
    BuildContext context, bool showReasonMessageBox, Function onClick) {
  var deletionReason = "";
  navigatorKey.currentState?.push(
    SlideUpTransparentRoute(
      enterWidget: CustomAlertDialog(
        contentWidget: RewardPopUp(
          iconPath: 'assets/images/ic_dialog_delete.png',
          subContent: Padding(
            padding: const EdgeInsets.all(16.0),
            child: (showReasonMessageBox)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Reason",
                          style: labelTextStyle(context)?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize.screenHeight * .01,
                      ),
                      TextField(
                        maxLines: 3,
                        minLines: 3,
                        onChanged: (text) {
                          deletionReason = text;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: PRIMARY_COLOR, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: RED_COLOR, width: 1.0),
                          ),
                          hintText: 'Reason for deletion',
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
          title: AppLocalisation.getTranslated(context, LKDelete),
          content: "Do you want to delete this workout?",
          actionButtons: Row(
            children: [
              SizedBox(
                width: defaultSize.screenWidth * .37,
                child: SalukGradientButton(
                  title: AppLocalisation.getTranslated(context, LKYes),
                  onPressed: () async {
                    onClick.call(deletionReason);
                    Navigator.pop(context);
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
                    Navigator.pop(context);
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
  );
}
