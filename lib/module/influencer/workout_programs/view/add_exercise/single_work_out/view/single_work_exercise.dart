import 'dart:convert';
import 'dart:io';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/widgets/video_container.dart';
import 'package:app/module/influencer/workout_programs/model/AddExerciseFailureRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/AddExerciseSingleWTimeRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_custom_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_reps_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_single_workout_tResponse.dart';
import 'package:app/module/influencer/workout_programs/model/workout_sets_request_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/single_work_out/bloc/single_work_exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/widgets/add_workout_sets_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/exercise_duration_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_sets_tile.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../repo/repository/web_service.dart';
import '../../../../../more/widget/custom_alert_dialog.dart';
import '../../../../../widgets/media_upload_progress_popup.dart';

class SingleWorkOutExerciseScreen extends StatefulWidget {
  final bool? isEditScreen;
  final String? title;
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  final data;

  const SingleWorkOutExerciseScreen({
    Key? key,
    this.title,
    this.isEditScreen = false,
    this.weekID,
    this.workoutID,
    required this.data,
    this.dayID,
  }) : super(key: key);

  @override
  State<SingleWorkOutExerciseScreen> createState() =>
      _SingleWorkOutExerciseScreenState();
}

class _SingleWorkOutExerciseScreenState
    extends State<SingleWorkOutExerciseScreen> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();
  String singleWRestDuration = '';
  String singleWRestDurationMin = '';
  String singleWExerciseDuration = '';
  String singleWExerciseDurationMin = '';
  String workoutSetsType = '';
  String workoutSetsValue = '';
  String exerciseTypeCustom = '';
  int workoutSetsNumber = 1;
  List<File> _createPostImageFiles = [];
  List<WorkoutSetsRequestModel> workoutSetsRequestModelList = [];
  List<AddExerciseFailureRequestModel> workoutSetsFailureRequestModelList = [];
  List<AddExerciseRepsRequestModel> addExerciseRepsRequestModelList = [];
  List<AddExerciseCustomRequestModel> addExerciseCustomRequestModelList = [];
  AddExerciseSingleWTimeRequestModel? addExerciseSingleWTimeRequestModel;
  AddExerciseSingleWorkoutTResponse? addExerciseSingleWorkoutTResponse;

  String tempType = '';
  String? path;
  String? netImage;
  late SingleWorkOutCubit _singleWorkOutCubit = SingleWorkOutCubit();

  initSingleWorkoutExercise() async {
    if (widget.data != null && widget.isEditScreen == true) {
      solukLog(logMsg: "inside initSingleWorkoutExercise");
      solukLog(logMsg: widget.dayID);
      if (widget.data.sets[0].type == "Reps") {
        addExerciseRepsRequestModelList.clear();
        for (int i = 0; i < widget.data.sets.length; i++) {
          addExerciseRepsRequestModelList.add(AddExerciseRepsRequestModel(
              type: widget.data.sets[i].type,
              title: '${widget.data.sets[i].title}',
              noOfReps: "${json.decode(widget.data.sets[i].meta)["noOfReps"]}",
              dropSet:
                  json.decode(widget.data.sets[i].meta)["dropSet"] ?? false));
        }
        workoutSetsNumber = widget.data.sets.length;
        workoutSetsType = widget.data.sets[0].type;
      } else if (widget.data.sets != null &&
          widget.data.sets[0].type == "Time") {
        addExerciseRepsRequestModelList.clear();
        for (int i = 0; i < widget.data.sets.length; i++) {
          workoutSetsRequestModelList.add(WorkoutSetsRequestModel(
              type: widget.data.sets[i].type,
              title: '${widget.data.sets[i].title}',
              setTimeMins: solukFormatTime(
                  json.decode(widget.data.sets[i].meta)["setTime"])["type"],
              setTime:
                  "${solukFormatTime(json.decode(widget.data.sets[i].meta)["setTime"])['time']}"));
        }
        workoutSetsNumber = widget.data.sets.length;
        workoutSetsType = widget.data.sets[0].type;
      } else if (widget.data.sets != null &&
          widget.data.sets[0].type == "Failure") {
        addExerciseRepsRequestModelList.clear();
        for (int i = 0; i < widget.data.sets.length; i++) {
          workoutSetsFailureRequestModelList.add(AddExerciseFailureRequestModel(
              type: widget.data.sets[i].type,
              title: '${widget.data.sets[i].title}'));
        }
        workoutSetsNumber = widget.data.sets.length;
        workoutSetsType = widget.data.sets[0].type;
      } else if (widget.data.sets != null &&
          widget.data.sets[0].type == "Custom") {
        addExerciseRepsRequestModelList.clear();
        for (int i = 0; i < widget.data.sets.length; i++) {
          addExerciseCustomRequestModelList.add(AddExerciseCustomRequestModel(
              type: widget.data.sets[i].type,
              title: '${widget.data.sets[i].title}',
              exerciseType:
                  "${json.decode(widget.data.sets[i].meta)["exerciseType"]}",
              count: int.parse(
                  "${json.decode(widget.data.sets[i].meta)["count"]}")));
        }
        exerciseTypeCustom =
            json.decode(widget.data.sets[0].meta)["exerciseType"];
        workoutSetsNumber = widget.data.sets.length;
        workoutSetsType = widget.data.sets[0].type;
      }
      _titleController.text = widget.data!.title;
      _descriptionController.text = widget.data!.instructions;
      netImage = widget.data!.assetUrl;
      // assetType = widget.data!.assetType;

      singleWExerciseDuration =
          solukFormatTime(widget.data!.exerciseTime)["time"]!;
      singleWExerciseDurationMin =
          solukFormatTime(widget.data!.exerciseTime)["type"]!;
      singleWRestDuration = solukFormatTime(widget.data!.restTime)["time"]!;
      singleWRestDurationMin = solukFormatTime(widget.data!.restTime)["type"]!;
      setState(() {});
    } else {
      solukLog(logMsg: "no data found");
    }
  }

  @override
  void initState() {
    super.initState();
    initSingleWorkoutExercise();
  }

  @override
  Widget build(BuildContext context) {
    _singleWorkOutCubit = BlocProvider.of<SingleWorkOutCubit>(context);

    return Scaffold(
      body: AppBody(
          title: widget.title!,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalisation.getTranslated(context, LKWorkoutType),
                  style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: choiceChipWidget(context,
                      title: "Single Workout",
                      isIncomeSelected: true,
                      onSelected: (val) {}),
                ),
                const SizedBox(
                  height: 20,
                ),
                SalukTextField(
                  textEditingController: _titleController,
                  hintText: "",
                  labelText:
                      AppLocalisation.getTranslated(context, LKExerciseName),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   children: [
                //     Text(
                //       AppLocalisation.getTranslated(context, LKExerciseTime),
                //       style: subTitleTextStyle(context)?.copyWith(
                //         color: Colors.black,
                //         fontSize: 14.sp,
                //       ),
                //     ),
                //     Text(
                //       "  (${AppLocalisation.getTranslated(context, LKOptional)})",
                //       style: labelTextStyle(context)?.copyWith(
                //         color: Colors.grey,
                //         fontSize: 12.sp,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // if (singleWExerciseDuration.isEmpty)
                //   SalukTransparentButton(
                //     title:
                //         AppLocalisation.getTranslated(context, LKExerciseTime),
                //     buttonWidth: defaultSize.screenWidth,
                //     textColor: PRIMARY_COLOR,
                //     borderColor: PRIMARY_COLOR,
                //     onPressed: () {
                //       ("--inside SingleWorkout Exercise Time--");
                //       showDialog(
                //           context: context,
                //           builder: (BuildContext context) {
                //             return ExerciseDurationDialog(
                //               heading: AppLocalisation.getTranslated(
                //                   context, LKAddExerciseTime),
                //               onChanged: (value) {
                //                 singleWExerciseDuration = value;
                //                 setState(() {});
                //                 // _workoutProgramBloc.add(SetStateEvent());
                //               },
                //               onChanged2: (String value) {
                //                 singleWExerciseDurationMin = value;
                //                 setState(() {});
                //                 // _workoutProgramBloc.add(SetStateEvent());
                //               },
                //             );
                //           });
                //     },
                //     buttonHeight: HEIGHT_4,
                //     style: labelTextStyle(context)?.copyWith(
                //       fontSize: 14.sp,
                //       color: PRIMARY_COLOR,
                //     ),
                //     icon: const Icon(
                //       Icons.add_circle,
                //       color: PRIMARY_COLOR,
                //     ),
                //     borderRadius: BorderRadius.circular(
                //       10,
                //     ),
                //   )
                // else
                //   Row(
                //     children: [
                //       Text(
                //         singleWExerciseDuration +
                //             ' ' +
                //             singleWExerciseDurationMin,
                //         style: labelTextStyle(context)?.copyWith(
                //           color: Colors.black,
                //           fontSize: 14.sp,
                //         ),
                //       ),
                //       SB_1W,
                //       InkWell(
                //         onTap: () {
                //           showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return ExerciseDurationDialog(
                //                   minutes: singleWExerciseDuration,
                //                   heading: AppLocalisation.getTranslated(
                //                       context, LKAddExerciseTime),
                //                   onChanged: (value) {
                //                     singleWExerciseDuration = value;
                //                     setState(() {});
                //                     // _workoutProgramBloc.add(SetStateEvent());
                //                   },
                //                   onChanged2: (String value) {
                //                     singleWExerciseDurationMin = value;
                //                     setState(() {});
                //                     // _workoutProgramBloc.add(SetStateEvent());
                //                   },
                //                 );
                //               });
                //         },
                //         child: const Icon(
                //           Icons.edit,
                //           color: PRIMARY_COLOR,
                //         ),
                //       ),
                //       SB_1W,
                //       InkWell(
                //         onTap: () {
                //           singleWExerciseDuration = '';
                //           setState(() {});
                //         },
                //         child: const Icon(
                //           Icons.delete,
                //           color: Colors.red,
                //         ),
                //       ),
                //     ],
                //   ),
                const SizedBox(
                  height: 20,
                ),
                if (netImage != null && netImage != "")
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      !netImage!.contains("mp4")
                          ? ImageContainer(
                              isCloseShown: true,
                              path: netImage!,
                              onClose: () => setState(() => netImage = null),
                            )
                          : VideoContainer(
                              isCloseShown: true,
                              netUrl: netImage,
                              closeButton: () {
                                setState(() {
                                  netImage = null;
                                });
                              },
                            ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: InkWell(
                      //     onTap: () {
                      //       //Navigator.pop(context);

                      //       setState(() {
                      //         netImage = null;
                      //       });
                      //       // _singleWorkOutCubit
                      //       //     .add(SetStateEvent());
                      //     },
                      //     child: Container(
                      //       width: 20,
                      //       height: 20,
                      //       child: SvgPicture.asset(
                      //           'assets/svgs/cross_icon.svg',
                      //           height: 25,
                      //           width: 25),
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Colors.grey.withOpacity(0.1),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  )
                else
                  _createPostImageFiles.isEmpty
                      ? MediaTypeSelectionCard(
                          callback: () {
                            popUpAlertDialog(
                              context,
                              'Pick Image',
                              LKImageDialogDetail,
                              isProfile: true,
                              onCameraTap: (mediaType) {
                                _pickImage(Pickers.instance.sourceCamera,
                                    mediaType: mediaType);
                              },
                              onGalleryTap: () {
                                _pickImagesFromGallery();
                              },
                            );
                          },
                        )
                      : Stack(
                          alignment: Alignment.topRight,
                          children: [
                            _createPostImageFiles[0].path.contains("mp4")
                                ? VideoContainer(
                                    isCloseShown: true,
                                    file: _createPostImageFiles[0],
                                    closeButton: () {
                                      setState(() {
                                        _createPostImageFiles = [];
                                      });
                                    },
                                  )
                                : ImageContainer(
                                    isCloseShown: true,
                                    path: _createPostImageFiles[0].path,
                                    onClose: () => setState(
                                        () => _createPostImageFiles = []),
                                  ),
                            // Padding(
                            //   padding: const EdgeInsets.all(10.0),
                            //   child: InkWell(
                            //     onTap: () {
                            //       //Navigator.pop(context);

                            //       setState(() {
                            //         _createPostImageFiles.clear();
                            //       });
                            //       // _singleWorkOutCubit
                            //       //     .add(SetStateEvent());
                            //     },
                            //     child: Container(
                            //       width: 20,
                            //       height: 20,
                            //       child: SvgPicture.asset(
                            //           'assets/svgs/cross_icon.svg',
                            //           height: 25,
                            //           width: 25),
                            //       decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         color: Colors.grey.withOpacity(0.1),
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                const SizedBox(
                  height: 20,
                ),
                SalukTextField(
                    textEditingController: _descriptionController,
                    maxLines: 6,
                    hintText: "",
                    labelText: AppLocalisation.getTranslated(
                        context, LKTypeInstructions)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalisation.getTranslated(context, LKWorkoutSets),
                      style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    workoutSetsType != ''
                        ? SalukTransparentButton(
                            title: AppLocalisation.getTranslated(
                                context, LKAddSet),
                            buttonWidth: WIDTH_5 * 4,
                            borderColor: PRIMARY_COLOR,
                            textColor: PRIMARY_COLOR,
                            onPressed: () {
                              if (workoutSetsType == "Temp") {
                                // var cancleToast = BotToast.showText(
                                //   text: AppLocalisation.getTranslated(
                                //       context, LKAddBriefIntro),
                                // );
                                // cancleToast;
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddWorkoutSetsDialog(
                                          selectedType: workoutSetsType,
                                          dropSet: false,
                                          typeReadonly: true,
                                          customSetName: exerciseTypeCustom,
                                          onChanged: (value) {
                                            workoutSetsType = value;
                                            workoutSetsNumber++;
                                            setState(() {});
                                          },
                                          onChanged1: (value) {
                                            tempType = value;
                                            setState(() {});
                                          },
                                          onChanged2: (value) {
                                            workoutSetsValue = value;
                                            print(workoutSetsValue);
                                            if (workoutSetsType == 'Time') {
                                              workoutSetsRequestModelList.add(
                                                  WorkoutSetsRequestModel(
                                                      setTimeMins: tempType,
                                                      type: workoutSetsType,
                                                      title:
                                                          'Set $workoutSetsNumber',
                                                      setTime: workoutSetsValue
                                                      //workoutSetsValue
                                                      ));
                                              setState(() {});
                                            } else if (workoutSetsType ==
                                                'Failure') {
                                              workoutSetsFailureRequestModelList.add(
                                                  AddExerciseFailureRequestModel(
                                                      type: workoutSetsType,
                                                      title:
                                                          'Set $workoutSetsNumber'));
                                            }
                                          },
                                          onChanged3: (value) {
                                            if (workoutSetsType == 'Custom') {
                                              exerciseTypeCustom = value;
                                              addExerciseCustomRequestModelList.add(
                                                  AddExerciseCustomRequestModel(
                                                type: workoutSetsType,
                                                title: 'Set $workoutSetsNumber',
                                                exerciseType:
                                                    exerciseTypeCustom,
                                                count:
                                                    int.parse(workoutSetsValue),
                                              ));
                                              setState(() {});
                                            } else if (workoutSetsType ==
                                                'Reps') {
                                              addExerciseRepsRequestModelList.add(
                                                  AddExerciseRepsRequestModel(
                                                      type: workoutSetsType,
                                                      title:
                                                          'Set $workoutSetsNumber',
                                                      noOfReps:
                                                          workoutSetsValue,
                                                      dropSet: value == 'Y'
                                                          ? true
                                                          : false));
                                              setState(() {});
                                            }
                                          });
                                    });
                              }
                            },
                            buttonHeight: HEIGHT_2,
                            style: labelTextStyle(context)?.copyWith(
                              fontSize: 12.sp,
                              color: PRIMARY_COLOR,
                            ),
                            icon: const Icon(
                              Icons.add_circle,
                              color: PRIMARY_COLOR,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          )
                        : const SizedBox(
                            width: 5,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                workoutSetsType != ''
                    ? Container(
                        width: double.maxFinite,
                        // height: HEIGHT_5 * 2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          //color: Colors.grey.withOpacity(0.2),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: [
                            WorkoutSetsTile(
                              titleColor: Colors.grey,
                              titleDetailColor: Colors.grey,
                              title: AppLocalisation.getTranslated(
                                  context, LKNoOfSets),
                              titleDetail: AppLocalisation.getTranslated(
                                  context, LKSetType),
                              onEditPress: () {},
                              onDeletePress: () {},
                              showIcon: false,
                              showEditIcon: false,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: workoutSetsType == 'Time'
                                  ? workoutSetsRequestModelList.length
                                  : workoutSetsType == 'Failure'
                                      ? workoutSetsFailureRequestModelList
                                          .length
                                      : workoutSetsType == 'Reps'
                                          ? addExerciseRepsRequestModelList
                                              .length
                                          : addExerciseCustomRequestModelList
                                              .length,
                              itemBuilder: (BuildContext context, int _i) {
                                // if (widget.data != null) {
                                //   if (isUpdatedState) {
                                //     isUpdatedState = true;
                                //     solukLog(logMsg: "sdfksdlfksdksdkj");
                                //     setState(() {});
                                //   }
                                // }
                                return WorkoutSetsTile(
                                  titleColor: Colors.black,
                                  index: 0,
                                  titleDetailColor: workoutSetsType == 'Reps'
                                      ? addExerciseRepsRequestModelList[_i]
                                                  .dropSet ==
                                              true
                                          ? PRIMARY_COLOR
                                          : Colors.black
                                      : Colors.black,
                                  title: workoutSetsType == 'Time'
                                      ? workoutSetsRequestModelList[_i].title
                                      // ? "Set ${_i + 1}"
                                      : workoutSetsType == 'Failure'
                                          ? workoutSetsFailureRequestModelList[
                                                  _i]
                                              .title
                                          : workoutSetsType == 'Reps'
                                              ? addExerciseRepsRequestModelList[
                                                      _i]
                                                  .title
                                              : addExerciseCustomRequestModelList[
                                                      _i]
                                                  .title,
                                  titleDetail: workoutSetsType == 'Time'
                                      // ? '      ' +
                                      ? '${workoutSetsRequestModelList[_i].setTime} ${workoutSetsRequestModelList[_i].setTimeMins!}'
                                      : workoutSetsType == 'Failure'
                                          ? workoutSetsFailureRequestModelList[
                                                  _i]
                                              .type
                                          : workoutSetsType == 'Reps'
                                              // ? '         ' +
                                              ? '${addExerciseRepsRequestModelList[_i].noOfReps} ${addExerciseRepsRequestModelList[_i].type}'
                                              // : '         ' +
                                              : '${addExerciseCustomRequestModelList[_i].count.toString().replaceAll(RegExp(r"\s+"), "")} ${addExerciseCustomRequestModelList[_i].exerciseType.replaceAll(RegExp(r"\s+"), "")}',
                                  onEditPress: () {
                                    print(
                                        "--- inside the EditButton for Workout set --- $_i");
                                    // workoutSetsType == 'Time'
                                    // print(workoutSetsRequestModelList[_i].setTime);
                                    // print(workoutSetsRequestModelList[_i].setTimeMins);
                                    if (_i == 0) {
                                      print("--- is first Workout set ---");
                                      print(
                                          "--- workout type $workoutSetsType");
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AddWorkoutSetsDialog(
                                                selectedType: workoutSetsType,
                                                selectedTime:
                                                    workoutSetsRequestModelList
                                                            .isNotEmpty
                                                        ? workoutSetsRequestModelList[
                                                                _i]
                                                            .setTime
                                                        : "00:00",
                                                selectedNoOfReps:
                                                    addExerciseRepsRequestModelList
                                                            .isNotEmpty
                                                        ? addExerciseRepsRequestModelList[
                                                                _i]
                                                            .noOfReps
                                                        : "",
                                                dropSet:
                                                    addExerciseRepsRequestModelList
                                                            .isNotEmpty
                                                        ? addExerciseRepsRequestModelList[
                                                                _i]
                                                            .dropSet
                                                        : false,
                                                customSetName:
                                                    addExerciseCustomRequestModelList
                                                            .isNotEmpty
                                                        ? addExerciseCustomRequestModelList[
                                                                _i]
                                                            .exerciseType
                                                        : "",
                                                customSetCount:
                                                    addExerciseCustomRequestModelList
                                                            .isNotEmpty
                                                        ? addExerciseCustomRequestModelList[
                                                                _i]
                                                            .count
                                                            .toString()
                                                        : "",
                                                typeReadonly: false,
                                                onChanged: (value) {
                                                  workoutSetsType = value;
                                                  setState(() {});
                                                },
                                                onChanged1: (value) {
                                                  tempType = value;
                                                  // setState(() {});
                                                },
                                                onChanged2: (value) {
                                                  workoutSetsValue = value;

                                                  // addExerciseCustomRequestModelList
                                                  //     .clear();

                                                  workoutSetsRequestModelList
                                                      .clear();
                                                  addExerciseRepsRequestModelList
                                                      .clear();
                                                  workoutSetsFailureRequestModelList
                                                      .clear();
                                                  addExerciseCustomRequestModelList
                                                      .clear();

                                                  if (workoutSetsType ==
                                                      'Time') {
                                                    for (int i = 0;
                                                        i < workoutSetsNumber;
                                                        i++) {
                                                      print("=-=-=-=-=-=-=-=");

                                                      workoutSetsRequestModelList.add(
                                                          WorkoutSetsRequestModel(
                                                              setTimeMins:
                                                                  tempType,
                                                              type:
                                                                  workoutSetsType,
                                                              title:
                                                                  'Set ${i + 1}',
                                                              setTime:
                                                                  workoutSetsValue
                                                              //workoutSetsValue
                                                              ));
                                                    }
                                                  }

                                                  // else if (workoutSetsType ==
                                                  //     'Reps') {
                                                  //   for (int i = 0;
                                                  //       i < workoutSetsNumber;
                                                  //       i++) {
                                                  //     print("=-=-=-=-=-=-=-=");

                                                  //     addExerciseRepsRequestModelList.add(
                                                  //         AddExerciseRepsRequestModel(
                                                  //             type:
                                                  //                 workoutSetsType,
                                                  //             title:
                                                  //                 'Set ${i + 1}',
                                                  //             noOfReps:
                                                  //                 workoutSetsValue,
                                                  //             dropSet: false));
                                                  //   }
                                                  // }

                                                  else if (workoutSetsType ==
                                                      'Failure') {
                                                    for (int i = 0;
                                                        i < workoutSetsNumber;
                                                        i++) {
                                                      print("=-=-=-=-=-=-=-=");
                                                      workoutSetsFailureRequestModelList.add(
                                                          AddExerciseFailureRequestModel(
                                                              type:
                                                                  workoutSetsType,
                                                              title:
                                                                  'Set ${i + 1}'));
                                                    }
                                                  }

                                                  // else if (workoutSetsType ==
                                                  //     'Custom') {
                                                  //   for (int i = 0;
                                                  //       i < workoutSetsNumber;
                                                  //       i++) {
                                                  //     print("=-=-=-=-=-=-=-=");
                                                  //     exerciseTypeCustom =
                                                  //         value;
                                                  //     addExerciseCustomRequestModelList
                                                  //         .add(
                                                  //             AddExerciseCustomRequestModel(
                                                  //       type: workoutSetsType,
                                                  //       title: 'Set ${i + 1}',
                                                  //       exerciseType:
                                                  //           exerciseTypeCustom,
                                                  //       count: int.parse(
                                                  //           workoutSetsValue),
                                                  //     ));
                                                  //   }
                                                  // }
                                                  // } else if (workoutSetsType ==
                                                  //     'Failure') {
                                                  //   for (int i = 0;
                                                  //       i <
                                                  //           workoutSetsFailureRequestModelList
                                                  //               .length;
                                                  //       i++) {
                                                  //     workoutSetsFailureRequestModelList[
                                                  //                 i]
                                                  //             .type =
                                                  //         workoutSetsType;
                                                  //   }
                                                  // } else if (workoutSetsType ==
                                                  //     'Reps') {
                                                  //   for (int i = 0;
                                                  //       i <
                                                  //           addExerciseRepsRequestModelList
                                                  //               .length;
                                                  //       i++) {
                                                  //     addExerciseRepsRequestModelList[
                                                  //                 i]
                                                  //             .type =
                                                  //         workoutSetsType;
                                                  //   }
                                                  // }
                                                  setState(() {});
                                                  // _workoutProgramBloc.add(
                                                  //     SetStateEvent());
                                                },
                                                onChanged3: (value) {
                                                  exerciseTypeCustom = value;

                                                  print(
                                                      "--- inside changed workoutSetType ---");

                                                  if (workoutSetsType ==
                                                      "Reps") {
                                                    for (int i = 0;
                                                        i < workoutSetsNumber;
                                                        i++) {
                                                      print("=-=-=-=-=-=-=-=");

                                                      addExerciseRepsRequestModelList.add(
                                                          AddExerciseRepsRequestModel(
                                                              type:
                                                                  workoutSetsType,
                                                              title:
                                                                  'Set ${i + 1}',
                                                              noOfReps:
                                                                  workoutSetsValue,
                                                              dropSet:
                                                                  value == "Y"
                                                                      ? true
                                                                      : false));
                                                    }
                                                  } else if (workoutSetsType ==
                                                      'Custom') {
                                                    for (int i = 0;
                                                        i < workoutSetsNumber;
                                                        i++) {
                                                      print("=-=-=-=-=-=-=-=");
                                                      exerciseTypeCustom =
                                                          value;
                                                      addExerciseCustomRequestModelList
                                                          .add(
                                                              AddExerciseCustomRequestModel(
                                                        type: workoutSetsType,
                                                        title: 'Set ${i + 1}',
                                                        exerciseType:
                                                            exerciseTypeCustom,
                                                        count: int.parse(
                                                            workoutSetsValue),
                                                      ));
                                                    }
                                                  }
                                                  // _workoutProgramBloc.add(
                                                  //     SetStateEvent());
                                                  setState(() {});
                                                });
                                          });
                                    } else {
                                      print("--- not first Workout set ---");
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AddWorkoutSetsDialog(
                                                selectedType: workoutSetsType,
                                                selectedTime:
                                                    workoutSetsRequestModelList
                                                            .isNotEmpty
                                                        ? workoutSetsRequestModelList[
                                                                _i]
                                                            .setTime
                                                        : "00:00",
                                                selectedNoOfReps:
                                                    addExerciseRepsRequestModelList
                                                            .isNotEmpty
                                                        ? addExerciseRepsRequestModelList[
                                                                _i]
                                                            .noOfReps
                                                        : "",
                                                dropSet:
                                                    addExerciseRepsRequestModelList
                                                            .isNotEmpty
                                                        ? addExerciseRepsRequestModelList[
                                                                _i]
                                                            .dropSet
                                                        : false,
                                                customSetName:
                                                    addExerciseCustomRequestModelList
                                                            .isNotEmpty
                                                        ? addExerciseCustomRequestModelList[
                                                                _i]
                                                            .exerciseType
                                                        : "",
                                                customSetCount:
                                                    addExerciseCustomRequestModelList
                                                            .isNotEmpty
                                                        ? addExerciseCustomRequestModelList[
                                                                _i]
                                                            .count
                                                            .toString()
                                                        : "",
                                                typeReadonly: true,
                                                onChanged: (value) {
                                                  workoutSetsType = value;
                                                  setState(() {});
                                                },
                                                onChanged1: (value) {
                                                  tempType = value;
                                                  setState(() {});
                                                },
                                                onChanged2: (value) {
                                                  workoutSetsValue = value;
                                                  print(workoutSetsValue);
                                                  if (workoutSetsType ==
                                                      'Time') {
                                                    workoutSetsRequestModelList[
                                                            _i] =
                                                        WorkoutSetsRequestModel(
                                                            setTimeMins:
                                                                tempType,
                                                            type:
                                                                workoutSetsType,
                                                            title:
                                                                'Set $workoutSetsNumber',
                                                            setTime:
                                                                workoutSetsValue);
                                                    setState(() {});
                                                  } else if (workoutSetsType ==
                                                      'Failure') {
                                                    workoutSetsFailureRequestModelList[
                                                            _i] =
                                                        AddExerciseFailureRequestModel(
                                                            type:
                                                                workoutSetsType,
                                                            title:
                                                                'Set $workoutSetsNumber');
                                                  }
                                                },
                                                onChanged3: (value) {
                                                  if (workoutSetsType ==
                                                      'Custom') {
                                                    exerciseTypeCustom = value;
                                                    addExerciseCustomRequestModelList[
                                                            _i] =
                                                        (AddExerciseCustomRequestModel(
                                                      type: workoutSetsType,
                                                      title:
                                                          'Set $workoutSetsNumber',
                                                      exerciseType:
                                                          exerciseTypeCustom,
                                                      count: int.parse(
                                                          workoutSetsValue),
                                                    ));
                                                    setState(() {});
                                                  } else if (workoutSetsType ==
                                                      'Reps') {
                                                    addExerciseRepsRequestModelList[
                                                            _i] =
                                                        AddExerciseRepsRequestModel(
                                                            type:
                                                                workoutSetsType,
                                                            title:
                                                                'Set $workoutSetsNumber',
                                                            noOfReps:
                                                                workoutSetsValue,
                                                            dropSet:
                                                                value == 'Y'
                                                                    ? true
                                                                    : false);
                                                    setState(() {});
                                                  }
                                                });
                                          });
                                    }
                                  },
                                  onDeletePress: () {
                                    if (workoutSetsType == 'Time') {
                                      workoutSetsRequestModelList.remove(
                                          workoutSetsRequestModelList[_i]);
                                      // workoutSetsNumber = _i;

                                      workoutSetsNumber--;
                                      for (int i = 0;
                                          i < workoutSetsNumber;
                                          i++) {
                                        print("$i =-=-=-=-=-");
                                        // workoutSetsRequestModelList[i].title =
                                        //     "Set ${i + 1}";
                                        workoutSetsRequestModelList[i] =
                                            WorkoutSetsRequestModel(
                                                setTimeMins:
                                                    workoutSetsRequestModelList[
                                                            i]
                                                        .setTimeMins,
                                                type:
                                                    workoutSetsRequestModelList[
                                                            i]
                                                        .type,
                                                title: 'Set ${i + 1}',
                                                setTime:
                                                    workoutSetsRequestModelList[
                                                            i]
                                                        .setTime);
                                      }
                                    } else if (workoutSetsType == 'Failure') {
                                      workoutSetsFailureRequestModelList.remove(
                                          workoutSetsFailureRequestModelList[
                                              _i]);
                                      // workoutSetsNumber = _i;
                                      workoutSetsNumber--;
                                      for (int i = 0;
                                          i < workoutSetsNumber;
                                          i++) {
                                        // workoutSetsFailureRequestModelList[i]
                                        //     .title = "Set ${i + 1}";
                                        workoutSetsFailureRequestModelList[i] =
                                            AddExerciseFailureRequestModel(
                                                type:
                                                    workoutSetsFailureRequestModelList[
                                                            i]
                                                        .type,
                                                title: 'Set ${i + 1}');
                                      }
                                    } else if (workoutSetsType == 'Reps') {
                                      addExerciseRepsRequestModelList.remove(
                                          addExerciseRepsRequestModelList[_i]);
                                      // print("index : $_i");
                                      // workoutSetsNumber = _i;
                                      workoutSetsNumber--;
                                      for (int i = 0;
                                          i < workoutSetsNumber;
                                          i++) {
                                        // addExerciseRepsRequestModelList[i]
                                        //     .title = "Set ${i + 1}";
                                        addExerciseRepsRequestModelList[i] =
                                            AddExerciseRepsRequestModel(
                                                type:
                                                    addExerciseRepsRequestModelList[
                                                            i]
                                                        .type,
                                                title: 'Set ${i + 1}',
                                                noOfReps:
                                                    addExerciseRepsRequestModelList[
                                                            i]
                                                        .noOfReps,
                                                dropSet:
                                                    addExerciseRepsRequestModelList[
                                                            i]
                                                        .dropSet);
                                      }
                                    } else if (workoutSetsType == 'Custom') {
                                      addExerciseCustomRequestModelList.remove(
                                          addExerciseCustomRequestModelList[
                                              _i]);
                                      // workoutSetsNumber = _i;
                                      workoutSetsNumber--;
                                      for (int i = 0;
                                          i < workoutSetsNumber;
                                          i++) {
                                        // addExerciseCustomRequestModelList[i]
                                        //     .title = "Set ${i + 1}";
                                        addExerciseCustomRequestModelList[i] =
                                            (AddExerciseCustomRequestModel(
                                          type:
                                              addExerciseCustomRequestModelList[
                                                      i]
                                                  .title,
                                          title: 'Set ${i + 1}',
                                          exerciseType:
                                              addExerciseCustomRequestModelList[
                                                      i]
                                                  .exerciseType,
                                          count:
                                              addExerciseCustomRequestModelList[
                                                      i]
                                                  .count,
                                        ));
                                      }
                                    }
                                    if (workoutSetsRequestModelList.isEmpty &&
                                        workoutSetsType == 'Time') {
                                      workoutSetsType = '';
                                      workoutSetsNumber = 1;
                                    }
                                    if (workoutSetsFailureRequestModelList
                                            .isEmpty &&
                                        workoutSetsType == 'Failure') {
                                      workoutSetsType = '';
                                      workoutSetsNumber = 1;
                                    }
                                    if (addExerciseRepsRequestModelList
                                            .isEmpty &&
                                        workoutSetsType == 'Reps') {
                                      workoutSetsType = '';
                                      workoutSetsNumber = 1;
                                    }
                                    if (addExerciseCustomRequestModelList
                                            .isEmpty &&
                                        workoutSetsType == 'Custom') {
                                      workoutSetsType = '';
                                      workoutSetsNumber = 1;
                                    }
                                    setState(() {});
                                    // _workoutProgramBloc.add(SetStateEvent());
                                  },
                                  onAddPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddWorkoutSetsDialog(
                                              selectedType: workoutSetsType,
                                              dropSet: false,
                                              typeReadonly: false,
                                              onChanged: (value) {
                                                workoutSetsType = value;
                                                setState(() {});
                                              },
                                              onChanged1: (value) {
                                                tempType = value;
                                                setState(() {});
                                              },
                                              onChanged2: (value) {
                                                workoutSetsValue = value;
                                                print(
                                                    "value :: $workoutSetsValue");
                                                addExerciseCustomRequestModelList
                                                    .clear();
                                                if (workoutSetsType == 'Time') {
                                                  workoutSetsRequestModelList.add(
                                                      WorkoutSetsRequestModel(
                                                          setTimeMins: tempType,
                                                          type: workoutSetsType,
                                                          title:
                                                              'Set $workoutSetsNumber',
                                                          setTime:
                                                              workoutSetsValue
                                                          //workoutSetsValue
                                                          ));
                                                  setState(() {});
                                                } else if (workoutSetsType ==
                                                    'Failure') {
                                                  workoutSetsFailureRequestModelList.add(
                                                      AddExerciseFailureRequestModel(
                                                          type: workoutSetsType,
                                                          title:
                                                              'Set $workoutSetsNumber'));
                                                  setState(() {});
                                                }
                                                if (workoutSetsType !=
                                                        'Custom' ||
                                                    workoutSetsType != 'Reps') {
                                                  //workoutSetsNumber++;
                                                  setState(() {});
                                                }
                                              },
                                              onChanged3: (value) {
                                                if (workoutSetsType ==
                                                    'Custom') {
                                                  exerciseTypeCustom = value;
                                                  addExerciseCustomRequestModelList
                                                      .add(
                                                          AddExerciseCustomRequestModel(
                                                    type: workoutSetsType,
                                                    title:
                                                        'Set $workoutSetsNumber',
                                                    exerciseType:
                                                        exerciseTypeCustom,
                                                    count: int.parse(
                                                        workoutSetsValue),
                                                  ));
                                                  setState(() {});
                                                } else if (workoutSetsType ==
                                                    'Reps') {
                                                  print(
                                                      "work out number : $workoutSetsNumber");
                                                  addExerciseRepsRequestModelList.add(
                                                      AddExerciseRepsRequestModel(
                                                          type: workoutSetsType,
                                                          title:
                                                              'Set $workoutSetsNumber',
                                                          noOfReps:
                                                              workoutSetsValue,
                                                          dropSet: value == 'Y'
                                                              ? true
                                                              : false));
                                                  setState(() {});
                                                }
                                                if (workoutSetsType ==
                                                        'Custom' ||
                                                    workoutSetsType == 'Reps') {
                                                  //workoutSetsNumber++;
                                                  setState(() {});
                                                }
                                              });
                                        });
                                  },
                                  showIcon:
                                      workoutSetsType == 'Temp' ? true : false,
                                  showEditIcon:
                                      workoutSetsType == 'Temp' ? false : true,
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : SalukTransparentButton(
                        title: AppLocalisation.getTranslated(context, LKAddSet),
                        buttonWidth: defaultSize.screenWidth,
                        borderColor: PRIMARY_COLOR,
                        textColor: PRIMARY_COLOR,
                        onPressed: () {
                          workoutSetsType = 'Temp';
                          addExerciseCustomRequestModelList
                              .add(AddExerciseCustomRequestModel(
                            type: workoutSetsType,
                            title: 'Set $workoutSetsNumber',
                            exerciseType: '',
                            count: 0,
                          ));
                          setState(() {});
                        },
                        buttonHeight: HEIGHT_4,
                        style: labelTextStyle(context)?.copyWith(
                          fontSize: 14.sp,
                          color: PRIMARY_COLOR,
                        ),
                        icon: const Icon(
                          Icons.add_circle,
                          color: PRIMARY_COLOR,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: defaultSize.screenWidth,
                  color: PIN_FIELD_COLOR,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalisation.getTranslated(context, LKExerciseRestTime),
                  style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                singleWRestDuration == ''
                    ? SalukTransparentButton(
                        title: AppLocalisation.getTranslated(
                            context, LKExerciseRestTime),
                        buttonWidth: defaultSize.screenWidth,
                        borderColor: PRIMARY_COLOR,
                        textColor: PRIMARY_COLOR,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ExerciseDurationDialog(
                                  heading: AppLocalisation.getTranslated(
                                      context, LKAddRestTime),
                                  onChanged: (String value) {
                                    singleWRestDuration = value;
                                    setState(() {});
                                  },
                                  onChanged2: (String value) {
                                    singleWRestDurationMin = value;
                                    setState(() {});
                                  },
                                );
                              });
                        },
                        buttonHeight: HEIGHT_4,
                        style: labelTextStyle(context)?.copyWith(
                          fontSize: 14.sp,
                          color: PRIMARY_COLOR,
                        ),
                        icon: const Icon(
                          Icons.add_circle,
                          color: PRIMARY_COLOR,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )
                    : Row(
                        children: [
                          Text(
                            '$singleWRestDuration $singleWRestDurationMin',
                            style: labelTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          SB_1W,
                          InkWell(
                            onTap: () {
                              print('sssddff');
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ExerciseDurationDialog(
                                      minutes: singleWRestDuration,
                                      heading: AppLocalisation.getTranslated(
                                          context, LKAddRestTime),
                                      onChanged: (String value) {
                                        singleWRestDuration = value;
                                        setState(() {});
                                      },
                                      onChanged2: (String value) {
                                        singleWRestDurationMin = value;
                                        setState(() {});
                                      },
                                    );
                                  });
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.edit,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 30,
                ),
                SalukGradientButton(
                  title: AppLocalisation.getTranslated(context, LKSubmit),
                  onPressed: () async {
                    addSingleWorkOutExercise(workoutSetsType);
                  },
                  buttonHeight: HEIGHT_4,
                  dim: false,
                )
              ],
            ),
          )),
    );
  }

  _pickImage(String source,
      {CameraMediaType mediaType = CameraMediaType.IMAGE}) async {
    Pickers.instance
        .pickImage(source: source, mediaType: mediaType)
        .then((path) {
      if (path != null) {
        setState(() {
          _createPostImageFiles.add(File(path));
        });
      }
    });

    // path = await Pickers.instance.pickImage(source: source);
    // print("image path :$path");
    // if (path != null) {
    //   setState(() {
    //     _createPostImageFiles.add(File(path!));
    //   });
    // }
  }

  _pickImagesFromGallery() async {
    Pickers.instance.pickFromGallery().then((path) {
      if (path != null) {
        setState(() {
          _createPostImageFiles = path;
        });
      }
    });
  }

  addSingleWorkOutExercise(String workoutType) {
    if (_titleController.text != "") {
      if (true) {
        if (_createPostImageFiles.isNotEmpty || netImage != null) {
          if (_descriptionController.text != '') {
            if (singleWRestDuration != '') {
              // if (_createPostImageFiles.isNotEmpty || widget.data != null) {}

              callApi(workoutType);
            } else {
              showSnackBar(
                context,
                'Please add exercise rest time',
                backgroundColor: Colors.black,
                textColor: Colors.white,
              );
            }
          } else {
            showSnackBar(
              context,
              'Please enter exercise instructions',
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
          }
        } else {
          showSnackBar(
            context,
            'Please add image or video',
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }
      } else {
        showSnackBar(
          context,
          'Please enter a exercise duration',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    } else {
      showSnackBar(
        context,
        'Please enter a title of Program',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  callApi(workOutType) async {
    if (widget.data != null && widget.isEditScreen == true) {
      solukLog(logMsg: "data", logDetail: "inside callApi ${widget.data.id}");

      showMediaUploadDialog();

      addExerciseSingleWTimeRequestModel = AddExerciseSingleWTimeRequestModel(
          media: netImage == null ? _createPostImageFiles[0] : File(""),
          assetType: netImage == null
              ? _createPostImageFiles[0].path.contains('mp4')
                  ? 'video'
                  : 'image'
              : "",
          workoutTitle: _titleController.text,
          description: _descriptionController.text,
          exerciseTime: '00:$singleWExerciseDuration',
          //singleWExerciseDuration,
          restTime: '00:$singleWRestDuration',
          //singleWRestDuration,
          workoutID: widget.workoutID!,
          weekID: widget.weekID!,
          dayID: widget.dayID!);

      switch (workOutType) {
        case "Time":
          bool isUpdated = await _singleWorkOutCubit.updateExercise(
              addExerciseSingleWTimeRequestModel:
                  addExerciseSingleWTimeRequestModel,
              workoutSetsList: workoutSetsRequestModelList,
              id: widget.data.id!,
              pData: widget.data);
          if (isUpdated == true) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          break;
        case "Reps":
          bool isUpdated = await _singleWorkOutCubit.updateExercise(
              addExerciseSingleWTimeRequestModel:
                  addExerciseSingleWTimeRequestModel,
              workoutSetsList: addExerciseRepsRequestModelList,
              id: widget.data.id!,
              pData: widget.data);
          if (isUpdated == true) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          break;
        case "Failure":
          bool isUpdated = await _singleWorkOutCubit.updateExercise(
              addExerciseSingleWTimeRequestModel:
                  addExerciseSingleWTimeRequestModel,
              workoutSetsList: workoutSetsFailureRequestModelList,
              id: widget.data.id!,
              pData: widget.data);
          if (isUpdated == true) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          break;
        case "Custom":
          bool isUpdated = await _singleWorkOutCubit.updateExercise(
              addExerciseSingleWTimeRequestModel:
                  addExerciseSingleWTimeRequestModel,
              workoutSetsList: addExerciseCustomRequestModelList,
              id: widget.data.id!,
              pData: widget.data);
          if (isUpdated == true) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          break;
        default:
          showSnackBar(
            context,
            'Please add a workout set to continue',
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );

          var workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
          workoutProgramBloc
              .add(GetWorkoutExerciseEvent(id: widget.data.id.toString()));
          Navigator.pop(context);
      }
    } else {
      showMediaUploadDialog();

      addExerciseSingleWTimeRequestModel = AddExerciseSingleWTimeRequestModel(
          media: _createPostImageFiles[0],
          assetType:
              _createPostImageFiles[0].path.contains('mp4') ? 'video' : 'image',
          workoutTitle: _titleController.text,
          description: _descriptionController.text,
          exerciseTime: '00:$singleWExerciseDuration',
          //singleWExerciseDuration,
          restTime: '00:$singleWRestDuration',
          //singleWRestDuration,
          workoutID: widget.workoutID!,
          weekID: widget.weekID!,
          dayID: widget.dayID!);
      switch (workOutType) {
        case "Time":
          bool isUpdated = await _singleWorkOutCubit.addSingleWorkOutExercise(
              addExerciseSingleWTimeRequestModel:
                  addExerciseSingleWTimeRequestModel!,
              workoutSetsList: workoutSetsRequestModelList);
          if (isUpdated == true) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          break;
        case "Reps":
          bool isUpdated = await _singleWorkOutCubit.addSingleWorkOutExercise(
              addExerciseSingleWTimeRequestModel:
                  addExerciseSingleWTimeRequestModel!,
              workoutSetsList: addExerciseRepsRequestModelList);
          if (isUpdated == true) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          break;

        case "Failure":
          bool isUpdated = await _singleWorkOutCubit.addSingleWorkOutExercise(
              addExerciseSingleWTimeRequestModel:
                  addExerciseSingleWTimeRequestModel!,
              workoutSetsList: workoutSetsFailureRequestModelList);
          if (isUpdated == true) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          break;
        case "Custom":
          bool isUpdated = await _singleWorkOutCubit.addSingleWorkOutExercise(
              addExerciseSingleWTimeRequestModel:
                  addExerciseSingleWTimeRequestModel!,
              workoutSetsList: addExerciseCustomRequestModelList);
          if (isUpdated == true) {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }
          break;
        default:
          showSnackBar(
            context,
            'Please add a workout set to continue',
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );

          var workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
          workoutProgramBloc
              .add(GetWorkoutExerciseEvent(id: widget.data.id.toString()));
          Navigator.pop(context);
      }
    }
  }

  showMediaUploadDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StreamBuilder<ProgressFile>(
            stream: BlocProvider.of<SingleWorkOutCubit>(context).progressStream,
            builder: (context, snapshot) {
              return CustomAlertDialog(
                isSmallSize: true,
                contentWidget: MediaUploadProgressPopup(
                  snapshot: snapshot,
                ),
              );
            });
      },
    );
  }
}
