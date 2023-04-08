import 'dart:convert';
import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/info_dialog_box.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/workout_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/round_exercise_request_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/rounds_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/views/add_superset_exercise_screen.dart';
import 'package:app/module/influencer/workout_programs/widgets/round_workout_title.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../../../repo/repository/web_service.dart';
import '../../../../../../../utils/pickers.dart';
import '../../../../../more/widget/custom_alert_dialog.dart';
import '../../../../../more/widget/pop_alert_dialog.dart';
import '../../../../../widgets/dotted_container.dart';
import '../../../../../widgets/image_container.dart';
import '../../../../../widgets/media_upload_progress_popup.dart';
import '../../../../../widgets/reward_popup.dart';
import '../../../../../widgets/saluk_gradient_button.dart';
import '../../../../../widgets/saluk_textfield.dart';
import '../../../../../widgets/video_container.dart';
import '../../../../model/AddExerciseFailureRequestModel.dart';
import '../../../../model/AddExerciseSingleWTimeRequestModel.dart';
import '../../../../model/add_exercise_custom_request_model.dart';
import '../../../../model/add_exercise_reps_request_model.dart';
import '../../../../model/add_exercise_single_workout_tResponse.dart';
import '../../../../model/get_all_exercise_response.dart';
import '../../../../model/workout_sets_request_model.dart';
import '../../../../widgets/add_workout_sets_dialog.dart';
import '../../../../widgets/workout_sets_tile.dart';

class AddExerciseRound extends StatefulWidget {
  static const id = "AddRound";
  final WorkOutModel data;
  final String? title;
  final String? description;
  final String? restTime;
  final List<RoundsData>? roundsList;
  final int totalRounds;
  final int? exerciseId;

  const AddExerciseRound(
      {Key? key,
      required this.data,
      this.roundsList,
      this.title,
      this.description,
      this.restTime,
      required this.totalRounds,
      required this.exerciseId})
      : super(key: key);

  @override
  State<AddExerciseRound> createState() => _AddExerciseRoundState();
}

class _AddExerciseRoundState extends State<AddExerciseRound> {
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();
  String restDuration = '';
  String restDurationMin = '';
  RoundExerciseRequest? requestData;
  int roundExerciseList = 2;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<File> _createPostImageFiles = [];
  String? path;

  //--WORKOUT SELECTION
  String workoutSetsType = "";
  String exerciseTypeCustom = "";
  int workoutSetsNumber = 1;
  String tempType = "";
  String workoutSetsValue = "";
  List<WorkoutSetsRequestModel> workoutSetsRequestModelList = [];
  List<AddExerciseFailureRequestModel> workoutSetsFailureRequestModelList = [];
  List<AddExerciseRepsRequestModel> addExerciseRepsRequestModelList = [];
  List<AddExerciseCustomRequestModel> addExerciseCustomRequestModelList = [];

  AddExerciseSingleWTimeRequestModel? addExerciseSingleWTimeRequestModel;
  AddExerciseSingleWorkoutTResponse? addExerciseSingleWorkoutTResponse;

  //--

  @override
  void initState() {
    super.initState();
    solukLog(logMsg: "rounds :${widget.data.title}");
    solukLog(logMsg: "rounds :${widget.data.roundId}");
    solukLog(logMsg: "rounds :${widget.data.exerciseId}");
    solukLog(logMsg: "rounds :${widget.data.isCircuit}");
    solukLog(logMsg: "rounds :${widget.title}");
    solukLog(logMsg: "rounds :${widget.restTime}");
    solukLog(logMsg: "rounds :${widget.roundsList}");
    getRoundExercise();
  }

