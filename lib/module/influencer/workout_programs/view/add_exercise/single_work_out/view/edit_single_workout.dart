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

class EditSingleWorkOutScreen extends StatefulWidget {
  final bool? isEditScreen;
  final String? title;
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  const EditSingleWorkOutScreen(
      {Key? key,
      this.title,
      this.isEditScreen = false,
      this.weekID,
      this.workoutID,
      this.dayID})
      : super(key: key);

  @override
  State<EditSingleWorkOutScreen> createState() =>
      _EditSingleWorkOutScreenState();
}

class _EditSingleWorkOutScreenState extends State<EditSingleWorkOutScreen> {
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
  SingleWorkOutCubit _singleWorkOutCubit = SingleWorkOutCubit();
  @override
  void initState() {
    ///TODO SET DATA HERE FOR EDIT
    super.initState();
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
                SizedBox(
                  height: 20,
                ),
                SalukTextField(
                  textEditingController: _titleController,
                  hintText: "",
                  labelText:
                      AppLocalisation.getTranslated(context, LKExerciseName),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalisation.getTranslated(context, LKExerciseTime),
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
                ),
                SizedBox(
                  height: 10,
                ),
                singleWExerciseDuration == ''
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
                                  heading: AppLocalisation.getTranslated(
                                      context, LKAddExerciseTime),
                                  onChanged: (value) {
                                    singleWExerciseDuration = value;
                                    setState(() {});
                                    // _workoutProgramBloc.add(SetStateEvent());
                                  },
                                  onChanged2: (String value) {
                                    singleWExerciseDurationMin = value;
                                    setState(() {});
                                    // _workoutProgramBloc.add(SetStateEvent());
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
                                      heading: AppLocalisation.getTranslated(
                                          context, LKAddExerciseTime),
                                      onChanged: (value) {
                                        // singleWExerciseDuration = value;
                                        // _workoutProgramBloc.add(SetStateEvent());
                                      },
                                      onChanged2: (String value) {
                                        // singleWExerciseDurationMin = value;
                                        // _workoutProgramBloc.add(SetStateEvent());
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
                      ),
                SizedBox(
                  height: 20,
                ),
                _createPostImageFiles.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          popUpAlertDialog(
                            context,
                            'Pick Image',
                            LKImageDialogDetail,
                            isProfile: true,
                            onCameraTap: (type) {
                              // _pickImage(ImageSource.camera);
                              _pickImage(Pickers.instance.sourceCamera,
                                  type: type);
                            },
                            onGalleryTap: () {
                              _pickImagesFromGallery();
                            },
                          );
                        },
                        child: const MediaTypeSelectionCard())
                    : _createPostImageFiles[0].path.contains("mp4")
                        ? VideoContainer(
                            closeButton: () {
                              setState(() {
                                _createPostImageFiles = [];
                              });
                            },
                          )
                        : ImageContainer(
                            path: _createPostImageFiles[0].path,
                            onClose: () =>
                                setState(() => _createPostImageFiles = []),
                          ),
                SizedBox(
                  height: 20,
                ),
                SalukTextField(
                    textEditingController: _descriptionController,
                    maxLines: 6,
                    hintText: "",
                    labelText: AppLocalisation.getTranslated(
                        context, LKTypeInstructions)),
                SizedBox(
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
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    print("set no :$workoutSetsNumber");
                                    workoutSetsNumber++;
                                    return AddWorkoutSetsDialog(
                                        selectedType: workoutSetsType,
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
                                              exerciseType: exerciseTypeCustom,
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
                                                    noOfReps: workoutSetsValue,
                                                    dropSet: value == 'Y'
                                                        ? true
                                                        : false));
                                            setState(() {});
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
                ),
                SizedBox(
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
                              itemBuilder: (BuildContext context, int index) {
                                return WorkoutSetsTile(
                                  titleColor: Colors.black,
                                  titleDetailColor: workoutSetsType == 'Reps'
                                      ? addExerciseRepsRequestModelList[index]
                                                  .dropSet ==
                                              true
                                          ? PRIMARY_COLOR
                                          : Colors.black
                                      : Colors.black,
                                  title: workoutSetsType == 'Time'
                                      ? workoutSetsRequestModelList[index].title
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
                                          workoutSetsRequestModelList[index]
                                              .setTime +
                                          ' ' +
                                          workoutSetsRequestModelList[index]
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
                                          workoutSetsRequestModelList[index]);
                                      workoutSetsNumber = index;
                                    } else if (workoutSetsType == 'Failure') {
                                      workoutSetsFailureRequestModelList.remove(
                                          workoutSetsFailureRequestModelList[
                                              index]);
                                      workoutSetsNumber = index;
                                    } else if (workoutSetsType == 'Reps') {
                                      addExerciseRepsRequestModelList.remove(
                                          addExerciseRepsRequestModelList[
                                              index]);
                                      print("index : $index");
                                      workoutSetsNumber = index;
                                    } else if (workoutSetsType == 'Custom') {
                                      addExerciseCustomRequestModelList.remove(
                                          addExerciseCustomRequestModelList[
                                              index]);
                                      workoutSetsNumber = index;
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: defaultSize.screenWidth,
                  color: PIN_FIELD_COLOR,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalisation.getTranslated(context, LKExerciseRestTime),
                  style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
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
                                  },
                                  onChanged2: (String value) {
                                    singleWRestDurationMin = value;
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
                            singleWRestDuration + ' ' + singleWRestDurationMin,
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
                            child: const Icon(
                              Icons.edit,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                SizedBox(
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

  _pickImage(String source, {CameraMediaType? type}) async {
    path = await Pickers.instance.pickImage(source: source, mediaType: type);
    print("image path :$path");
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

  addSingleWorkOutExercise(String workoutType) {
    if (_titleController.text != "") {
      if (singleWExerciseDuration != '') {
        if (_createPostImageFiles.isNotEmpty) {
          if (_descriptionController.text != '') {
            if (singleWRestDuration != '') {
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

  callApi(workOutType) {
    var isApiCalled = false;
    addExerciseSingleWTimeRequestModel = AddExerciseSingleWTimeRequestModel(
        media: _createPostImageFiles[0],
        assetType:
            _createPostImageFiles[0].path.contains('mp4') ? 'video' : 'image',
        workoutTitle: _titleController.text,
        description: _descriptionController.text,
        exerciseTime: '00:' + singleWExerciseDuration,
        //singleWExerciseDuration,
        restTime: '00:' + singleWRestDuration,
        //singleWRestDuration,
        workoutID: widget.workoutID!,
        weekID: widget.weekID!,
        dayID: widget.dayID!);
    switch (workOutType) {
      case "Time":
        showMediaUploadDialog();
        _singleWorkOutCubit.addSingleWorkOutExercise(
            addExerciseSingleWTimeRequestModel:
                addExerciseSingleWTimeRequestModel!,
            workoutSetsList: workoutSetsRequestModelList);
        break;
      case "Reps":
        showMediaUploadDialog();
        _singleWorkOutCubit.addSingleWorkOutExercise(
            addExerciseSingleWTimeRequestModel:
                addExerciseSingleWTimeRequestModel!,
            workoutSetsList: addExerciseRepsRequestModelList);
        break;

      case "Failure":
        showMediaUploadDialog();
        _singleWorkOutCubit.addSingleWorkOutExercise(
            addExerciseSingleWTimeRequestModel:
                addExerciseSingleWTimeRequestModel!,
            workoutSetsList: workoutSetsFailureRequestModelList);
        break;
      case "Custom":
        showMediaUploadDialog();
        _singleWorkOutCubit.addSingleWorkOutExercise(
            addExerciseSingleWTimeRequestModel:
                addExerciseSingleWTimeRequestModel!,
            workoutSetsList: addExerciseCustomRequestModelList);
        break;
      default:
        showSnackBar(
          context,
          'Please add a workout set to continue',
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
