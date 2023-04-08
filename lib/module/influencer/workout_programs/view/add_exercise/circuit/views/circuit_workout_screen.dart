import 'dart:convert';
import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../widgets/bottom_button.dart';
import '../../../../model/workout_model.dart';
import '../../../../widgets/exercise_duration_dialog.dart';
import '../../../../widgets/round_workout_title.dart';
import 'add_exercise_round.dart';
import 'add_round.dart';
import 'timebased_workout_screen.dart';

class CircuitWorkOutScreen extends StatefulWidget {
  final bool? isEditScreen;
  final String? title;
  final String? description;
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  final int? exerciseID;
  final int? parent;
  final int? roundID;
  final String? workoutType;
  final bool? circuitScreen;
  final String? exerciseName;
  final String? restTime;
  final String? exerciseImage;
  final String? timeDuration;
  final bool? isTimebase;
  final bool? isTypeSelected;

  const CircuitWorkOutScreen({
    Key? key,
    this.title,
    required this.description,
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
    required this.parent,
    required this.restTime,
    this.isTypeSelected = true,
  }) : super(key: key);

  @override
  State<CircuitWorkOutScreen> createState() => _CircuitWorkOutScreenState();
}

class _CircuitWorkOutScreenState extends State<CircuitWorkOutScreen> {
  int viewType = 1;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<File> _createPostImageFiles = [];
  String? path;
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();
  WorkOutModel? data;
  String restDuration = '';
  String restDurationMin = '';

  ///there are 2 types:e.g
  /// "Rounds" and "Timebase"
  String? supersetType;
  int totalRoundsCount = 0;

  // variables for superset/circuit selection

  List<String> badges = [
    "Select",
    "Rounds",
    "Time Base",
  ];
  List<String> timeUnits = [
    "Mins",
  ];

  String? value = "Select";
  String? selectedTimeValue = "Mins";

  int numberOfRounds = 1;

  //for bottomsheet
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? persistentBottomSheetController;

  String exerciseRestTime = "";
  String exerciseRestTimeMin = "";

  String exerciseTotalTime = "";
  String exerciseTotalTimeMin = "";

  int parent = 0;
  String supersetTitle = "";
  String supersetDescription = "";
  int exerciseCount = 0;
  int supersetWorkoutDayId = 0;

  bool? enableUI = true;