  _pickImage(String source, {CameraMediaType? mediaType}) async {
    path =
        await Pickers.instance.pickImage(source: source, mediaType: mediaType);
    debugPrint("image path :$path");
    if (path != null) {
      setState(() {
        _createPostImageFiles.add(File(path!));
      });
    }
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

  String? netImage;

  bool? showDeleteConfirmationDialog(BuildContext context, {String? name}) {
    bool? res = false;
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
                      res = true;
                      Navigator.of(context).pop(true);
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
        Future.delayed(const Duration(milliseconds: 600), () {
          Navigator.pop(context);
        });
        return value;
      } else {
        return false;
      }
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
        bloc: circuitWorkOutCubit,
        listener: (context, state) {
          if (state is LoadingState) {
          } else if (state is ExerciseError) {
            showSnackBar(
              context,
              state.message ?? "no message",
              textColor: Colors.white,
            );
          } else if (state is RoundExerciseLoaded) {
            if (state.data!.responseDetails!.data != null) {
              solukLog(
                  logMsg: state.data!.responseDetails!.data!.length,
                  logDetail: "response data length inside add_round.dart");
              if (state.data!.responseDetails!.data!.isNotEmpty) {
                roundExerciseList = state.data!.responseDetails!.data![0].sets
                        ?.where((element) =>
                            element.subTypeId == widget.data.roundId)
                        .length ??
                    0;
              } else {
                roundExerciseList = 0;
              }
              if (widget.restTime != null &&
                  (widget.restTime?.split(":").length ?? 0) > 1) {
                restDuration =
                    "${widget.restTime?.split(":")[1]}:${widget.restTime?.split(":").last}";
                restDurationMin = "Mins";
              }
              setState(() {});
            }
          } else if (state is RestTimeAddedState) {
            showSnackBar(
              context,
              "Round Rest time added successfully",
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          print("rest time value : $roundExerciseList");
          return WillPopScope(
            onWillPop: () async {
              if (showDeleteConfirmationDialog(context)!) {
                Navigator.pop(context, true);
                return true;
              } else {
                return false;
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Scaffold(
                body: AppBody(
                    title: "Add Exercise",
                    result: true,
                    body: ListView(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            // widget.data.isCircuit == true
                            //     ? const SizedBox()
                            //     : Text(
                            //         AppLocalisation.getTranslated(
                            //             context, LKYouCanAddMax2Exercise),
                            //         style: subTitleTextStyle(context)?.copyWith(
                            //           color: Colors.black,
                            //           fontSize: 14.sp,
                            //         ),
                            //       ),
                            SalukTextField(
                              textEditingController: _titleController,
                              hintText: "",
                              labelText: "Exercise name",
                              enable: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _createPostImageFiles.isEmpty
                                ? MediaTypeSelectionCard(
                                    callback: () {
                                      popUpAlertDialog(
                                        context,
                                        'Pick Image',
                                        LKImageDialogDetail,
                                        isProfile: true,
                                        onCameraTap: (type) {
                                          _pickImage(
                                              Pickers.instance.sourceCamera,
                                              mediaType: type);
                                        },
                                        onGalleryTap: () {
                                          _pickImagesFromGallery();
                                        },
                                      );
                                    },
                                  )
                                : _createPostImageFiles[0].path.contains("mp4")
                                    ? VideoContainer(
                                        netUrl: _createPostImageFiles[0].path,
                                        isCloseShown: true,
                                        closeButton: () {
                                          setState(() {
                                            _createPostImageFiles = [];
                                          });
                                        },
                                      )
                                    : ImageContainer(
                                        path: _createPostImageFiles[0].path,
                                        onClose: () => setState(
                                            () => _createPostImageFiles = []),
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
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalisation.getTranslated(
                                      context, LKWorkoutSets),
                                  style: subTitleTextStyle(context)?.copyWith(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                workoutSetsType != ''
                                    ? Visibility(
                                        visible: widget.totalRounds != -1 &&
                                            workoutSetsNumber !=
                                                widget.totalRounds,
                                        child: SalukTransparentButton(
                                          title: AppLocalisation.getTranslated(
                                              context, LKAddSet),
                                          buttonWidth: WIDTH_5 * 4,
                                          borderColor: PRIMARY_COLOR,
                                          textColor: PRIMARY_COLOR,
                                          onPressed: () {
                                            if (workoutSetsType != "Temp") {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AddWorkoutSetsDialog(
                                                        selectedType:
                                                            workoutSetsType,
                                                        dropSet: false,
                                                        typeReadonly: true,
                                                        customSetName:
                                                            exerciseTypeCustom,
                                                        onChanged: (value) {
                                                          workoutSetsType =
                                                              value;
                                                          workoutSetsNumber++;
                                                          setState(() {});
                                                        },
                                                        onChanged1: (value) {
                                                          tempType = value;
                                                          setState(() {});
                                                        },
                                                        onChanged2: (value) {
                                                          workoutSetsValue =
                                                              value;
                                                          print(
                                                              workoutSetsValue);
                                                          if (workoutSetsType ==
                                                              'Time') {
                                                            workoutSetsRequestModelList.add(WorkoutSetsRequestModel(
                                                                setTimeMins:
                                                                    tempType,
                                                                type:
                                                                    workoutSetsType,
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
                                                                    type:
                                                                        workoutSetsType,
                                                                    title:
                                                                        'Set $workoutSetsNumber'));
                                                          }
                                                        },
                                                        onChanged3: (value) {
                                                          if (workoutSetsType ==
                                                              'Custom') {
                                                            exerciseTypeCustom =
                                                                value;
                                                            addExerciseCustomRequestModelList
                                                                .add(
                                                                    AddExerciseCustomRequestModel(
                                                              type:
                                                                  workoutSetsType,
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
                                                            addExerciseRepsRequestModelList.add(AddExerciseRepsRequestModel(
                                                                type:
                                                                    workoutSetsType,
                                                                title:
                                                                    'Set $workoutSetsNumber',
                                                                noOfReps:
                                                                    workoutSetsValue,
                                                                dropSet: value ==
                                                                        'Y'
                                                                    ? true
                                                                    : false));
                                                            setState(() {});
                                                          }
                                                        });
                                                  });
                                            }
                                          },
                                          buttonHeight: HEIGHT_2,
                                          style:
                                              labelTextStyle(context)?.copyWith(
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
                                        ),
                                      )
                                    : const SizedBox(
                                        width: 5,
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            workoutSetsType != ''
                                ? Container(
                                    width: double.maxFinite,
                                    // height: HEIGHT_5 * 2,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
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
                                          titleDetail:
                                              AppLocalisation.getTranslated(
                                                  context, LKSetType),
                                          onEditPress: () {},
                                          onDeletePress: () {},
                                          showIcon: false,
                                          showEditIcon: false,
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: workoutSetsType == 'Time'
                                              ? workoutSetsRequestModelList
                                                  .length
                                              : workoutSetsType == 'Failure'
                                                  ? workoutSetsFailureRequestModelList
                                                      .length
                                                  : workoutSetsType == 'Reps'
                                                      ? addExerciseRepsRequestModelList
                                                          .length
                                                      : addExerciseCustomRequestModelList
                                                          .length,
                                          itemBuilder:
                                              (BuildContext context, int _i) {
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
                                              titleDetailColor: workoutSetsType ==
                                                      'Reps'
                                                  ? addExerciseRepsRequestModelList[
                                                                  _i]
                                                              .dropSet ==
                                                          true
                                                      ? PRIMARY_COLOR
                                                      : Colors.black
                                                  : Colors.black,
                                              title: workoutSetsType == 'Time'
                                                  ? workoutSetsRequestModelList[
                                                          _i]
                                                      .title
                                                  // ? "Set ${_i + 1}"
                                                  : workoutSetsType == 'Failure'
                                                      ? workoutSetsFailureRequestModelList[
                                                              _i]
                                                          .title
                                                      : workoutSetsType ==
                                                              'Reps'
                                                          ? addExerciseRepsRequestModelList[
                                                                  _i]
                                                              .title
                                                          : addExerciseCustomRequestModelList[
                                                                  _i]
                                                              .title,
                                              titleDetail: workoutSetsType ==
                                                      'Time'
                                                  // ? '      ' +
                                                  ? '${workoutSetsRequestModelList[_i].setTime} ${workoutSetsRequestModelList[_i].setTimeMins!}'
                                                  : workoutSetsType == 'Failure'
                                                      ? workoutSetsFailureRequestModelList[
                                                              _i]
                                                          .type
                                                      : workoutSetsType ==
                                                              'Reps'
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
                                                  print(
                                                      "--- is first Workout set ---");
                                                  print(
                                                      "--- workout type $workoutSetsType");
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AddWorkoutSetsDialog(
                                                            selectedType:
                                                                workoutSetsType,
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
                                                            customSetName: addExerciseCustomRequestModelList
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
                                                              workoutSetsType =
                                                                  value;
                                                              setState(() {});
                                                            },
                                                            onChanged1:
                                                                (value) {
                                                              tempType = value;
                                                              // setState(() {});
                                                            },
                                                            onChanged2:
                                                                (value) {
                                                              workoutSetsValue =
                                                                  value;

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
                                                                  print(
                                                                      "=-=-=-=-=-=-=-=");

                                                                  workoutSetsRequestModelList.add(WorkoutSetsRequestModel(
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
                                                                  print(
                                                                      "=-=-=-=-=-=-=-=");
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
                                                            onChanged3:
                                                                (value) {
                                                              exerciseTypeCustom =
                                                                  value;

                                                              print(
                                                                  "--- inside changed workoutSetType ---");

                                                              if (workoutSetsType ==
                                                                  "Reps") {
                                                                for (int i = 0;
                                                                    i < workoutSetsNumber;
                                                                    i++) {
                                                                  print(
                                                                      "=-=-=-=-=-=-=-=");

                                                                  addExerciseRepsRequestModelList.add(AddExerciseRepsRequestModel(
                                                                      type:
                                                                          workoutSetsType,
                                                                      title:
                                                                          'Set ${i + 1}',
                                                                      noOfReps:
                                                                          workoutSetsValue,
                                                                      dropSet: value ==
                                                                              "Y"
                                                                          ? true
                                                                          : false));
                                                                }
                                                              } else if (workoutSetsType ==
                                                                  'Custom') {
                                                                for (int i = 0;
                                                                    i < workoutSetsNumber;
                                                                    i++) {
                                                                  print(
                                                                      "=-=-=-=-=-=-=-=");
                                                                  exerciseTypeCustom =
                                                                      value;
                                                                  addExerciseCustomRequestModelList
                                                                      .add(
                                                                          AddExerciseCustomRequestModel(
                                                                    type:
                                                                        workoutSetsType,
                                                                    title:
                                                                        'Set ${i + 1}',
                                                                    exerciseType:
                                                                        exerciseTypeCustom,
                                                                    count: int
                                                                        .parse(
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
                                                  print(
                                                      "--- not first Workout set ---");
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AddWorkoutSetsDialog(
                                                            selectedType:
                                                                workoutSetsType,
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
                                                            customSetName: addExerciseCustomRequestModelList
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
                                                              workoutSetsType =
                                                                  value;
                                                              setState(() {});
                                                            },
                                                            onChanged1:
                                                                (value) {
                                                              tempType = value;
                                                              setState(() {});
                                                            },
                                                            onChanged2:
                                                                (value) {
                                                              workoutSetsValue =
                                                                  value;
                                                              print(
                                                                  workoutSetsValue);
                                                              if (workoutSetsType ==
                                                                  'Time') {
                                                                workoutSetsRequestModelList[_i] = WorkoutSetsRequestModel(
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
                                                            onChanged3:
                                                                (value) {
                                                              if (workoutSetsType ==
                                                                  'Custom') {
                                                                exerciseTypeCustom =
                                                                    value;
                                                                addExerciseCustomRequestModelList[
                                                                        _i] =
                                                                    (AddExerciseCustomRequestModel(
                                                                  type:
                                                                      workoutSetsType,
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
                                                                addExerciseRepsRequestModelList[_i] = AddExerciseRepsRequestModel(
                                                                    type:
                                                                        workoutSetsType,
                                                                    title:
                                                                        'Set $workoutSetsNumber',
                                                                    noOfReps:
                                                                        workoutSetsValue,
                                                                    dropSet: value ==
                                                                            'Y'
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
                                                  workoutSetsRequestModelList
                                                      .remove(
                                                          workoutSetsRequestModelList[
                                                              _i]);
                                                  // workoutSetsNumber = _i;

                                                  workoutSetsNumber--;
                                                  for (int i = 0;
                                                      i < workoutSetsNumber;
                                                      i++) {
                                                    print("$i =-=-=-=-=-");
                                                    // workoutSetsRequestModelList[i].title =
                                                    //     "Set ${i + 1}";
                                                    workoutSetsRequestModelList[
                                                            i] =
                                                        WorkoutSetsRequestModel(
                                                            setTimeMins:
                                                                workoutSetsRequestModelList[i]
                                                                    .setTimeMins,
                                                            type:
                                                                workoutSetsRequestModelList[
                                                                        i]
                                                                    .type,
                                                            title:
                                                                'Set ${i + 1}',
                                                            setTime:
                                                                workoutSetsRequestModelList[
                                                                        i]
                                                                    .setTime);
                                                  }
                                                } else if (workoutSetsType ==
                                                    'Failure') {
                                                  workoutSetsFailureRequestModelList
                                                      .remove(
                                                          workoutSetsFailureRequestModelList[
                                                              _i]);
                                                  // workoutSetsNumber = _i;
                                                  workoutSetsNumber--;
                                                  for (int i = 0;
                                                      i < workoutSetsNumber;
                                                      i++) {
                                                    // workoutSetsFailureRequestModelList[i]
                                                    //     .title = "Set ${i + 1}";
                                                    workoutSetsFailureRequestModelList[
                                                            i] =
                                                        AddExerciseFailureRequestModel(
                                                            type:
                                                                workoutSetsFailureRequestModelList[
                                                                        i]
                                                                    .type,
                                                            title:
                                                                'Set ${i + 1}');
                                                  }
                                                } else if (workoutSetsType ==
                                                    'Reps') {
                                                  addExerciseRepsRequestModelList
                                                      .remove(
                                                          addExerciseRepsRequestModelList[
                                                              _i]);
                                                  // print("index : $_i");
                                                  // workoutSetsNumber = _i;
                                                  workoutSetsNumber--;
                                                  for (int i = 0;
                                                      i < workoutSetsNumber;
                                                      i++) {
                                                    // addExerciseRepsRequestModelList[i]
                                                    //     .title = "Set ${i + 1}";
                                                    addExerciseRepsRequestModelList[
                                                            i] =
                                                        AddExerciseRepsRequestModel(
                                                            type:
                                                                addExerciseRepsRequestModelList[
                                                                        i]
                                                                    .type,
                                                            title:
                                                                'Set ${i + 1}',
                                                            noOfReps:
                                                                addExerciseRepsRequestModelList[
                                                                        i]
                                                                    .noOfReps,
                                                            dropSet:
                                                                addExerciseRepsRequestModelList[
                                                                        i]
                                                                    .dropSet);
                                                  }
                                                } else if (workoutSetsType ==
                                                    'Custom') {
                                                  addExerciseCustomRequestModelList
                                                      .remove(
                                                          addExerciseCustomRequestModelList[
                                                              _i]);
                                                  // workoutSetsNumber = _i;
                                                  workoutSetsNumber--;
                                                  for (int i = 0;
                                                      i < workoutSetsNumber;
                                                      i++) {
                                                    // addExerciseCustomRequestModelList[i]
                                                    //     .title = "Set ${i + 1}";
                                                    addExerciseCustomRequestModelList[
                                                            i] =
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
                                                if (workoutSetsRequestModelList
                                                        .isEmpty &&
                                                    workoutSetsType == 'Time') {
                                                  workoutSetsType = '';
                                                  workoutSetsNumber = 1;
                                                }
                                                if (workoutSetsFailureRequestModelList
                                                        .isEmpty &&
                                                    workoutSetsType ==
                                                        'Failure') {
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
                                                    workoutSetsType ==
                                                        'Custom') {
                                                  workoutSetsType = '';
                                                  workoutSetsNumber = 1;
                                                }
                                                setState(() {});
                                                // _workoutProgramBloc.add(SetStateEvent());
                                              },
                                              onAddPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AddWorkoutSetsDialog(
                                                          selectedType:
                                                              workoutSetsType,
                                                          dropSet: false,
                                                          typeReadonly: false,
                                                          onChanged: (value) {
                                                            workoutSetsType =
                                                                value;
                                                            setState(() {});
                                                          },
                                                          onChanged1: (value) {
                                                            tempType = value;
                                                            setState(() {});
                                                          },
                                                          onChanged2: (value) {
                                                            workoutSetsValue =
                                                                value;
                                                            print(
                                                                "value :: $workoutSetsValue");
                                                            addExerciseCustomRequestModelList
                                                                .clear();
                                                            if (workoutSetsType ==
                                                                'Time') {
                                                              workoutSetsRequestModelList.add(WorkoutSetsRequestModel(
                                                                  setTimeMins:
                                                                      tempType,
                                                                  type:
                                                                      workoutSetsType,
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
                                                                      type:
                                                                          workoutSetsType,
                                                                      title:
                                                                          'Set $workoutSetsNumber'));
                                                              setState(() {});
                                                            }
                                                            if (workoutSetsType !=
                                                                    'Custom' ||
                                                                workoutSetsType !=
                                                                    'Reps') {
                                                              //workoutSetsNumber++;
                                                              setState(() {});
                                                            }
                                                          },
                                                          onChanged3: (value) {
                                                            if (workoutSetsType ==
                                                                'Custom') {
                                                              exerciseTypeCustom =
                                                                  value;
                                                              addExerciseCustomRequestModelList
                                                                  .add(
                                                                      AddExerciseCustomRequestModel(
                                                                type:
                                                                    workoutSetsType,
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
                                                              addExerciseRepsRequestModelList.add(AddExerciseRepsRequestModel(
                                                                  type:
                                                                      workoutSetsType,
                                                                  title:
                                                                      'Set $workoutSetsNumber',
                                                                  noOfReps:
                                                                      workoutSetsValue,
                                                                  dropSet: value ==
                                                                          'Y'
                                                                      ? true
                                                                      : false));
                                                              setState(() {});
                                                            }
                                                            if (workoutSetsType ==
                                                                    'Custom' ||
                                                                workoutSetsType ==
                                                                    'Reps') {
                                                              //workoutSetsNumber++;
                                                              setState(() {});
                                                            }
                                                          });
                                                    });
                                              },
                                              showIcon:
                                                  workoutSetsType == 'Temp'
                                                      ? true
                                                      : false,
                                              showEditIcon:
                                                  workoutSetsType == 'Temp'
                                                      ? false
                                                      : true,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : SalukTransparentButton(
                                    title: AppLocalisation.getTranslated(
                                        context, LKAddSet),
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

                            SB_1H,
                            BlocBuilder<CircuitWorkOutCubit,
                                CircuitWorkOutState>(
                              bloc: circuitWorkOutCubit,
                              builder: (context, state) {
                                if (state is ExerciseLoading) {
                                  return const Center(
                                    child: LinearProgressIndicator(),
                                  );
                                } else if (state is RoundExerciseLoaded) {
                                  List<Sets>? exercises = [];
                                  if (state.data!.responseDetails!.data!
                                      .isNotEmpty) {
                                    exercises = state
                                        .data!.responseDetails!.data![0].sets
                                        ?.where((element) =>
                                            element.subTypeId ==
                                            widget.data.roundId)
                                        .toList();
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: exercises?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Sets data = exercises![index];
                                      return RoundWorkoutTile(
                                        image: data.assetUrl,
                                        mediaType: data.assetType,
                                        callback: () async {
                                          bool exerciseAdded =
                                              await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  AddSuperSetExerciseScreen(
                                                data: widget.data,
                                                exerciseData: data,
                                              ),
                                            ),
                                          );
                                          if (exerciseAdded) {
                                            getRoundExercise();
                                          }
                                        },
                                        description: data.title,
                                        exerciseType: getExerciseType(
                                            data.type, data.meta),
                                        exerciseValue: "",
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
                bottomNavigationBar: BottomAppBar(
                  child: SalukBottomButton(
                    title: AppLocalisation.getTranslated(context, LKSubmit),
                    callback: () async {
                      // addRoundRestTime();
                      callApi(workoutSetsType);
                    },
                    isButtonDisabled: false,
                    // isButtonDisabled: workoutSetsType == "" ? true : false
                  ),
                ),
              ),
            ),
          );
        });
  }

  getRoundExercise() {
    circuitWorkOutCubit.getRoundExercises(
        id: widget.data.exerciseId.toString());
  }

  addRoundRestTime() async {
    if (restDuration != '') {
      bool apiResult = await circuitWorkOutCubit.putRoundRestTime(
          time: "00:$restDuration",
          exerciseId: widget.data.exerciseId,
          exerciseSubType: widget.data.roundId);

      if (apiResult) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return InfoDialogBox(
                icon: 'assets/images/tick_ss.png',
                title:
                    AppLocalisation.getTranslated(context, LKCongratulations),
                description: AppLocalisation.getTranslated(
                    context, LKYourWorkoutUploadedSuccessfully),
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              );
            });
      }
    } else {
      showSnackBar(context, "Add rest time to continue");
    }
  }

  String getExerciseType(String? type, String? meta) {
    String value = '';

    if (type == "Reps") {
      value = json.decode(meta ?? '')["noOfReps"] ?? '';
    } else if (type == "Time") {
      value = json.decode(meta ?? '')["setTime"] ?? "";
    } else if (type == "Failure") {
      value = "";
    } else if (type == "Custom") {
      type = json.decode(meta ?? '')["exerciseType"] ?? '';
      value = json.decode(meta ?? '')["count"] ?? '';
    }

    return "$type $value";
  }

  addSingleWorkOutExercise(String workoutType) {
    if (_titleController.text != "") {
      if (_createPostImageFiles.isNotEmpty || netImage != null) {
        if (_descriptionController.text != '') {
          callApi(workoutType);
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
        'Please enter a title of Program',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  showMediaUploadDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StreamBuilder<ProgressFile>(
            stream: circuitWorkOutCubit.progressStream,
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

  callApi(workOutType) async {
    if (_titleController.text != "") {
      if (_descriptionController.text != "") {
        if (_createPostImageFiles.isNotEmpty) {
          switch (workOutType) {
            case "Time":
              solukLog(
                  logMsg: jsonEncode(workoutSetsRequestModelList
                      .map((e) => e.toJson())
                      .toList()));
              if (workoutSetsRequestModelList.isNotEmpty) {
                showMediaUploadDialog();
                Map<String, String> body = {
                  "title": widget.title!,
                  "instructions": widget.description!,
                  'assetType': _createPostImageFiles[0].path.contains("mp4")
                      ? "Video"
                      : "Image",
                  'imageVideoURL': _createPostImageFiles[0].path,
                  "parent": "${widget.exerciseId!}",
                  "sets": jsonEncode(workoutSetsRequestModelList
                      .map((e) => e.toJson())
                      .toList())
                };
                var checkRes = await circuitWorkOutCubit.addExerciseRound(
                    exerciseRequestModel: widget.data, data: body);

                if (checkRes) {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                }

                print(body);
              } else {
                showSnackBar(
                  context,
                  'Add required SETS',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              }
              break;
            case "Reps":
              solukLog(
                  logMsg: jsonEncode(addExerciseRepsRequestModelList
                      .map((e) => e.toJson())
                      .toList()));
              if (addExerciseRepsRequestModelList.length ==
                      widget.totalRounds ||
                  widget.totalRounds == -1) {
                showMediaUploadDialog();
                Map<String, String> body = {
                  "title": widget.title!,
                  "instructions": widget.description!,
                  'assetType': _createPostImageFiles[0].path.contains("mp4")
                      ? "Video"
                      : "Image",
                  'imageVideoURL': _createPostImageFiles[0].path,
                  "parent": "${widget.exerciseId!}",
                  "sets": jsonEncode(addExerciseRepsRequestModelList
                      .map((e) => e.toJson())
                      .toList())
                };
                var checkRes = await circuitWorkOutCubit.addExerciseRound(
                    exerciseRequestModel: widget.data, data: body);

                if (checkRes) {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                }

                print(body);
              } else {
                showSnackBar(
                  context,
                  'Add required SETS',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              }
              break;
            case "Custom":
              solukLog(
                  logMsg: jsonEncode(addExerciseCustomRequestModelList
                      .map((e) => e.toJson())
                      .toList()));

              if (addExerciseCustomRequestModelList.length ==
                      widget.totalRounds ||
                  widget.totalRounds == -1) {
                showMediaUploadDialog();
                Map<String, String> body = {
                  "title": widget.title!,
                  "instructions": widget.description!,
                  'assetType': _createPostImageFiles[0].path.contains("mp4")
                      ? "Video"
                      : "Image",
                  'imageVideoURL': _createPostImageFiles[0].path,
                  "parent": "${widget.exerciseId!}",
                  "sets": jsonEncode(addExerciseCustomRequestModelList
                      .map((e) => e.toJson())
                      .toList())
                };
                var checkRes = await circuitWorkOutCubit.addExerciseRound(
                    exerciseRequestModel: widget.data, data: body);

                if (checkRes) {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                }

                print(body);
              } else {
                showSnackBar(
                  context,
                  'Add required SETS',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              }
              break;
            case "Failure":
              solukLog(
                  logMsg: jsonEncode(workoutSetsFailureRequestModelList
                      .map((e) => e.toJson())
                      .toList()));

              if (workoutSetsFailureRequestModelList.length ==
                      widget.totalRounds ||
                  widget.totalRounds == -1) {
                showMediaUploadDialog();
                Map<String, String> body = {
                  "title": widget.title!,
                  "instructions": widget.description!,
                  'assetType': _createPostImageFiles[0].path.contains("mp4")
                      ? "Video"
                      : "Image",
                  'imageVideoURL': _createPostImageFiles[0].path,
                  "parent": "${widget.exerciseId!}",
                  "sets": jsonEncode(workoutSetsFailureRequestModelList
                      .map((e) => e.toJson())
                      .toList())
                };
                var checkRes = await circuitWorkOutCubit.addExerciseRound(
                    exerciseRequestModel: widget.data, data: body);

                if (checkRes) {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                }

                print(body);
              } else {
                showSnackBar(
                  context,
                  'Add required SETS',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              }
              break;
            default:
              showSnackBar(
                context,
                'Please select Sets type',
                backgroundColor: Colors.black,
                textColor: Colors.white,
              );
              break;
          }
        } else {
          showSnackBar(
            context,
            'Please select Image or Video',
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }
      } else {
        showSnackBar(
          context,
          'Please enter a instructions of exercise',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    } else {
      showSnackBar(
        context,
        'Please enter a title exercise',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }
}
