import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/info_dialog_box.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/AddExerciseFailureRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/AddExerciseSingleWTimeRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_custom_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_long_video_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_long_video_response.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_reps_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_single_workout_tResponse.dart';
import 'package:app/module/influencer/workout_programs/model/workout_sets_request_model.dart';
import 'package:app/module/influencer/workout_programs/widgets/add_workout_sets_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/exercise_duration_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/video_player_widget.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_sets_tile.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class AddExercise extends StatefulWidget {
  static const id = "AddExercise";
  bool? isEditScreen = false;
  String title;
  String? workoutType;
  String? description;
  bool? hideChips = false;
  bool? circuitScreen = false;
  final String workoutID;
  final String weekID;
  final String dayID;
  AddExercise(
      {Key? key,
      this.isEditScreen,
      required this.title,
      this.description,
      this.workoutType,
      this.hideChips,
      this.circuitScreen,
      required this.workoutID,
      required this.weekID,
      required this.dayID})
      : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();

  int viewType = 0;

  late final _workoutProgramBloc;
  AddExerciseLongVideoRequestModel? addExerciseLongVideoRequestModel;

  AddExerciseLongVideoResponse? addExerciseLongVideoResponse;

  String longVideoExerciseDuration = '';
  String longVideoExerciseDurationMin = '';
  String singleWRestDuration = '';
  String singleWRestDurationMin = '';
  String singleWExerciseDuration = '';
  String singleWExerciseDurationMin = '';
  String workoutSetsType = '';
  String workoutSetsValue = '';
  String exerciseTypeCustom = '';
  int workoutSetsNumber = 1;
  List<WorkoutSetsRequestModel> workoutSetsRequestModelList = [];
  List<AddExerciseFailureRequestModel> workoutSetsFailureRequestModelList = [];
  List<AddExerciseRepsRequestModel> addExerciseRepsRequestModelList = [];
  List<AddExerciseCustomRequestModel> addExerciseCustomRequestModelList = [];

  AddExerciseSingleWTimeRequestModel? addExerciseSingleWTimeRequestModel;
  AddExerciseSingleWorkoutTResponse? addExerciseSingleWorkoutTResponse;

  String tempType = '';

  @override
  void initState() {
    super.initState();
    _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    _workoutProgramBloc.add(WorkoutPrerequisitesLoadingEvent());
    if (widget.isEditScreen == true) {
      // _titleController.text = widget.title!;
      // _descriptionController.text = widget.description!;
    }

    if (widget.workoutType == 'Single Workout') {
      viewType = 1;
    } else if (widget.workoutType == 'Superset') {
      viewType = 2;
    } else if (widget.workoutType == 'Circuit') {
      viewType = 2;
    } else if (widget.workoutType == 'Long Video') {
      viewType = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
        listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is SetStateState) {
      } else if (state is ErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        );
      } else if (state is InternetErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (state is AddExerciseLongVideoState) {
        addExerciseLongVideoResponse = state.addExerciseLongVideoResponse;
        // showSnackBar(
        //   context,
        //   'Long Video added successfully.',
        //   backgroundColor: Colors.black,
        //   textColor: Colors.white,
        // );
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
                  Navigator.pop(context);
                },
              );
            });
      } else if (state is AddExerciseSingleWorkoutTState) {
        addExerciseSingleWorkoutTResponse =
            state.addExerciseSingleWorkoutTResponse;

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
                  Navigator.pop(context);
                },
              );
            });
      }
    }, builder: (context, state) {
      return Scaffold(
        body: AppBody(
            title: widget.title,
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.hideChips == false
                        ? Text(
                            AppLocalisation.getTranslated(
                                context, LKWorkoutType),
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          )
                        : const SizedBox(),
                    // widget.hideChips == false
                    //     ?
                    choiceChipWidget(context,
                        title: widget.workoutType!,
                        isIncomeSelected: true, onSelected: (val) {
                      // _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                      // setState(() {
                      //   isOverAllIncomeSelected = true;
                      //   isMonthlyIncomeSelected = false;
                      // });
                    }),
                    //: const SizedBox(),
                    SB_1H,
                    widget.circuitScreen == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalisation.getTranslated(
                                    context, LKTotalDuration),
                                style: subTitleTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_sharp,
                                    color: Colors.grey,
                                  ),
                                  SB_1W,
                                  Text(
                                    '30 mins',
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                    widget.circuitScreen == true ? SB_1H : const SizedBox(),
                    (viewType == 2)
                        ? SalukTransparentButton(
                            title:
                                AppLocalisation.getTranslated(context, LKAdd),
                            buttonWidth: defaultSize.screenWidth,
                            borderColor: PRIMARY_COLOR,
                            buttonColor: PRIMARY_COLOR,
                            onPressed: () {
                              // if (widget.circuitScreen == false) {
                              //   showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return SupersetCircuitTypeDialog(
                              //           workoutID: widget.weekID,
                              //           weekID: widget.weekID,
                              //           dayID: widget.dayID,
                              //           isCircuit: widget.circuitScreen,
                              //         );
                              //       });
                              // } else {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (_) => AddRound(
                              //         title: 'Add Round',
                              //         workoutType: widget.workoutType,
                              //         numberOfRounds: 0,
                              //         workoutID: '',
                              //         weekID: '',
                              //         dayID: '',
                              //       ),
                              //     ),
                              //   );
                              // }
                            },
                            buttonHeight: HEIGHT_4,
                            style: labelTextStyle(context)?.copyWith(
                              fontSize: 14.sp,
                              color: SCAFFOLD_BACKGROUND_COLOR,
                            ),
                            icon: const Icon(
                              Icons.add_circle,
                              color: SCAFFOLD_BACKGROUND_COLOR,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          )
                        : const SizedBox(),
                    (viewType != 2)
                        ? SalukTextField(
                            textEditingController: _titleController,
                            hintText: "",
                            labelText: AppLocalisation.getTranslated(
                                context, LKExerciseName),
                          )
                        : const SizedBox(),
                    (viewType != 2) ? SB_1H : const SizedBox(),
                    viewType == 1
                        ? Row(
                            children: [
                              Text(
                                AppLocalisation.getTranslated(
                                    context, LKExerciseTime),
                                style: subTitleTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "  (${AppLocalisation.getTranslated(context, LKOptional)})",
                                style: labelTextStyle(context)?.copyWith(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    viewType == 1
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox(),
                    viewType == 1
                        ? singleWExerciseDuration == ''
                            ? SalukTransparentButton(
                                title: AppLocalisation.getTranslated(
                                    context, LKExerciseTime),
                                buttonWidth: defaultSize.screenWidth,
                                textColor: PRIMARY_COLOR,
                                borderColor: PRIMARY_COLOR,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ExerciseDurationDialog(
                                          heading:
                                              AppLocalisation.getTranslated(
                                                  context, LKAddExerciseTime),
                                          onChanged: (value) {
                                            singleWExerciseDuration = value;
                                            _workoutProgramBloc
                                                .add(SetStateEvent());
                                          },
                                          onChanged2: (String value) {
                                            singleWExerciseDurationMin = value;
                                            _workoutProgramBloc
                                                .add(SetStateEvent());
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
                                    singleWExerciseDuration +
                                        ' ' +
                                        singleWExerciseDurationMin,
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SB_1W,
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ExerciseDurationDialog(
                                              heading:
                                                  AppLocalisation.getTranslated(
                                                      context,
                                                      LKAddExerciseTime),
                                              onChanged: (value) {
                                                singleWExerciseDuration = value;
                                                _workoutProgramBloc
                                                    .add(SetStateEvent());
                                              },
                                              onChanged2: (String value) {
                                                singleWExerciseDurationMin =
                                                    value;
                                                _workoutProgramBloc
                                                    .add(SetStateEvent());
                                              },
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: PRIMARY_COLOR,
                                    ),
                                  ),
                                ],
                              )
                        : const SizedBox(),
                    viewType == 1
                        ? const SizedBox(
                            height: 20,
                          )
                        : const SizedBox(),
                    viewType != 2
                        ? MediaTypeSelectionCard(
                            callback: () {
                              _pickImagesFromGallery();
                            },
                            child: _createPostImageFiles.isNotEmpty
                                ? _createPostImageFiles[0].path.contains('mp4')
                                    ? Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            child: VideoPlayerWidget(
                                              url: '',
                                              file: _createPostImageFiles[0],
                                              mediaTypeisLocalVideo: true,
                                            ),
                                            width: defaultSize.screenWidth,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: InkWell(
                                              onTap: () {
                                                //Navigator.pop(context);

                                                _createPostImageFiles.clear();
                                                _workoutProgramBloc
                                                    .add(SetStateEvent());
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                child: SvgPicture.asset(
                                                    'assets/svgs/cross_icon.svg',
                                                    height: 25,
                                                    width: 25),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            child: Image.file(
                                              _createPostImageFiles[0],
                                              fit: BoxFit.cover,
                                            ),
                                            width: defaultSize.screenWidth,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: InkWell(
                                              onTap: () {
                                                //Navigator.pop(context);

                                                _createPostImageFiles.clear();
                                                _workoutProgramBloc
                                                    .add(SetStateEvent());
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                child: SvgPicture.asset(
                                                    'assets/svgs/cross_icon.svg',
                                                    height: 25,
                                                    width: 25),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                : null,
                          )
                        : const SizedBox(),
                    viewType != 2 ? SB_1H : const SizedBox(),
                    viewType != 2
                        ? SalukTextField(
                            textEditingController: _descriptionController,
                            maxLines: 6,
                            hintText: "",
                            labelText: AppLocalisation.getTranslated(
                                context, LKTypeInstructions))
                        : const SizedBox(),
                    viewType == 1 ? SB_1H : const SizedBox(),
                    viewType == 1
                        ? Row(
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
                                  ? SalukTransparentButton(
                                      title: AppLocalisation.getTranslated(
                                          context, LKAddSet),
                                      buttonWidth: WIDTH_5 * 4,
                                      borderColor: PRIMARY_COLOR,
                                      textColor: PRIMARY_COLOR,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AddWorkoutSetsDialog(
                                                  selectedType: workoutSetsType,
                                                  typeReadonly: true,
                                                  onChanged: (value) {
                                                    workoutSetsType = value;
                                                  },
                                                  onChanged1: (value) {
                                                    tempType = value;
                                                  },
                                                  onChanged2: (value) {
                                                    workoutSetsValue = value;
                                                    print(workoutSetsValue);
                                                    if (workoutSetsType ==
                                                        'Time') {
                                                      workoutSetsRequestModelList.add(
                                                          WorkoutSetsRequestModel(
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
                                                    } else if (workoutSetsType ==
                                                        'Failure') {
                                                      workoutSetsFailureRequestModelList.add(
                                                          AddExerciseFailureRequestModel(
                                                              type:
                                                                  workoutSetsType,
                                                              title:
                                                                  'Set $workoutSetsNumber'));
                                                    }
                                                    if (workoutSetsType !=
                                                            'Custom' ||
                                                        workoutSetsType !=
                                                            'Reps') {
                                                      workoutSetsNumber++;
                                                      _workoutProgramBloc
                                                          .add(SetStateEvent());
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
                                                        type: workoutSetsType,
                                                        title:
                                                            'Set $workoutSetsNumber',
                                                        exerciseType:
                                                            exerciseTypeCustom,
                                                        count: int.parse(
                                                            workoutSetsValue),
                                                      ));
                                                    } else if (workoutSetsType ==
                                                        'Reps') {
                                                      addExerciseRepsRequestModelList.add(
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
                                                                      : false));
                                                    }
                                                    if (workoutSetsType ==
                                                            'Custom' ||
                                                        workoutSetsType ==
                                                            'Reps') {
                                                      workoutSetsNumber++;
                                                      _workoutProgramBloc
                                                          .add(SetStateEvent());
                                                    }
                                                  });
                                            });
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
                                  : SizedBox(
                                      width: 5,
                                    ),
                            ],
                          )
                        : const SizedBox(),
                    viewType == 1 ? SB_1H : const SizedBox(),

                    viewType == 1
                        ? workoutSetsType != ''
                            ? Container(
                                width: double.maxFinite,
                                // height: HEIGHT_5 * 2,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
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
                                          ? workoutSetsRequestModelList.length
                                          : workoutSetsType == 'Failure'
                                              ? workoutSetsFailureRequestModelList
                                                  .length
                                              : workoutSetsType == 'Reps'
                                                  ? addExerciseRepsRequestModelList
                                                      .length
                                                  : addExerciseCustomRequestModelList
                                                      .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return WorkoutSetsTile(
                                          titleColor: Colors.black,
                                          titleDetailColor: workoutSetsType ==
                                                  'Reps'
                                              ? addExerciseRepsRequestModelList[
                                                              index]
                                                          .dropSet ==
                                                      true
                                                  ? PRIMARY_COLOR
                                                  : Colors.black
                                              : Colors.black,
                                          title: workoutSetsType == 'Time'
                                              ? workoutSetsRequestModelList[
                                                      index]
                                                  .title
                                              : workoutSetsType == 'Failure'
                                                  ? workoutSetsFailureRequestModelList[
                                                          index]
                                                      .title
                                                  : workoutSetsType == 'Reps'
                                                      ? addExerciseRepsRequestModelList[
                                                              index]
                                                          .title
                                                      : addExerciseCustomRequestModelList[
                                                              index]
                                                          .title,
                                          titleDetail: workoutSetsType == 'Time'
                                              ? '      ' +
                                                  workoutSetsRequestModelList[
                                                          index]
                                                      .setTime +
                                                  ' ' +
                                                  workoutSetsRequestModelList[
                                                          index]
                                                      .setTimeMins!
                                              : workoutSetsType == 'Failure'
                                                  ? workoutSetsFailureRequestModelList[
                                                          index]
                                                      .type
                                                  : workoutSetsType == 'Reps'
                                                      ? '         ' +
                                                          addExerciseRepsRequestModelList[
                                                                  index]
                                                              .noOfReps +
                                                          '   ' +
                                                          addExerciseRepsRequestModelList[
                                                                  index]
                                                              .type
                                                      : '         ' +
                                                          addExerciseCustomRequestModelList[
                                                                  index]
                                                              .count
                                                              .toString() +
                                                          '   ' +
                                                          addExerciseCustomRequestModelList[
                                                                  index]
                                                              .exerciseType,
                                          onEditPress: () {
                                            // showDialog(
                                            //     context: context,
                                            //     builder:
                                            //         (BuildContext context) {
                                            //       return AddWorkoutSetsDialog(
                                            //           selectedType:
                                            //               workoutSetsType,
                                            //           typeReadonly: false,
                                            //           onChanged: (value) {
                                            //             workoutSetsType = value;
                                            //           },
                                            //           onChanged1: (value) {
                                            //             tempType = value;
                                            //           },
                                            //           onChanged2: (value) {
                                            //             workoutSetsValue =
                                            //                 value;
                                            //             print(workoutSetsValue);
                                            //             addExerciseCustomRequestModelList
                                            //                 .clear();
                                            //             if (workoutSetsType ==
                                            //                 'Time') {
                                            //               for (int i = 0;
                                            //                   i <
                                            //                       workoutSetsRequestModelList
                                            //                           .length;
                                            //                   i++) {
                                            //                 workoutSetsRequestModelList[
                                            //                             i]
                                            //                         .type =
                                            //                     workoutSetsType;
                                            //               }
                                            //             } else if (workoutSetsType ==
                                            //                 'Failure') {
                                            //               for (int i = 0;
                                            //                   i <
                                            //                       workoutSetsFailureRequestModelList
                                            //                           .length;
                                            //                   i++) {
                                            //                 workoutSetsFailureRequestModelList[
                                            //                             i]
                                            //                         .type =
                                            //                     workoutSetsType;
                                            //               }
                                            //             } else if (workoutSetsType ==
                                            //                 'Reps') {
                                            //               for (int i = 0;
                                            //                   i <
                                            //                       addExerciseRepsRequestModelList
                                            //                           .length;
                                            //                   i++) {
                                            //                 addExerciseRepsRequestModelList[
                                            //                             i]
                                            //                         .type =
                                            //                     workoutSetsType;
                                            //               }
                                            //             }
                                            //             _workoutProgramBloc.add(
                                            //                 SetStateEvent());
                                            //           },
                                            //           onChanged3: (value) {
                                            //             exerciseTypeCustom =
                                            //                 value;
                                            //
                                            //             if (workoutSetsType ==
                                            //                 'Custom') {
                                            //               for (int i = 0;
                                            //                   i <
                                            //                       addExerciseCustomRequestModelList
                                            //                           .length;
                                            //                   i++) {
                                            //                 addExerciseCustomRequestModelList[
                                            //                             i]
                                            //                         .type =
                                            //                     workoutSetsType;
                                            //               }
                                            //             }
                                            //             _workoutProgramBloc.add(
                                            //                 SetStateEvent());
                                            //           });
                                            //     });
                                          },
                                          onDeletePress: () {
                                            if (workoutSetsType == 'Time') {
                                              workoutSetsRequestModelList.remove(
                                                  workoutSetsRequestModelList[
                                                      index]);
                                            } else if (workoutSetsType ==
                                                'Failure') {
                                              workoutSetsFailureRequestModelList
                                                  .remove(
                                                      workoutSetsFailureRequestModelList[
                                                          index]);
                                            } else if (workoutSetsType ==
                                                'Reps') {
                                              addExerciseRepsRequestModelList
                                                  .remove(
                                                      addExerciseRepsRequestModelList[
                                                          index]);
                                            } else if (workoutSetsType ==
                                                'Custom') {
                                              addExerciseCustomRequestModelList
                                                  .remove(
                                                      addExerciseCustomRequestModelList[
                                                          index]);
                                            }
                                            if (workoutSetsRequestModelList
                                                    .isEmpty &&
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
                                            _workoutProgramBloc
                                                .add(SetStateEvent());
                                          },
                                          onAddPress: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AddWorkoutSetsDialog(
                                                      selectedType:
                                                          workoutSetsType,
                                                      typeReadonly: false,
                                                      onChanged: (value) {
                                                        workoutSetsType = value;
                                                      },
                                                      onChanged1: (value) {
                                                        tempType = value;
                                                      },
                                                      onChanged2: (value) {
                                                        workoutSetsValue =
                                                            value;
                                                        print(workoutSetsValue);
                                                        addExerciseCustomRequestModelList
                                                            .clear();
                                                        if (workoutSetsType ==
                                                            'Time') {
                                                          workoutSetsRequestModelList.add(
                                                              WorkoutSetsRequestModel(
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
                                                        } else if (workoutSetsType ==
                                                            'Failure') {
                                                          workoutSetsFailureRequestModelList.add(
                                                              AddExerciseFailureRequestModel(
                                                                  type:
                                                                      workoutSetsType,
                                                                  title:
                                                                      'Set $workoutSetsNumber'));
                                                        }
                                                        if (workoutSetsType !=
                                                                'Custom' ||
                                                            workoutSetsType !=
                                                                'Reps') {
                                                          workoutSetsNumber++;
                                                          _workoutProgramBloc.add(
                                                              SetStateEvent());
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
                                                        } else if (workoutSetsType ==
                                                            'Reps') {
                                                          addExerciseRepsRequestModelList.add(
                                                              AddExerciseRepsRequestModel(
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
                                                        }
                                                        if (workoutSetsType ==
                                                                'Custom' ||
                                                            workoutSetsType ==
                                                                'Reps') {
                                                          workoutSetsNumber++;
                                                          _workoutProgramBloc.add(
                                                              SetStateEvent());
                                                        }
                                                      });
                                                });
                                          },
                                          showIcon: workoutSetsType == 'Temp'
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

                                  _workoutProgramBloc.add(SetStateEvent());

                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       return AddWorkoutSetsDialog(
                                  //           selectedType: workoutSetsType,
                                  //           typeReadonly: false,
                                  //           onChanged: (value) {
                                  //             workoutSetsType = value;
                                  //           },
                                  //           onChanged2: (value) {
                                  //             workoutSetsValue = value;
                                  //             print(workoutSetsValue);
                                  //
                                  //           },
                                  //           onChanged3: (value) {
                                  //             exerciseTypeCustom = value;
                                  //
                                  //           });
                                  //     });
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
                        : const SizedBox(),

                    viewType == 1 ? SB_1H : const SizedBox(),
                    viewType == 1
                        ? Container(
                            height: 1,
                            width: defaultSize.screenWidth,
                            color: PIN_FIELD_COLOR,
                          )
                        : const SizedBox(),
                    viewType == 1 ? SB_1H : const SizedBox(),
                    viewType == 1
                        ? Text(
                            AppLocalisation.getTranslated(
                                context, LKExerciseRestTime),
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          )
                        : const SizedBox(),
                    viewType == 1
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox(),
                    viewType == 1
                        ? singleWRestDuration == ''
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
                                          heading:
                                              AppLocalisation.getTranslated(
                                                  context, LKAddRestTime),
                                          onChanged: (String value) {
                                            singleWRestDuration = value;
                                            _workoutProgramBloc
                                                .add(SetStateEvent());
                                          },
                                          onChanged2: (String value) {
                                            singleWRestDurationMin = value;
                                            _workoutProgramBloc
                                                .add(SetStateEvent());
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
                                    singleWRestDuration +
                                        ' ' +
                                        singleWRestDurationMin,
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SB_1W,
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ExerciseDurationDialog(
                                              heading:
                                                  AppLocalisation.getTranslated(
                                                      context, LKAddRestTime),
                                              onChanged: (String value) {
                                                singleWRestDuration = value;
                                              },
                                              onChanged2: (String value) {
                                                singleWRestDurationMin = value;
                                                _workoutProgramBloc
                                                    .add(SetStateEvent());
                                              },
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: PRIMARY_COLOR,
                                    ),
                                  ),
                                ],
                              )
                        : const SizedBox(),
                    viewType == 3 ? SB_1H : const SizedBox(),

                    ///
                    viewType == 3
                        ? Text(
                            AppLocalisation.getTranslated(
                                context, LKExerciseTime),
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          )
                        : const SizedBox(),
                    viewType == 3
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox(),
                    viewType == 3
                        ? longVideoExerciseDuration == ''
                            ? SalukTransparentButton(
                                title: AppLocalisation.getTranslated(
                                    context, LKAddDuration),
                                buttonWidth: defaultSize.screenWidth,
                                borderColor: PRIMARY_COLOR,
                                textColor: PRIMARY_COLOR,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ExerciseDurationDialog(
                                          heading:
                                              AppLocalisation.getTranslated(
                                                  context, LKExerciseTime),
                                          onChanged: (String value) {
                                            longVideoExerciseDuration = value;
                                          },
                                          onChanged2: (String value) {
                                            longVideoExerciseDurationMin =
                                                value;
                                            _workoutProgramBloc
                                                .add(SetStateEvent());
                                          },
                                        );
                                      });
                                },
                                buttonHeight: HEIGHT_4,
                                style: labelTextStyle(context)?.copyWith(
                                  fontSize: 14.sp,
                                  color: PRIMARY_COLOR,
                                ),
                                icon: Icon(
                                  Icons.add_circle,
                                  color: PRIMARY_COLOR,
                                ),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              )
                            : Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_sharp,
                                    color: Colors.grey,
                                  ),
                                  SB_1W,
                                  Text(
                                    longVideoExerciseDuration +
                                        ' ' +
                                        longVideoExerciseDurationMin,
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SB_1W,
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ExerciseDurationDialog(
                                              heading:
                                                  AppLocalisation.getTranslated(
                                                      context, LKExerciseTime),
                                              onChanged: (String value) {
                                                longVideoExerciseDuration =
                                                    value;
                                              },
                                              onChanged2: (String value) {
                                                longVideoExerciseDurationMin =
                                                    value;
                                                _workoutProgramBloc
                                                    .add(SetStateEvent());
                                              },
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: PRIMARY_COLOR,
                                    ),
                                  ),
                                ],
                              )
                        : SizedBox(),

                    SB_1H,

                    viewType != 2
                        ? SalukGradientButton(
                            title: AppLocalisation.getTranslated(
                                context, LKSubmit),
                            onPressed: () async {
                              if (widget.workoutType == "Long Video") {
                                if (_createPostImageFiles.isNotEmpty) {
                                  if (_titleController.text != '') {
                                    if (_descriptionController.text != '') {
                                      if (longVideoExerciseDuration != '') {
                                        addExerciseLongVideoRequestModel =
                                            AddExerciseLongVideoRequestModel(
                                                media: _createPostImageFiles[0],
                                                assetType:
                                                    _createPostImageFiles[0]
                                                            .path
                                                            .contains('mp4')
                                                        ? 'video'
                                                        : 'image',
                                                workoutTitle:
                                                    _titleController.text,
                                                description:
                                                    _descriptionController.text,
                                                exerciseTime: '00:' +
                                                    longVideoExerciseDuration,
                                                workoutID: widget.workoutID,
                                                weekID: widget.weekID,
                                                dayID: widget.dayID);

                                        _workoutProgramBloc.add(
                                            AddExerciseLongVideoEvent(
                                                addExerciseLongVideoRequestModel:
                                                    addExerciseLongVideoRequestModel!));
                                      } else {
                                        showSnackBar(
                                          context,
                                          'Please enter exercise duration',
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                      }
                                    } else {
                                      showSnackBar(
                                        context,
                                        'Please enter exercise plan description',
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
                                } else {
                                  showSnackBar(
                                    context,
                                    'Please select a media file (Photo or Video)',
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                }
                              } else if (widget.workoutType ==
                                  "Single Workout") {
                                if (workoutSetsType != 'Temp') {
                                  if (workoutSetsType == 'Time') {
                                    if (_createPostImageFiles.isNotEmpty) {
                                      if (_titleController.text != '') {
                                        if (_descriptionController.text != '') {
                                          if (singleWExerciseDuration != '') {
                                            if (singleWRestDuration != '') {
                                              if (workoutSetsRequestModelList
                                                  .isNotEmpty) {
                                                addExerciseSingleWTimeRequestModel =
                                                    AddExerciseSingleWTimeRequestModel(
                                                        media: _createPostImageFiles[
                                                            0],
                                                        assetType:
                                                            _createPostImageFiles[
                                                                        0]
                                                                    .path
                                                                    .contains(
                                                                        'mp4')
                                                                ? 'video'
                                                                : 'image',
                                                        workoutTitle:
                                                            _titleController
                                                                .text,
                                                        description:
                                                            _descriptionController
                                                                .text,
                                                        exerciseTime: '00:' +
                                                            singleWExerciseDuration,
                                                        //singleWExerciseDuration,
                                                        restTime: '00:' +
                                                            singleWRestDuration,
                                                        //singleWRestDuration,
                                                        workoutID:
                                                            widget.workoutID,
                                                        weekID: widget.weekID,
                                                        dayID: widget.dayID);

                                                _workoutProgramBloc.add(
                                                    AddExerciseSingleWTimeEvent(
                                                        addExerciseSingleWTimeRequestModel:
                                                            addExerciseSingleWTimeRequestModel!,
                                                        workoutSetsList:
                                                            workoutSetsRequestModelList));
                                              } else {
                                                showSnackBar(
                                                  context,
                                                  'Please add a workout set',
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                );
                                              }
                                            } else {
                                              showSnackBar(
                                                context,
                                                'Please enter exercise rest duration',
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                              );
                                            }
                                          } else {
                                            showSnackBar(
                                              context,
                                              'Please enter exercise duration',
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                            );
                                          }
                                        } else {
                                          showSnackBar(
                                            context,
                                            'Please enter exercise plan description',
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
                                    } else {
                                      showSnackBar(
                                        context,
                                        'Please select a media file (Photo or Video)',
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                      );
                                    }
                                  } else if (workoutSetsType == 'Failure') {
                                    if (_createPostImageFiles.isNotEmpty) {
                                      if (_titleController.text != '') {
                                        if (_descriptionController.text != '') {
                                          if (singleWExerciseDuration != '') {
                                            if (singleWRestDuration != '') {
                                              if (workoutSetsFailureRequestModelList
                                                  .isNotEmpty) {
                                                addExerciseSingleWTimeRequestModel =
                                                    AddExerciseSingleWTimeRequestModel(
                                                        media: _createPostImageFiles[
                                                            0],
                                                        assetType:
                                                            _createPostImageFiles[
                                                                        0]
                                                                    .path
                                                                    .contains(
                                                                        'mp4')
                                                                ? 'video'
                                                                : 'image',
                                                        workoutTitle:
                                                            _titleController
                                                                .text,
                                                        description:
                                                            _descriptionController
                                                                .text,
                                                        exerciseTime:
                                                            '00:03:03',
                                                        //singleWExerciseDuration,
                                                        restTime: '00:03:03',
                                                        //singleWRestDuration,
                                                        workoutID:
                                                            widget.workoutID,
                                                        weekID: widget.weekID,
                                                        dayID: widget.dayID);

                                                _workoutProgramBloc.add(
                                                    AddExerciseSingleWTimeEvent(
                                                        addExerciseSingleWTimeRequestModel:
                                                            addExerciseSingleWTimeRequestModel!,
                                                        workoutSetsList:
                                                            workoutSetsRequestModelList));
                                              } else {
                                                showSnackBar(
                                                  context,
                                                  'Please add a workout set',
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                );
                                              }
                                            } else {
                                              showSnackBar(
                                                context,
                                                'Please enter exercise rest duration',
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                              );
                                            }
                                          } else {
                                            showSnackBar(
                                              context,
                                              'Please enter exercise duration',
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                            );
                                          }
                                        } else {
                                          showSnackBar(
                                            context,
                                            'Please enter exercise plan description',
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
                                    } else {
                                      showSnackBar(
                                        context,
                                        'Please select a media file (Photo or Video)',
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                      );
                                    }
                                  } else if (workoutSetsType == 'Reps') {
                                    if (_createPostImageFiles.isNotEmpty) {
                                      if (_titleController.text != '') {
                                        if (_descriptionController.text != '') {
                                          if (singleWExerciseDuration != '') {
                                            if (singleWRestDuration != '') {
                                              if (addExerciseRepsRequestModelList
                                                  .isNotEmpty) {
                                                addExerciseSingleWTimeRequestModel =
                                                    AddExerciseSingleWTimeRequestModel(
                                                        media: _createPostImageFiles[
                                                            0],
                                                        assetType:
                                                            _createPostImageFiles[
                                                                        0]
                                                                    .path
                                                                    .contains(
                                                                        'mp4')
                                                                ? 'video'
                                                                : 'image',
                                                        workoutTitle:
                                                            _titleController
                                                                .text,
                                                        description:
                                                            _descriptionController
                                                                .text,
                                                        exerciseTime:
                                                            '00:03:03',
                                                        //singleWExerciseDuration,
                                                        restTime: '00:03:03',
                                                        //singleWRestDuration,
                                                        workoutID:
                                                            widget.workoutID,
                                                        weekID: widget.weekID,
                                                        dayID: widget.dayID);

                                                _workoutProgramBloc.add(
                                                    AddExerciseSingleWRepsEvent(
                                                        addExerciseSingleWTimeRequestModel:
                                                            addExerciseSingleWTimeRequestModel!,
                                                        workoutSetsList:
                                                            addExerciseRepsRequestModelList));
                                              } else {
                                                showSnackBar(
                                                  context,
                                                  'Please add a workout set',
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                );
                                              }
                                            } else {
                                              showSnackBar(
                                                context,
                                                'Please enter exercise rest duration',
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                              );
                                            }
                                          } else {
                                            showSnackBar(
                                              context,
                                              'Please enter exercise duration',
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                            );
                                          }
                                        } else {
                                          showSnackBar(
                                            context,
                                            'Please enter exercise plan description',
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
                                    } else {
                                      showSnackBar(
                                        context,
                                        'Please select a media file (Photo or Video)',
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                      );
                                    }
                                  } else if (workoutSetsType == 'Custom') {
                                    if (_createPostImageFiles.isNotEmpty) {
                                      if (_titleController.text != '') {
                                        if (_descriptionController.text != '') {
                                          if (singleWExerciseDuration != '') {
                                            if (singleWRestDuration != '') {
                                              if (addExerciseCustomRequestModelList
                                                  .isNotEmpty) {
                                                addExerciseSingleWTimeRequestModel =
                                                    AddExerciseSingleWTimeRequestModel(
                                                        media: _createPostImageFiles[
                                                            0],
                                                        assetType:
                                                            _createPostImageFiles[
                                                                        0]
                                                                    .path
                                                                    .contains(
                                                                        'mp4')
                                                                ? 'video'
                                                                : 'image',
                                                        workoutTitle:
                                                            _titleController
                                                                .text,
                                                        description:
                                                            _descriptionController
                                                                .text,
                                                        exerciseTime:
                                                            '00:03:03',
                                                        //singleWExerciseDuration,
                                                        restTime: '00:03:03',
                                                        //singleWRestDuration,
                                                        workoutID:
                                                            widget.workoutID,
                                                        weekID: widget.weekID,
                                                        dayID: widget.dayID);

                                                _workoutProgramBloc.add(
                                                    AddExerciseSingleWCustomEvent(
                                                        addExerciseSingleWTimeRequestModel:
                                                            addExerciseSingleWTimeRequestModel!,
                                                        workoutSetsList:
                                                            addExerciseCustomRequestModelList));
                                              } else {
                                                showSnackBar(
                                                  context,
                                                  'Please add a workout set',
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                );
                                              }
                                            } else {
                                              showSnackBar(
                                                context,
                                                'Please enter exercise rest duration',
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                              );
                                            }
                                          } else {
                                            showSnackBar(
                                              context,
                                              'Please enter exercise duration',
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                            );
                                          }
                                        } else {
                                          showSnackBar(
                                            context,
                                            'Please enter exercise plan description',
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
                                    } else {
                                      showSnackBar(
                                        context,
                                        'Please select a media file (Photo or Video)',
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                      );
                                    }
                                  }
                                } else {
                                  showSnackBar(
                                    context,
                                    'Please add a workout set type',
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                }
                              }
                            },
                            buttonHeight: HEIGHT_4,
                            dim: false,
                          )
                        : const SizedBox(),
                    SB_1H,
                  ],
                ),
              ),
            )),
      );
    });
  }

  List<File> _createPostImageFiles = [];

  _pickImagesFromGallery() async {
    Pickers.instance.pickFromGallery().then((path) {
      if (path != null) {
        setState(() {
          _createPostImageFiles = path;
        });
      }
    });
  }
}
