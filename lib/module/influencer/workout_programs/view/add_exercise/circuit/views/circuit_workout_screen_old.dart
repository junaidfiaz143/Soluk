import 'dart:io';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/AddExerciseSingleWTimeRequestModel.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/widgets/superset_circuit_type_dialog.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/c_date_format.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../repo/repository/web_service.dart';
import '../../../../../more/widget/custom_alert_dialog.dart';
import '../../../../../widgets/media_upload_progress_popup.dart';
import '../../../../../widgets/video_container.dart';
import '../../../../model/get_all_exercise_response.dart';
import '../../../../model/workout_model.dart';
import '../../../../widgets/exercise_duration_dialog.dart';
import '../../../../widgets/round_workout_title.dart';
import 'add_round.dart';
import 'timebased_workout_screen.dart';

class CircuitWorkOutScreenOld extends StatefulWidget {
  final bool? isEditScreen;
  final String? title;
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  final int? exerciseID;
  final int? roundID;
  final String? workoutType;
  final bool? circuitScreen;
  final String? exerciseName;
  final String? exerciseImage;
  final String? timeDuration;
  final bool? isTimebase;
  final bool? isTypeSelected;

  const CircuitWorkOutScreenOld({
    Key? key,
    this.title,
    this.isEditScreen = false,
    this.weekID,
    this.workoutID,
    this.dayID,
    this.roundID,
    this.workoutType,
    this.circuitScreen = false,
    this.exerciseImage,
    this.exerciseName,
    this.isTimebase,
    this.timeDuration,
    this.exerciseID,
    this.isTypeSelected = true,
  }) : super(key: key);

  @override
  State<CircuitWorkOutScreenOld> createState() =>
      _CircuitWorkOutScreenOldState();
}

class _CircuitWorkOutScreenOldState extends State<CircuitWorkOutScreenOld> {
  int viewType = 1;
  final TextEditingController _titleController = TextEditingController();
  List<File> _createPostImageFiles = [];
  String? path;
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();
  WorkOutModel? data;
  String restDuration = '';
  String restDurationMin = '';

  ///there are 2 types:e.g
  /// "Rounds" and "Timebase"
  String? supersetType;
  int totalRoundsCount = 0;