  @override
  void initState() {
    // if (widget.isEditScreen == true && widget.roundID != null) {
    //   // getRoundExercise();
    // }
    if (widget.parent != null && widget.parent != 0) {
      parent = widget.parent!;
      circuitWorkOutCubit.getExercises(
          parent: widget.parent, workoutDayId: int.parse(widget.dayID!));
    } else {
      enableUI = false;
      parent = widget.exerciseID ?? 0;
      circuitWorkOutCubit.getExercises(
          parent: widget.parent, workoutDayId: int.parse(widget.dayID!));
      solukLog(logMsg: parent, logDetail: "parent and exercise id");
      solukLog(logMsg: widget.timeDuration);
      if (widget.timeDuration == null) {
        value = "Rounds";
      } else {
        value = "Time Base";
      }
    }

    _titleController.text = widget.exerciseName ?? '';
    if (widget.exerciseImage != null) {
      _createPostImageFiles.add(File(widget.exerciseImage ?? ''));
    }

    supersetTitle = widget.title ?? "";
    supersetDescription = widget.description ?? "";

    _descriptionController.text = supersetDescription;

    supersetWorkoutDayId = int.parse(widget.dayID!);

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

    if (widget.restTime != null) {
      // exerciseRestTime = solukFormatTime(widget.restTime!)["time"]!;
      exerciseRestTime = widget.restTime!;
    }

    super.initState();
  }

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
        key: scaffoldKey,
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
                  parent = state.data!.parent;
                  supersetTitle = state.data!.title;
                  supersetDescription = state.data!.description;
                  supersetWorkoutDayId = state.data!.workoutDayId;
                  solukLog(
                      logMsg: state.data!.id, logDetail: "exercise parent");
                  setState(() {});
                  // showModalBottomSheet<void>(
                  //     shape: const RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(25),
                  //           topRight: Radius.circular(25)),
                  //     ),
                  //     isScrollControlled: true,
                  //     context: context,
                  //     builder: (context) {
                  //       return FractionallySizedBox(
                  //         heightFactor: 0.93,
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(25),
                  //           child: AddExerciseRound(
                  //             exerciseId: state.data!.id,
                  //             title: state.data!.title,
                  //             description: state.data!.description,
                  //             data: data!,
                  //             totalRounds:
                  //                 value == "Rounds" ? numberOfRounds : -1,
                  //             // roundsList: const [],
                  //           ),
                  //         ),
                  //       );
                  //     }).then((v) {
                  //   print("refresh screen here");
                  //   if (parent != 0) {
                  //     circuitWorkOutCubit.getExercises(
                  //         parent: state.data!.id,
                  //         workoutDayId: state.data!.workoutDayId);
                  //   }
                  // });
                  setState(() {});
                  // Navigator.pop(context);
                  // showSupersetTypeSelectionDialog(state.data!.id);
                } else if (state is RoundsLoaded) {
                  if (supersetType == "Rounds") {
                    if (state.roundsList!.isNotEmpty) {
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
                    if (state.roundsList!.isNotEmpty) {
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
                          // getRoundExercise();
                        }
                      });
                    }
                  } else {
                    if (state.roundsList!.isNotEmpty) {
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
                          // getRoundExercise();
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
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.isTimebase == true) getExerciseTimeWidget(),
                    SalukTextField(
                      textEditingController: _titleController,
                      hintText: "",
                      labelText: "${widget.workoutType!} Title",
                      enable: widget.isEditScreen == false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SalukTextField(
                      textEditingController: _descriptionController,
                      maxLines: 6,
                      hintText: "",
                      labelText: AppLocalisation.getTranslated(
                          context, LKTypeInstructions),
                      enable: widget.isEditScreen == false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${widget.workoutType!} Type",
                      style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: HEIGHT_3,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: IgnorePointer(
                                ignoring: widget.isEditScreen == true,
                                child: Container(
                                  width: defaultSize.screenWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    border: Border.all(
                                      width: defaultSize.screenWidth * .003,
                                      color: PRIMARY_COLOR,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultSize.screenWidth * .03,
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: DropdownButton<String>(
                                    underline: const SizedBox(),
                                    style: labelTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        20,
                                      ),
                                    ),
                                    dropdownColor: DROPDOWN_BACKGROUND_COLOR,
                                    isExpanded: true,
                                    value: value ?? "",
                                    items: badges.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(value),
                                          ],
                                        ),
                                        onTap: () {},
                                      );
                                    }).toList(),
                                    onChanged: (_) {
                                      if (_ != null && _.isNotEmpty) {
                                        setState(() {
                                          value = _;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              )),
                        ),
                        value == 'Rounds' ? SB_1H : const SizedBox(),
                        value == 'Rounds'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalisation.getTranslated(
                                        context, LKNumberofRounds),
                                    style: subTitleTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  IgnorePointer(
                                    ignoring: widget.isEditScreen == true,
                                    child: Container(
                                      width: WIDTH_6 * 1.8,
                                      height: HEIGHT_3,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0)),
                                        color: SCAFFOLD_BACKGROUND_COLOR,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: WIDTH_5 * 1.1,
                                            height: HEIGHT_3,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  topRight:
                                                      Radius.circular(10.0)),
                                              color: PRIMARY_COLOR,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                if (numberOfRounds != 1) {
                                                  setState(() {
                                                    numberOfRounds--;
                                                  });
                                                }
                                              },
                                              child: Center(
                                                child: Text(
                                                  '-',
                                                  style: labelTextStyle(context)
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '$numberOfRounds',
                                            style: labelTextStyle(context)
                                                ?.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            width: WIDTH_5 * 1.1,
                                            height: HEIGHT_3,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  topRight:
                                                      Radius.circular(10.0)),
                                              color: PRIMARY_COLOR,
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  numberOfRounds++;
                                                });
                                              },
                                              child: Center(
                                                child: Text(
                                                  '+',
                                                  style: labelTextStyle(context)
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 25),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        value == 'Rounds' ? SB_1H : const SizedBox(),
                        value == 'Time Base' ? SB_1H : const SizedBox(),
                        value == 'Time Base'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  exerciseTotalTime == ''
                                      ? Expanded(
                                          child: SalukTransparentButton(
                                            title:
                                                AppLocalisation.getTranslated(
                                                    context, LKTotalDuration),
                                            // buttonWidth: defaultSize.screenWidth,
                                            borderColor: PRIMARY_COLOR,
                                            textColor: PRIMARY_COLOR,

                                            onPressed: () {
                                              if (widget.isEditScreen == true) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return ExerciseDurationDialog(
                                                        heading: AppLocalisation
                                                            .getTranslated(
                                                                context,
                                                                LKTotalDuration),
                                                        onChanged:
                                                            (String value) {
                                                          exerciseTotalTime =
                                                              value;
                                                          setState(() {});
                                                        },
                                                        onChanged2:
                                                            (String value) {
                                                          exerciseTotalTimeMin =
                                                              value;
                                                          setState(() {});
                                                        },
                                                      );
                                                    });
                                              }
                                            },
                                            buttonHeight: HEIGHT_3,
                                            style: labelTextStyle(context)
                                                ?.copyWith(
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
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalisation.getTranslated(
                                                  context, LKTotalDuration),
                                              style: subTitleTextStyle(context)
                                                  ?.copyWith(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.timer_outlined),
                                                SB_1W,
                                                Text(
                                                  '$exerciseTotalTime $exerciseTotalTimeMin',
                                                  style: labelTextStyle(context)
                                                      ?.copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                SB_1W,
                                                InkWell(
                                                  onTap: () {
                                                    if (widget.isEditScreen ==
                                                        true) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return ExerciseDurationDialog(
                                                              minutes:
                                                                  exerciseTotalTime,
                                                              heading: AppLocalisation
                                                                  .getTranslated(
                                                                      context,
                                                                      LKAddRestTime),
                                                              onChanged: (String
                                                                  value) {
                                                                exerciseTotalTime =
                                                                    value;
                                                                setState(() {});
                                                              },
                                                              onChanged2:
                                                                  (String
                                                                      value) {
                                                                exerciseTotalTimeMin =
                                                                    value;
                                                                setState(() {});
                                                              },
                                                            );
                                                          });
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: PRIMARY_COLOR,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                ],
                              )
                            : const SizedBox(),
                        value == 'Time Base' ? SB_1H : const SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: value == "Select" ? 20 : 0,
                    ),
                    Text(
                      AppLocalisation.getTranslated(
                          context, LKExerciseRestTime),
                      style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    exerciseRestTime == ''
                        ? SalukTransparentButton(
                            title: AppLocalisation.getTranslated(
                                context, LKAddRestTime),
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
                                        exerciseRestTime = value;
                                        setState(() {});
                                      },
                                      onChanged2: (String value) {
                                        exerciseRestTimeMin = value;
                                        setState(() {});
                                      },
                                    );
                                  });
                            },
                            buttonHeight: HEIGHT_3,
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
                              const Icon(Icons.alarm),
                              SB_1W,
                              Text(
                                '$exerciseRestTime $exerciseRestTimeMin',
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
                                          minutes: exerciseRestTime,
                                          heading:
                                              AppLocalisation.getTranslated(
                                                  context, LKAddRestTime),
                                          onChanged: (String value) {
                                            exerciseRestTime = value;
                                            setState(() {});
                                          },
                                          onChanged2: (String value) {
                                            exerciseRestTimeMin = value;
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
                    BlocBuilder<CircuitWorkOutCubit, CircuitWorkOutState>(
                      bloc: circuitWorkOutCubit,
                      builder: (context, state) {
                        if (state is ExerciseLoading) {
                          return const Center(
                            child: LinearProgressIndicator(),
                          );
                        } else if (state is RoundExerciseLoaded) {
                          solukLog(
                              logMsg:
                                  state.data!.responseDetails!.data![0].title,
                              logDetail: "iininininin");
                          // return Text("exercise");
                          // List<SubType>? list = state.data!.responseDetails?.data
                          //     ?.firstWhere(
                          //         (element) => element.id == widget.exerciseID)
                          //     .subtypes;
                          // List<SubType>? list;

                          // List<Sets>? sets;
                          // = state.data!.responseDetails?.data
                          //     ?.firstWhere(
                          //         (element) => element.id == widget.exerciseID)
                          //     .sets;

                          totalRoundsCount = 0;
                          exerciseCount =
                              state.data!.responseDetails!.data!.length;
                          // circuitWorkOutCubit.updateExerciseCount(
                          //     state.data!.responseDetails!.data!.length);

                          // return Text("haha");
                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                AppLocalisation.getTranslated(
                                    context, LKExercises),
                                style: subTitleTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    state.data!.responseDetails!.data!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  // return Text(
                                  //     "${state.data!.responseDetails!.data![index].title}");
                                  // SubType subtype = list![index];
                                  // int? setCount = sets
                                  //     ?.where((element) =>
                                  //         element.subTypeId == subtype.id)
                                  //     .length;
                                  String roundLabel = "";
                                  String type = state.data!.responseDetails!
                                      .data![index].sets![0].type!;

                                  String key = "";

                                  try {
                                    if (type == "Time") {
                                      key = "setTime";
                                    } else if (type == "Reps") {
                                      key = "noOfReps";
                                    } else if (type == "Failure") {
                                      key = "failure";
                                    } else if (type == "Custom") {
                                      key = "count";
                                      type = json.decode(state
                                          .data!
                                          .responseDetails!
                                          .data![index]
                                          .sets![0]
                                          .meta!)["exerciseType"];
                                    }

                                    for (int i = 0;
                                        i <
                                            state.data!.responseDetails!
                                                .data![index].sets!.length;
                                        i++) {
                                      if (i == 0) {
                                        roundLabel += json
                                            .decode(state
                                                .data!
                                                .responseDetails!
                                                .data![index]
                                                .sets![0]
                                                .meta!)[key]
                                            .toString();
                                      } else {
                                        roundLabel +=
                                            "-${json.decode(state.data!.responseDetails!.data![index].sets![0].meta!)[key].toString()}";
                                      }
                                      print("$roundLabel $type");
                                    }
                                    print("$roundLabel $type");
                                  } catch (e) {
                                    print(e);
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RoundWorkoutTile(
                                        image: state.data!.responseDetails!
                                            .data![index].assetUrl,
                                        keepTitleInCenter: true,
                                        isRoundTile: true,
                                        callback: () async {
                                          // print(state.data!.responseDetails!
                                          //     .data![index].sets![0].meta);
                                          // data?.roundId = list[index].id;
                                          // data?.isCircuit =
                                          //     widget.circuitScreen == true;
                                          // bool exerciseAdded = await Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (_) => AddRound(
                                          //       data: data!,
                                          //       restTime: subtype.restTime,
                                          //       title: "Round ${index + 1}",
                                          //     ),
                                          //   ),
                                          // );
                                          // if (exerciseAdded) {
                                          //   getRoundExercise();
                                          // }
                                        },
                                        description: state
                                            .data!
                                            .responseDetails!
                                            .data![index]
                                            .title,
                                        // description: "${list[index].id",
                                        // exerciseType:
                                        //     "${state.data!.responseDetails!.data![index].sets!.length} Sets",
                                        exerciseType: "$roundLabel $type",
                                        exerciseValue: "",
                                      ),
                                      // Visibility(
                                      //   // visible: subtype.restTime != null,
                                      //   child: Text(
                                      //     "${CDateFormat.convertTimeToMinsAndSec(state.data!.responseDetails!.data![index].restTime)}  Round ${index + 1} Rest Time",
                                      //     style:
                                      //         labelTextStyle(context)?.copyWith(
                                      //       color: Colors.black,
                                      //       fontWeight: FontWeight.w400,
                                      //       fontSize: 12.sp,
                                      //     ),
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 20,
                                      // )
                                    ],
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                );
              }),
        ),
        bottomNavigationBar: parent == 0 && exerciseCount == 0
            ? SizedBox(
                // height: 10.h,
                child: BottomAppBar(
                  child: SalukBottomButton(
                    title: "CREATE",
                    isButtonDisabled: false,
                    callback: () async {
                      await addSuperSetApiCall();
                      //FOR DEBUG
                      // showModalBottomSheet<void>(
                      //     shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(25),
                      //           topRight: Radius.circular(25)),
                      //     ),
                      //     isScrollControlled: true,
                      //     context: context,
                      //     builder: (context) {
                      //       return FractionallySizedBox(
                      //         heightFactor: 0.93,
                      //         child: ClipRRect(
                      //           borderRadius: BorderRadius.circular(25),
                      //           child: AddExerciseRound(
                      //             title: "Add Exercise",
                      //             data: data!,
                      //             totalRounds:
                      //                 value == "Rounds" ? numberOfRounds : -1,
                      //             roundsList: [],
                      //             exerciseId: 0,
                      //           ),
                      //         ),
                      //       );
                      //     }).then((v) {
                      //   print("refresh screen here");
                      // });
                    },
                  ),
                ),
              )
            : Visibility(
                visible: widget.workoutType == "Supersets" && exerciseCount >= 2
                    ? false
                    : true,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: SalukTransparentButton(
                    title:
                        AppLocalisation.getTranslated(context, LKAddExercises),
                    buttonWidth: defaultSize.screenWidth,
                    borderColor: PRIMARY_COLOR,
                    textColor: SCAFFOLD_BACKGROUND_COLOR,
                    buttonColor: PRIMARY_COLOR,
                    onPressed: () {
                      if (widget.workoutType == "Supersets" &&
                          exerciseCount >= 2) {
                        showSnackBar(
                          context,
                          'Can\'t add more than 2 sets in Superset',
                          textColor: Colors.white,
                        );
                      } else {
                        // print(parent);
                        // print(widget.dayID);
                        // return;
                        showModalBottomSheet<void>(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                            ),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return FractionallySizedBox(
                                heightFactor: 0.93,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: AddExerciseRound(
                                    exerciseId: parent,
                                    title: supersetTitle,
                                    description: supersetDescription == ""
                                        ? _descriptionController.text
                                        : supersetDescription,
                                    data: data!,
                                    totalRounds:
                                        value == "Rounds" ? numberOfRounds : -1,
                                    // roundsList: const [],
                                  ),
                                ),
                              );
                            }).then((v) {
                          print("refresh screen here");
                          if (parent != 0) {
                            circuitWorkOutCubit.getExercises(
                                parent: parent,
                                workoutDayId: supersetWorkoutDayId);
                          }
                        });
                      }
                    },
                    buttonHeight: HEIGHT_3,
                    style: labelTextStyle(context)?.copyWith(
                      fontSize: 14.sp,
                      color: PRIMARY_COLOR,
                    ),
                    icon: const Icon(
                      Icons.add_circle,
                      color: SCAFFOLD_BACKGROUND_COLOR,
                    ),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                )));
  }

  addSuperSetApiCall() async {
    if (_titleController.text != "") {
      if (_descriptionController.text != "") {
        if (exerciseRestTime != "") {
          if (value != "Select") {
            if (value == "Time Base" && exerciseTotalTime == "") {
              showSnackBar(
                context,
                'Please add time for Superset Type',
                textColor: Colors.white,
              );
            } else {
              AddExerciseSingleWTimeRequestModel requestData =
                  AddExerciseSingleWTimeRequestModel(
                      workoutTitle: _titleController.text,
                      restTime: '$exerciseRestTime$exerciseRestTimeMin',
                      exerciseTime: '$exerciseTotalTime$exerciseTotalTimeMin',
                      workoutID: widget.workoutID!,
                      weekID: widget.weekID!,
                      dayID: widget.dayID!,
                      description: _descriptionController.text);

              return await circuitWorkOutCubit.addSuperSet(
                  exerciseRequestModel: requestData,
                  isCircuit: widget.circuitScreen,
                  workoutSubType: value == "Rounds" ? "round" : "time",
                  numberOfRounds: numberOfRounds);
            }
          } else {
            showSnackBar(
              context,
              'Please select Superset Type',
              textColor: Colors.white,
            );
          }
        } else {
          showSnackBar(
            context,
            'Please enter rest time',
            textColor: Colors.white,
          );
        }
      } else {
        showSnackBar(
          context,
          'Please enter intructions',
          textColor: Colors.white,
        );
      }
    } else {
      showSnackBar(
        context,
        'Please enter Superset name',
        textColor: Colors.white,
      );
    }
  }

  addRound() {
    if (data != null) {
      circuitWorkOutCubit.addRounds(data: {"count": 1}, exerciseData: data);
    }
  }

  getRoundExercise() {
    circuitWorkOutCubit.getRoundExercises(id: widget.dayID, withRounds: true);
  }

  Widget getExerciseTimeWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Text(
          "Time Duration",
          style: subTitleTextStyle(context)?.copyWith(
            color: Colors.black,
            fontSize: 14.sp,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/svgs/access_time.svg',
              height: 25,
              width: 25,
            ),
            const SizedBox(
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
        const SizedBox(
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
            minutes: restDuration,
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
