import 'dart:convert';
import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/views/add_superset_exercise_screen.dart';
import 'package:app/module/influencer/workout_programs/widgets/round_workout_title.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../utils/c_date_format.dart';
import '../../../../../more/widget/pop_alert_dialog.dart';
import '../../../../../widgets/choice_chip_widget.dart';
import '../../../../../widgets/dotted_container.dart';
import '../../../../../widgets/image_container.dart';
import '../../../../../widgets/saluk_textfield.dart';
import '../../../../../widgets/video_container.dart';
import '../../../../widgets/exercise_duration_dialog.dart';

class AddTimeBasedExercise extends StatefulWidget {
  final WorkOutModel? data;
  final bool? isEditable;

  const AddTimeBasedExercise({Key? key, this.data, this.isEditable})
      : super(key: key);

  @override
  State<AddTimeBasedExercise> createState() => _AddTimeBasedExerciseState();
}

class _AddTimeBasedExerciseState extends State<AddTimeBasedExercise> {
  int viewType = 1;
  final TextEditingController _titleController = TextEditingController();
  List<File> _createPostImageFiles = [];
  String? path;
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();
  String restDuration = '';
  String restDurationMin = '';

  @override
  void initState() {
    if ((widget.data?.timeDuration?.split(":").length ?? 0) > 1) {
      restDuration =
          "${widget.data?.timeDuration?.split(":")[1]}:${widget.data?.timeDuration?.split(":").last}";
      restDurationMin = "Mins";
    }
    if (widget.data?.title != null) {
      _titleController.text = widget.data?.title ?? '';
    }
    if (widget.data?.superSetImage != null) {
      _createPostImageFiles.add(File(widget.data?.superSetImage ?? ''));
    }
    if (widget.isEditable == true) {
      getRoundExercise();
    }
    super.initState();
  }

  _pickImage(String source, {CameraMediaType? mediaType}) async {
    path =
        await Pickers.instance.pickImage(source: source, mediaType: mediaType);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: "Time Based",
        result: true,
        body: BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
            bloc: circuitWorkOutCubit,
            listener: (context, state) {
              if (state is ExerciseError) {
                showSnackBar(
                  context,
                  state.message!,
                  textColor: Colors.white,
                );
              } else if (state is ExerciseLoaded) {}
            },
            builder: (context, state) {
              return SingleChildScrollView(
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
                    SizedBox(height: 8),
                    choiceChipWidget(context,
                        title: widget.data?.workoutType ?? '',
                        isIncomeSelected: true,
                        onSelected: (val) {}),
                    SizedBox(height: 12),
                    Text(
                      "Time Duration",
                      style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/access_time.svg',
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "$restDuration $restDurationMin",
                          style: labelTextStyle(context)?.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                        SB_1W,
                        InkWell(
                          onTap: () {
                            showRoundRestTimeDialog();
                          },
                          child: const Icon(
                            Icons.edit,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SalukTextField(
                      textEditingController: _titleController,
                      hintText: "",
                      enable: false,
                      labelText: "Time base title",
                    ),
                    SizedBox(
                      height: 24,
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
                                  _pickImage(Pickers.instance.sourceCamera,
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
                                isCloseShown: false,
                                file: _createPostImageFiles[0],
                                closeButton: () {
                                  setState(() {
                                    _createPostImageFiles = [];
                                  });
                                },
                              )
                            : ImageContainer(
                                path: _createPostImageFiles[0].path,
                                isCloseShown: false,
                                onClose: () =>
                                    setState(() => _createPostImageFiles = []),
                              ),
                    SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<CircuitWorkOutCubit, CircuitWorkOutState>(
                      bloc: circuitWorkOutCubit,
                      builder: (context, state) {
                        if (state is ExerciseLoading) {
                          return Center(
                            child: LinearProgressIndicator(),
                          );
                        } else if (state is RoundExerciseLoaded) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 20),
                            itemCount: state
                                .data!.responseDetails!.data![0].sets!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Sets data = state
                                  .data!.responseDetails!.data![0].sets![index];
                              return Column(
                                children: [
                                  RoundWorkoutTile(
                                    image: data.assetUrl,
                                    mediaType: data.assetType,
                                    callback: () async {
                                      bool exerciseAdded = await Navigator.push(
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
                                    keepTitleInCenter: true,
                                    description: data.title,
                                    exerciseType:
                                        getExerciseType(data.type, data.meta),
                                    exerciseValue: "",
                                  ),
                                  Visibility(
                                    visible: data.restTime != '',
                                    child: Align(
                                      child: Text(
                                        "${CDateFormat.convertTimeToMinsAndSec(data.restTime)} Rest Time",
                                        style: labelTextStyle(context)
                                            ?.copyWith(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SalukTransparentButton(
                      title: AppLocalisation.getTranslated(
                          context, LKAddExercises),
                      buttonWidth: defaultSize.screenWidth,
                      borderColor: PRIMARY_COLOR,
                      buttonColor: PRIMARY_COLOR,
                      onPressed: () async {
                        bool? exerciseAdded = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddSuperSetExerciseScreen(
                              data: widget.data,
                            ),
                          ),
                        );
                        if (exerciseAdded == true) {
                          getRoundExercise();
                        }
                      },
                      buttonHeight: HEIGHT_3,
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
                  ],
                ),
              );
            }),
      ),
    );
  }

  getRoundExercise() {
    circuitWorkOutCubit.getRoundExercises(
        id: widget.data!.exerciseId.toString());
  }

  updateTotalDuration() {
    circuitWorkOutCubit.updateTimebaseDuration(
        exerciseId: widget.data!.exerciseId,
        timebaseID: widget.data!.roundId,
        data: {'exerciseTime': "00:$restDuration"});
  }

  String getExerciseType(String? type, String? meta) {
    String value = '';

    if (type == "Reps") {
      value = json.decode(meta ?? '')["noOfReps"] ?? '';
    } else if (type == "Time") {
      value = json.decode(meta ?? '')["setTime"] ?? "";
    } else if (type == "Failure") {
      // value = "Failure";
    } else if (type == "Custom") {
      type = json.decode(meta ?? '')["exerciseType"] ?? '';
      value = json.decode(meta ?? '')["count"] ?? '';
    }

    return "$type $value";
  }

  showRoundRestTimeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExerciseDurationDialog(
            minutes: restDuration != null ? restDuration : null,
            heading: AppLocalisation.getTranslated(context, LKTotalDuration),
            onPressed: () {
              updateTotalDuration();
            },
            onChanged: (String value) {
              restDuration = value;
              setState(() {});
            },
            onChanged2: (String value) {
              restDurationMin = value;
              setState(() {});
            },
          );
        });
  }
}
