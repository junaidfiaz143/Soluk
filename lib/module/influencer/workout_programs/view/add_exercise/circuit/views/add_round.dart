import 'dart:convert';

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
import 'package:app/module/influencer/workout_programs/widgets/exercise_duration_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/round_workout_title.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../model/get_all_exercise_response.dart';

class AddRound extends StatefulWidget {
  static const id = "AddRound";
  WorkOutModel data;
  String? title;
  String? restTime;
  final List<RoundsData>? roundsList;

  AddRound(
      {Key? key,
      required this.data,
      this.roundsList,
      this.title,
      this.restTime})
      : super(key: key);

  @override
  State<AddRound> createState() => _AddRoundState();
}

class _AddRoundState extends State<AddRound> {
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();
  String restDuration = '';
  String restDurationMin = '';
  RoundExerciseRequest? requestData;
  int roundExerciseList = 2;

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

  @override
  Widget build(BuildContext context) {
    print("round list : $roundExerciseList");
    return BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
        bloc: circuitWorkOutCubit,
        listener: (context, state) {
          if (state is LoadingState) {
          } else if (state is ExerciseError) {
            showSnackBar(
              context,
              state.message!,
              textColor: Colors.white,
            );
          } else if (state is RoundExerciseLoaded) {
            if (state.data!.responseDetails!.data != null) {
              solukLog(
                  logMsg: state.data!.responseDetails!.data!.length,
                  logDetail: "response data length inside add_round.dart");
              if (state.data!.responseDetails!.data!.length > 0) {
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
              Navigator.pop(context, true);
              return true;
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Scaffold(
                body: AppBody(
                    title: widget.title ?? "Round 1",
                    result: true,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            widget.data.isCircuit == true
                                ? const SizedBox()
                                : Text(
                                    AppLocalisation.getTranslated(
                                        context, LKYouCanAddMax2Exercise),
                                    style: subTitleTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                            (widget.data.isCircuit != true &&
                                    roundExerciseList >= 2)
                                ? SizedBox()
                                : SB_1H,
                            (widget.data.isCircuit != true &&
                                    roundExerciseList >= 2)
                                ? Container()
                                : SalukTransparentButton(
                                    title: AppLocalisation.getTranslated(
                                        context, LKAddExercises),
                                    buttonWidth: defaultSize.screenWidth,
                                    borderColor: PRIMARY_COLOR,
                                    buttonColor: PRIMARY_COLOR,
                                    onPressed: () async {
                                      bool exerciseAdded = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AddSuperSetExerciseScreen(
                                            data: widget.data,
                                            duplicateRoundIds: widget.roundsList
                                                ?.map((c) => c.id)
                                                .toList(),
                                          ),
                                        ),
                                      );
                                      if (exerciseAdded) {
                                        getRoundExercise();
                                      }
                                    },
                                    buttonHeight: HEIGHT_3,
                                    style: buttonTextStyle(context)?.copyWith(
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
                            SB_1H,
                            BlocBuilder<CircuitWorkOutCubit,
                                CircuitWorkOutState>(
                              bloc: circuitWorkOutCubit,
                              builder: (context, state) {
                                if (state is ExerciseLoading) {
                                  return Center(
                                    child: LinearProgressIndicator(),
                                  );
                                } else if (state is RoundExerciseLoaded) {
                                  List<Sets>? exercises = [];
                                  if (state
                                          .data!.responseDetails!.data!.length >
                                      0) {
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
                            Container(
                              width: defaultSize.screenWidth,
                              height: 1,
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            SB_1H,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Round Rest Time",
                                style: subTitleTextStyle(context)?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            restDuration == ''
                                ? SalukTransparentButton(
                                    title: AppLocalisation.getTranslated(
                                        context, LKExerciseRestTime),
                                    buttonWidth: defaultSize.screenWidth,
                                    borderColor: PRIMARY_COLOR,
                                    textColor: PRIMARY_COLOR,
                                    onPressed: () {
                                      showRoundRestTimeDialog();
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
                                      Text(
                                        restDuration + ' ' + restDurationMin,
                                        style:
                                            labelTextStyle(context)?.copyWith(
                                          color: Colors.black,
                                          fontSize: 14.sp,
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
                          ],
                        ),
                      ],
                    )),
                bottomNavigationBar: BottomAppBar(
                  child: SalukBottomButton(
                      title: AppLocalisation.getTranslated(context, LKSubmit),
                      callback: () async {
                        addRoundRestTime();
                      },
                      isButtonDisabled: restDuration.isEmpty ? true : false),
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

  showRoundRestTimeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExerciseDurationDialog(
            minutes: restDuration != null ? restDuration : null,
            heading: AppLocalisation.getTranslated(context, LKAddRestTime),
            onPressed: () {
              print("hello");
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
}
