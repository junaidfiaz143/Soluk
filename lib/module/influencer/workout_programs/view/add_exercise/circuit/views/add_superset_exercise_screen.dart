import 'dart:convert';
import 'dart:io';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/widgets/video_container.dart';
import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/round_exercise_request_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/views/widgets/exercise_tile.dart';
import 'package:app/module/influencer/workout_programs/widgets/add_workout_sets_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/exercise_duration_dialog.dart';
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

class AddSuperSetExerciseScreen extends StatefulWidget {
  final WorkOutModel? data;
  final Sets? exerciseData;
  final List<int?>? duplicateRoundIds;

  const AddSuperSetExerciseScreen(
      {Key? key, this.data, this.exerciseData, this.duplicateRoundIds})
      : super(key: key);

  @override
  State<AddSuperSetExerciseScreen> createState() =>
      _AddSuperSetExerciseScreenState();
}

class _AddSuperSetExerciseScreenState extends State<AddSuperSetExerciseScreen> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();
  List<File> _createPostImageFiles = [];
  String exerciseType = '';
  String workoutSetsType = '';
  String workoutSetsValue = '';
  String exerciseTypeCustom = '';
  String singleWRestDuration = '';
  String singleWRestDurationMin = '';
  String singleWExerciseDuration = '';
  String? path;
  bool? isDropSet;
  bool? isTimeBase;
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();

  _pickImage(String source, {CameraMediaType? type}) async {
    path = await Pickers.instance.pickImage(source: source, mediaType: type);
    print("image path :$path");
    if (path != null) {
      setState(() {
        _createPostImageFiles.add(File(path!));
      });
    }
  }

  @override
  initState() {
    _titleController.text = widget.exerciseData?.title ?? '';
    _descriptionController.text = widget.exerciseData?.instructions ?? '';
    workoutSetsType = widget.exerciseData?.type ?? '';
    if (widget.exerciseData?.assetUrl != "" &&
        widget.exerciseData?.assetUrl != null)
      _createPostImageFiles.add(File(widget.exerciseData?.assetUrl ?? ''));
    if (widget.exerciseData?.restTime != '') {
      singleWRestDuration = widget.exerciseData?.restTime ?? '';
    }

    if (widget.exerciseData?.type == "Reps") {
      workoutSetsValue =
          json.decode(widget.exerciseData?.meta ?? '')["noOfReps"] ?? '';
      isDropSet =
          json.decode(widget.exerciseData?.meta ?? '')["dropSet"] == 'true';
    } else if (widget.exerciseData?.type == "Time") {
      workoutSetsValue =
          json.decode(widget.exerciseData?.meta ?? '')["setTime"] ?? "";
    } else if (widget.exerciseData?.type == "Failure") {
      workoutSetsValue = "Failure";
    } else if (widget.exerciseData?.type == "Custom") {
      exerciseType =
          json.decode(widget.exerciseData?.meta ?? '')["exerciseType"] ?? '';
      workoutSetsValue =
          json.decode(widget.exerciseData?.meta ?? '')["count"] ?? '';
    }
    isTimeBase = widget.data!.workoutType == "Time Based";
    print("duplicate Ids: ${widget.duplicateRoundIds}");
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
          title: "Add Exercise",
          body: BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
              listener: (context, state) {
                if (state is ExerciseError) {
                  showSnackBar(
                    context,
                    state.message!,
                    textColor: Colors.white,
                  );
                }
              },
              bloc: circuitWorkOutCubit,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SalukTextField(
                        textEditingController: _titleController,
                        hintText: "",
                        labelText: "Exercise Title",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _createPostImageFiles.isEmpty
                          ? GestureDetector(onTap: () {
                              popUpAlertDialog(
                                context,
                                'Pick Image',
                                LKImageDialogDetail,
                                isProfile: true,
                                onCameraTap: (type) {
                                  // _pickImage(ImageSource.camera);
                                  Pickers.instance
                                      .pickImage(mediaType: type)
                                      .then((value) {
                                    if (value != null) {
                                      _createPostImageFiles.add(File(value));
                                    }
                                  });
                                },
                                onGalleryTap: () {
                                  // _pickImagesFromGallery();
                                  Pickers.instance
                                      .pickFromGallery()
                                      .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _createPostImageFiles = value;
                                      });
                                    }
                                  });
                                },
                              );
                            }, child: MediaTypeSelectionCard(
                              callback: () {
                                popUpAlertDialog(
                                  context,
                                  'Pick Image',
                                  LKImageDialogDetail,
                                  isProfile: true,
                                  onCameraTap: (type) {
                                    _pickImage(Pickers.instance.sourceCamera,
                                        type: type);
                                  },
                                  onGalleryTap: () {
                                    _pickImagesFromGallery();
                                  },
                                );
                              },
                            ))
                          : _createPostImageFiles[0].path.contains("mp4")
                              ? VideoContainer(
                                  file: _createPostImageFiles[0],
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
                      Text(
                        "Exercise Type",
                        style: subTitleTextStyle(context)?.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      workoutSetsType == ""
                          ? SalukTransparentButton(
                              title: "Add",
                              buttonWidth: defaultSize.screenWidth,
                              borderColor: PRIMARY_COLOR,
                              textColor: PRIMARY_COLOR,
                              onPressed: () {
                                showExerciseDialog();
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
                          : ExerciseTile(
                              titleColor: Colors.black,
                              titleDetailColor: Colors.black,
                              title: workoutSetsType,
                              titleDetail: workoutSetsValue == "Failure"
                                  ? ''
                                  : workoutSetsValue,
                              onEditPress: () {
                                showExerciseDialog();
                              },
                              onDeletePress: () {
                                setState(() {
                                  workoutSetsType = '';
                                  workoutSetsValue = '';
                                });
                                // _workoutProgramBloc.add(SetStateEvent());
                              },
                            ),
                      isTimeBase == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppLocalisation.getTranslated(
                                      context, LKExerciseRestTime),
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
                                                  heading: AppLocalisation
                                                      .getTranslated(context,
                                                          LKAddRestTime),
                                                  onChanged: (String value) {
                                                    singleWRestDuration = value;
                                                    setState(() {});
                                                  },
                                                  onChanged2: (String value) {
                                                    singleWRestDurationMin =
                                                        value;
                                                    setState(() {});
                                                  },
                                                );
                                              });
                                        },
                                        buttonHeight: HEIGHT_4,
                                        style:
                                            labelTextStyle(context)?.copyWith(
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
                                            style: labelTextStyle(context)
                                                ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          SB_1W,
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ExerciseDurationDialog(
                                                      heading: AppLocalisation
                                                          .getTranslated(
                                                              context,
                                                              LKAddRestTime),
                                                      onChanged:
                                                          (String value) {
                                                        singleWRestDuration =
                                                            value;
                                                        setState(() {});
                                                      },
                                                      onChanged2:
                                                          (String value) {
                                                        singleWRestDurationMin =
                                                            value;
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
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                );
              })),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
            title: AppLocalisation.getTranslated(context, LKSubmit),
            callback: () async {
              // addExerciseApi();
            },
            isButtonDisabled: false),
      ),
    );
  }

  addExerciseApi() async {
    if (_titleController.text != "") {
      if (_createPostImageFiles.isNotEmpty) {
        if (_descriptionController.text != '') {
          if (workoutSetsValue != '') {
            if (isTimeBase == true) {
              if (singleWRestDuration == '') {
                showSnackBar(
                  context,
                  'Please add exercise rest time',
                  textColor: Colors.white,
                );
                return;
              }
            }

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

            RoundExerciseRequest requestData = RoundExerciseRequest(
                media: _createPostImageFiles[0],
                assetType: _createPostImageFiles[0].path.contains('mp4')
                    ? 'video'
                    : 'image',
                workoutTitle: _titleController.text,
                description: _descriptionController.text,
                restTime: '00:' + singleWRestDuration,
                isTimeBaseExercise: isTimeBase == true,
                exerciseType: workoutSetsType,
                exerciseValue: workoutSetsValue,
                dropSet: isDropSet,
                exerciseId: widget.data!.exerciseId,
                roundId: widget.data!.roundId!,
                exerciseCustomValue: workoutSetsValue
                //singleWRestDuration,
                );
            print("round exercise type : ${requestData.exerciseType!}");
            print("round exercise value : ${workoutSetsValue}");
            print("round media file : ${requestData.media}");
            bool done = await circuitWorkOutCubit.addRoundsExercise(
                exerciseData: requestData,
                setID: widget.exerciseData?.id,
                duplicateRoundIds: widget.duplicateRoundIds);
            if (done) {
              Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);
            }
          } else {
            showSnackBar(
              context,
              'Please add exercise type',
              textColor: Colors.white,
            );
          }
        } else {
          showSnackBar(
            context,
            'Please enter exercise instructions',
            textColor: Colors.white,
          );
        }
      } else {
        showSnackBar(
          context,
          'Please add image or video',
          textColor: Colors.white,
        );
      }
    } else {
      showSnackBar(
        context,
        'Please enter a title of exercise',
        textColor: Colors.white,
      );
    }
  }

  showExerciseDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddWorkoutSetsDialog(
              selectedType: workoutSetsType,
              typeReadonly: workoutSetsType.isNotEmpty ? true : false,
              selectedNoOfReps: workoutSetsValue,
              dropSet: isDropSet,
              customSetCount: exerciseTypeCustom,
              customSetName: workoutSetsType == "Custom"
                  ? workoutSetsValue.split("  ")[1]
                  : '',
              selectedTime: workoutSetsValue,
              onChanged: (value) {
                workoutSetsType = value;
                setState(() {});
              },
              onChanged1: (value) {
                //workoutSetsType = value;
                workoutSetsValue = value;
                setState(() {});
              },
              onChanged2: (value) {
                workoutSetsValue = value;
                print(workoutSetsValue);
                if (workoutSetsType == 'Time') {
                  //workoutSetsType = "time";
                  setState(() {});
                } else if (workoutSetsType == 'Custom') {
                  exerciseTypeCustom = value;
                  setState(() {});
                }
              },
              onChanged3: (value) {
                if (workoutSetsType == 'Custom') {
                  workoutSetsValue = "$workoutSetsValue  $value";
                  setState(() {});
                } else if (workoutSetsType == 'Reps') {
                  isDropSet = value == 'Y' ? true : false;
                  setState(() {});
                }
              });
        });
  }
}