  @override
  void initState() {
    if (widget.isEditScreen == true && widget.roundID != null)
      getRoundExercise();
    _titleController.text = widget.exerciseName ?? '';
    if (widget.exerciseImage != null)
      _createPostImageFiles.add(File(widget.exerciseImage ?? ''));

    if ((widget.timeDuration?.split(":").length ?? 0) > 1) {
      restDuration =
          "${widget.timeDuration?.split(":")[1]}:${widget.timeDuration?.split(":").last}";
      restDurationMin = "Mins";
    }
    data = WorkOutModel(
        title: 'Add Round',
        workoutType: "Rounds",
        numberOfRounds: 1,
        workoutID: widget.workoutID,
        weekID: widget.weekID,
        dayID: widget.dayID,
        isCircuit: false,
        exerciseId: widget.exerciseID);

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

  String? netImage;

  // _pickImage(ImageSource source) async {
  //   path = await Pickers.instance.pickImage(source: source);
  //   if (path != null) {
  //     setState(() {
  //       _createPostImageFiles.add(File(path!));
  //     });
  //   }
  // }
  showSupersetTypeSelectionDialog(int exerciseId) async {
    List<String?>? selectedSupersetType = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          data = WorkOutModel(
              workoutID: widget.workoutID,
              weekID: widget.weekID,
              dayID: widget.dayID,
              isCircuit: widget.circuitScreen,
              exerciseId: exerciseId);
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: SupersetCircuitTypeDialog(
                workoutID: widget.workoutID,
                weekID: widget.weekID,
                dayID: widget.dayID,
                isCircuit: widget.circuitScreen,
                exerciseId: exerciseId,
                supersetImage: _createPostImageFiles.first.path,
                title: _titleController.text),
          );
        });
    if (selectedSupersetType != null) {
      if (selectedSupersetType[0] == "Rounds") {
        supersetType = "Rounds";
        circuitWorkOutCubit.addRounds(
            data: {"count": selectedSupersetType[1]}, exerciseData: data);
      } else if (selectedSupersetType[0] == "Time Base") {
        supersetType = "Time Base";
        circuitWorkOutCubit.addTimebaseSuperSet(
            data: {'exerciseTime': "00:${selectedSupersetType[1]}"},
            exerciseData: data);
      } else {
        supersetType = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //change
    return Scaffold(
      body: AppBody(
        title: "Day Exercise",
        result: true,
        body: BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
            bloc: circuitWorkOutCubit,
            listener: (context, state) async {
              if (state is ExerciseError) {
                showSnackBar(
                  context,
                  state.message!,
                  textColor: Colors.white,
                );
              } else if (state is ExerciseLoaded) {
                Navigator.pop(context);
                showSupersetTypeSelectionDialog(state.data!.id);
              } else if (state is RoundsLoaded) {
                if (supersetType == "Rounds") {
                  if (state.roundsList!.length > 0) {
                    data!.roundId = state.roundsList![0].id;
                    data!.superSetImage = _createPostImageFiles.first.path;
                    data!.title = _titleController.text;
                    data!.workoutType = supersetType;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddRound(
                          data: data!,
                          roundsList: state.roundsList,
                        ),
                      ),
                    ).then((value) {
                      if (value != null && value == true) {
                        Navigator.pop(context, true);
                        // getRoundExercise();
                      }
                    });
                  }
                } else if (supersetType == "Time Base") {
                  if (state.roundsList!.length > 0) {
                    data!.timeDuration = state.roundsList![0].exerciseTime;
                    data!.roundId = state.roundsList![0].id;
                    data!.workoutType = supersetType;
                    data!.superSetImage = _createPostImageFiles.first.path;
                    data!.title = _titleController.text;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddTimeBasedExercise(
                          data: data!,
                        ),
                      ),
                    ).then((value) {
                      if (value != null && value == true) {
                        getRoundExercise();
                      }
                    });
                  }
                } else {
                  if (state.roundsList!.length > 0) {
                    data = WorkOutModel(
                        workoutID: widget.workoutID,
                        weekID: widget.weekID,
                        dayID: widget.dayID,
                        isCircuit: widget.circuitScreen,
                        exerciseId: widget.exerciseID);
                    data!.roundId = state.roundsList![0].id;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddRound(
                          data: data!,
                          roundsList: state.roundsList,
                          title: "Round ${totalRoundsCount + 1}",
                        ),
                      ),
                    ).then((value) {
                      if (value != null && value == true) {
                        getRoundExercise();
                      }
                    });
                  }
                }
              }
            },
            builder: (context, state) {
              return ListView(
                children: [
                  Text(
                    AppLocalisation.getTranslated(context, LKWorkoutType),
                    style: subTitleTextStyle(context)?.copyWith(
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: choiceChipWidget(context,
                          title: widget.workoutType!,
                          isIncomeSelected: true,
                          onSelected: (val) {}),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.isTimebase == true) getExerciseTimeWidget(),
                  SalukTextField(
                    textEditingController: _titleController,
                    hintText: "",
                    labelText: "Exercise Name",
                    enable: widget.isEditScreen == false,
                  ),
                  SizedBox(
                    height: 10,
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
                              netUrl: _createPostImageFiles[0].path,
                              isCloseShown: true,
                              closeButton: () {
                                setState(() {
                                  _createPostImageFiles = [];
                                });
                              },
                            )
                          // ? Stack(
                          //     alignment: Alignment.topRight,
                          //     children: [
                          //       Container(
                          //         height: HEIGHT_5 * 2,
                          //         width: double.maxFinite,
                          //         child: VideoPlayerWidget(
                          //           url: '',
                          //           file: _createPostImageFiles[0],
                          //           mediaTypeisLocalVideo: true,
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: InkWell(
                          //           onTap: () {
                          //             //Navigator.pop(context);
                          //             setState(() {
                          //               _createPostImageFiles.clear();
                          //             });
                          //           },
                          //           child: Container(
                          //             width: 20,
                          //             height: 20,
                          //             child: SvgPicture.asset(
                          //                 'assets/svgs/cross_icon.svg',
                          //                 height: 25,
                          //                 width: 25),
                          //             decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               color: Colors.grey.withOpacity(0.1),
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   )
                          : ImageContainer(
                              // isCloseShown: widget.isEditScreen == false,
                              // isCloseShown: widget.isEditScreen == false,
                              path: _createPostImageFiles[0].path,
                              onClose: () =>
                                  setState(() => _createPostImageFiles = []),
                            ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CircuitWorkOutCubit, CircuitWorkOutState>(
                    bloc: circuitWorkOutCubit,
                    builder: (context, state) {
                      if (state is ExerciseLoading) {
                        return Center(
                          child: LinearProgressIndicator(),
                        );
                      } else if (state is RoundExerciseLoaded) {
                        List<SubType>? list = state.data!.responseDetails?.data
                            ?.firstWhere(
                                (element) => element.id == widget.exerciseID)
                            .subtypes;
                        List<Sets>? sets = state.data!.responseDetails?.data
                            ?.firstWhere(
                                (element) => element.id == widget.exerciseID)
                            .sets;
                        totalRoundsCount = list?.length ?? 0;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: list?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            SubType subtype = list![index];
                            int? setCount = sets
                                ?.where((element) =>
                                    element.subTypeId == subtype.id)
                                .length;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RoundWorkoutTile(
                                  image: "",
                                  keepTitleInCenter: true,
                                  isRoundTile: true,
                                  callback: () async {
                                    data?.roundId = list[index].id;
                                    data?.isCircuit =
                                        widget.circuitScreen == true;
                                    bool exerciseAdded = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddRound(
                                          data: data!,
                                          restTime: subtype.restTime,
                                          title: "Round ${index + 1}",
                                        ),
                                      ),
                                    );
                                    if (exerciseAdded) {
                                      getRoundExercise();
                                    }
                                  },
                                  description: "Round ${index + 1}",
                                  // description: "${list[index].id",
                                  exerciseType: "$setCount Exercise",
                                  exerciseValue: "",
                                ),
                                Visibility(
                                  visible: subtype.restTime != null,
                                  child: Text(
                                    "${CDateFormat.convertTimeToMinsAndSec(subtype.restTime ?? '00:00')}  Round ${index + 1} Rest Time",
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
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
                        context,
                        (widget.isEditScreen == true &&
                                widget.isTypeSelected == true)
                            ? LKAddRounds
                            : LKAdd),
                    buttonWidth: defaultSize.screenWidth,
                    borderColor: PRIMARY_COLOR,
                    buttonColor: PRIMARY_COLOR,
                    onPressed: () {
                      if (widget.isTypeSelected == false) {
                        showSupersetTypeSelectionDialog(widget.exerciseID ?? 0);
                      } else {
                        if (widget.isEditScreen == true) {
                          addRound();
                        } else {
                          addSuperSetApiCall();
                        }
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
                  ),
                ],
              );
            }),
      ),
    );
  }

  addSuperSetApiCall() {
    if (_titleController.text != "") {
      if (_createPostImageFiles.isNotEmpty) {
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

        AddExerciseSingleWTimeRequestModel requestData =
            AddExerciseSingleWTimeRequestModel(
                media: _createPostImageFiles[0],
                assetType: _createPostImageFiles[0].path.contains('mp4')
                    ? 'video'
                    : 'image',
                workoutTitle: _titleController.text,
                restTime: '',
                workoutID: widget.workoutID!,
                weekID: widget.weekID!,
                dayID: widget.dayID!,
                description: '');

        circuitWorkOutCubit.addSuperSet(
            exerciseRequestModel: requestData, isCircuit: widget.circuitScreen);
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
        'Please enter Exercise Name',
        textColor: Colors.white,
      );
    }
  }

  addRound() {
    if (data != null)
      circuitWorkOutCubit.addRounds(data: {"count": 1}, exerciseData: data);
  }

  getRoundExercise() {
    circuitWorkOutCubit.getRoundExercises(id: widget.dayID, withRounds: true);
  }

  Widget getExerciseTimeWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        )
      ],
    );
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

  updateTotalDuration() {
    circuitWorkOutCubit.updateTimebaseDuration(
        exerciseId: widget.exerciseID,
        timebaseID: widget.roundID,
        data: {'exerciseTime': "00:$restDuration"});
  }
}
