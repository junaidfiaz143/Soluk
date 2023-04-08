import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/influencer/workout_programs/model/get_week_all_days_workouts_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/views/circuit_workout_screen.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/long_video/view/long_video_excersise.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/single_work_out/view/single_work_exercise.dart';
import 'package:app/module/influencer/workout_programs/view/day_detail.dart';
import 'package:app/module/influencer/workout_programs/view/widgets/exercise_tile.dart';
import 'package:app/module/influencer/workout_programs/view/workout_day/bloc/workout_day_cubit.dart';
import 'package:app/module/influencer/workout_programs/view/workout_day/bloc/workout_day_state.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_program_tile.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_type_custom_dialog.dart';
import 'package:app/module/influencer/workout_programs/widgets/workout_type_dropdown.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../res/color.dart';
import '../../../model/workout_model.dart';
import '../../add_exercise/circuit/views/circuit_workout_screen.dart';
import '../../add_exercise/circuit/views/timebased_workout_screen.dart';

class WorkOutDaysScreen extends StatefulWidget {
  static const id = 'WorkoutDays';
  final String title;
  final Data data;
  final String workoutID;
  final String weekID;

  const WorkOutDaysScreen(
      {Key? key,
      required this.title,
      required this.data,
      required this.workoutID,
      required this.weekID})
      : super(key: key);

  @override
  State<WorkOutDaysScreen> createState() => _WorkOutDaysScreenState();
}

class _WorkOutDaysScreenState extends State<WorkOutDaysScreen> {
  WorkOutDayCubit workOutCubit = WorkOutDayCubit();

  @override
  void initState() {
    workOutCubit.getAllExercises(id: widget.data.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: AppBody(
        title: widget.data.title,
        bgColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: WorkoutProgramTile(
                image: widget.data.assetUrl,
                mediaType: widget.data.assetType,
                title: "Day Title",
                description: widget.data.title,
                callback: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DayDetail(
                        title: 'Day Title',
                        data: widget.data,
                        workoutId: widget.workoutID,
                        weekId: widget.weekID,
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              AppLocalisation.getTranslated(context, LKWorkoutExercises),
              style: subTitleTextStyle(context)?.copyWith(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            SB_1H,
            BlocBuilder<WorkOutDayCubit, WorkOutDayState>(
                bloc: workOutCubit,
                builder: (_, state) {
                  print("state $state");
                  if (state is WorkOutDayLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
                  } else if (state is WorkOutDayEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext dcontext) {
                                    return WorkoutTypeCustomDialog(
                                      contentWidget:
                                          const WorkoutTypeDropDown(),
                                      workoutID: widget.workoutID,
                                      weekID: widget.weekID,
                                      dayID: widget.data.id.toString(),
                                      data: widget.data,
                                    );
                                  }).then((value) {
                                navigateToNextScreen(value);
                              });
                            },
                            child: SvgPicture.asset(PLUS_ICON)),
                        const SizedBox(height: 14),
                        Text(
                          AppLocalisation.getTranslated(
                              context, LKCreateExercise),
                          style: subTitleTextStyle(context)?.copyWith(
                              fontSize: defaultSize.screenWidth * .050),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
                            textAlign: TextAlign.center,
                            style: hintTextStyle(context),
                          ),
                        ),
                      ],
                    );
                  } else if (state is WorkOutDayLoaded) {
                    return Expanded(
                      child: RefreshWidget(
                        refreshController: workOutCubit.refreshController,
                        onLoadMore: () => workOutCubit.onLoadMore(),
                        onRefresh: () => workOutCubit.onRefresh(),
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state
                              .exerciseResponse!.responseDetails!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = state.exerciseResponse!.responseDetails!
                                .data![index];
                            String duration;
                            String? timebase;
                            // solukLog(logMsg: data.workoutType);
                            solukLog(logMsg: data);
                            if (data.exerciseTime != null) {
                              if (data.workoutType != "Supersets") {
                                if (data.workoutType == "Long Video" ||
                                    data.workoutType == "Single Workout") {
                                  duration = data.exerciseTime.split(":")[1];
                                } else {
                                  duration = data.exerciseTime.split(":")[0];
                                }
                              } else {
                                duration = "${data.sets!.length}";
                              }
                            } else {
                              duration = "0 Mins";
                            }
                            if (data.workoutType == "Supersets" ||
                                data.workoutType == "Circuit") {
                              duration = "${data.subtypes?.length}";
                              if ((data.subtypes?.length ?? 0) > 0) {
                                if (data.subtypes?[0].subType == "timebased") {
                                  timebase = "${data.sets?.length} Exercises";
                                }
                              }
                            }
                            if (data.subtypes?.isEmpty == true &&
                                data.sets?.isEmpty == true) {
                              timebase = '';
                            }
                            return ExerciseTile(
                              title: data.title,
                              image: data.assetUrl,
                              mediaType: data.assetType,
                              duration: duration,
                              timebase: timebase,
                              type: data.workoutType,
                              callback: () async {
                                if (data.workoutType == "Supersets") {
                                  // bool isTimebase=false;
                                  // String? exerciseTime;
                                  if ((data.subtypes?.length ?? 0) > 0) {
                                    // isTimebase=data.subtypes?[0].subType=="timebased";
                                    // exerciseTime=data.subtypes?[0].exerciseTime??"00:00:00";
                                    if (data.subtypes?[0].subType ==
                                        "timebased") {
                                      WorkOutModel datamodel = WorkOutModel(
                                          title: 'Time Based',
                                          workoutType: "Time Based",
                                          workoutID: widget.workoutID,
                                          weekID: widget.weekID,
                                          dayID: data.workoutDayId.toString(),
                                          isCircuit: false,
                                          exerciseId: data.id);
                                      datamodel.superSetImage = data.assetUrl;
                                      datamodel.workoutType = "Supersets";
                                      datamodel.timeDuration =
                                          data.subtypes![0].exerciseTime;
                                      datamodel.roundId = data.subtypes![0].id;
                                      datamodel.title = data.title;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddTimeBasedExercise(
                                            data: datamodel,
                                            isEditable: true,
                                          ),
                                        ),
                                      ).then((value) {
                                        if (value != null && value == true) {
                                          workOutCubit.onRefresh();
                                        }
                                      });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CircuitWorkOutScreen(
                                            title: data.title,
                                            description: data.instructions,
                                            workoutID:
                                                data.workoutId.toString(),
                                            weekID:
                                                data.workoutWeekId.toString(),
                                            dayID: data.workoutDayId.toString(),
                                            workoutType: data.workoutType,
                                            isEditScreen: true,
                                            isTypeSelected:
                                                data.sets!.isNotEmpty ||
                                                    data.subtypes!.isNotEmpty,
                                            exerciseID: data.id,
                                            roundID: data.subtypes?[0].id ?? 0,
                                            exerciseName: data.title,
                                            exerciseImage: data.assetUrl,
                                            circuitScreen: false,
                                            parent: data.parent,
                                            restTime: data.restTime,
                                          ),
                                        ),
                                      ).then((value) {
                                        if (value != null && value == true) {
                                          workOutCubit.onRefresh();
                                        }
                                      });
                                    }
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CircuitWorkOutScreen(
                                          title: data.title,
                                          description: data.instructions,
                                          parent: data.parent,
                                          workoutID: data.workoutId.toString(),
                                          weekID: data.workoutWeekId.toString(),
                                          dayID: data.workoutDayId.toString(),
                                          workoutType: data.workoutType,
                                          isEditScreen: true,
                                          isTypeSelected:
                                              data.sets!.isNotEmpty ||
                                                  data.subtypes!.isNotEmpty,
                                          exerciseID: data.id,
                                          // roundID: data.subtypes?[0].id,
                                          exerciseName: data.title,
                                          exerciseImage: data.assetUrl,
                                          circuitScreen: false,
                                          restTime: data.restTime,
                                        ),
                                      ),
                                    ).then((value) {
                                      if (value != null && value == true) {
                                        workOutCubit.onRefresh();
                                      }
                                    });
                                  }
                                } else if (data.workoutType == "Long Video") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LongVideoExerciseScreen(
                                        data: data,
                                        title: data.title,
                                        workoutID: data.workoutId.toString(),
                                        weekID: data.workoutWeekId.toString(),
                                        dayID: data.workoutDayId.toString(),
                                        // isEditScreen: true,
                                      ),
                                    ),
                                  ).then((value) {
                                    if (value != null && value == true) {
                                      solukLog(
                                          logMsg:
                                              "inside workout_days and it needs to be refresh to load updated data");
                                      workOutCubit.onRefresh();
                                    }
                                  });
                                } else if (data.workoutType ==
                                    "Single Workout") {
                                  solukLog(
                                      logMsg:
                                          "inside workdays for single workout");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          SingleWorkOutExerciseScreen(
                                        data: data,
                                        title: data.title,
                                        workoutID: data.workoutId.toString(),
                                        weekID: data.workoutWeekId.toString(),
                                        dayID: data.workoutDayId.toString(),
                                        isEditScreen: true,
                                      ),
                                    ),
                                  ).then((value) {
                                    if (value != null && value == true) {
                                      solukLog(
                                          logMsg:
                                              "inside workout_days and it needs to be refresh to load updated data");
                                      workOutCubit.onRefresh();
                                    }
                                  });
                                } else if (data.workoutType == "Circuit") {
                                  bool? isRefreshPage;
                                  if ((data.subtypes?.length ?? 0) > 0) {
                                    if (data.subtypes?[0].subType ==
                                        "timebased") {
                                      WorkOutModel datamodel = WorkOutModel(
                                          title: 'Time Based',
                                          workoutType: "Time Based",
                                          workoutID: widget.workoutID,
                                          weekID: widget.weekID,
                                          dayID: data.workoutDayId.toString(),
                                          isCircuit: true,
                                          exerciseId: data.id);
                                      datamodel.superSetImage = data.assetUrl;
                                      datamodel.workoutType = "Circuit";
                                      datamodel.timeDuration =
                                          data.subtypes![0].exerciseTime;
                                      datamodel.roundId = data.subtypes![0].id;
                                      datamodel.title = data.title;
                                      isRefreshPage = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddTimeBasedExercise(
                                            data: datamodel,
                                            isEditable: true,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => CircuitWorkOutScreen(
                                            // data: data,
                                            title: data.title,
                                            description: data.instructions,
                                            workoutID:
                                                data.workoutId.toString(),
                                            parent: data.parent,
                                            weekID:
                                                data.workoutWeekId.toString(),
                                            dayID: data.workoutDayId.toString(),
                                            circuitScreen: true,
                                            workoutType: data.workoutType,
                                            isEditScreen: true,
                                            isTypeSelected:
                                                data.sets!.isNotEmpty ||
                                                    data.subtypes!.isNotEmpty,
                                            exerciseID: data.id,
                                            exerciseName: data.title,
                                            exerciseImage: data.assetUrl,
                                            restTime: data.restTime,
                                            // isEditScreen: true,
                                          ),
                                        ),
                                      ).then((value) {
                                        if (value != null && value == true) {
                                          workOutCubit.onRefresh();
                                        }
                                      });
                                    }

                                    if (isRefreshPage != null &&
                                        isRefreshPage == true) {
                                      workOutCubit.onRefresh();
                                    }
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CircuitWorkOutScreen(
                                          // data: data,
                                          title: data.title,
                                          description: data.instructions,
                                          parent: data.parent,
                                          workoutID: data.workoutId.toString(),
                                          weekID: data.workoutWeekId.toString(),
                                          dayID: data.workoutDayId.toString(),
                                          circuitScreen: true,
                                          workoutType: data.workoutType,
                                          isEditScreen: true,
                                          isTypeSelected:
                                              data.sets!.isNotEmpty ||
                                                  data.subtypes!.isNotEmpty,
                                          exerciseID: data.id,
                                          exerciseName: data.title,
                                          exerciseImage: data.assetUrl,
                                          restTime: data.restTime,
                                          // isEditScreen: true,
                                        ),
                                      ),
                                    ).then((value) {
                                      if (value != null && value == true) {
                                        workOutCubit.onRefresh();
                                      }
                                    });
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        child: const Text("Error state"),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FAB(
        callback: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return WorkoutTypeCustomDialog(
                  contentWidget: const WorkoutTypeDropDown(),
                  workoutID: widget.workoutID,
                  weekID: widget.weekID,
                  dayID: widget.data.id.toString(),
                  data: widget.data,
                );
              }).then((value) {
            navigateToNextScreen(value);
          });
        },
      ),
    );
  }

  navigateToNextScreen(String? value) {
    if (value != null && value != "Select") {
      if (value == "Long Video") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LongVideoExerciseScreen(
              title: AppLocalisation.getTranslated(context, LKAddExercises),
              workoutType: value,
              workoutID: widget.workoutID,
              weekID: widget.weekID,
              dayID: widget.data.id.toString(),
            ),
          ),
        ).then((value) => workOutCubit.onRefresh());
      } else if (value == "Single Workout") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SingleWorkOutExerciseScreen(
              title: AppLocalisation.getTranslated(context, LKAddExercises),
              workoutID: widget.workoutID,
              weekID: widget.weekID,
              dayID: widget.data.id.toString(),
              data: widget.data,
            ),
          ),
        ).then((value) {
          workOutCubit.onRefresh();
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CircuitWorkOutScreen(
              title: AppLocalisation.getTranslated(context, LKDayExercise),
              description: "",
              workoutID: widget.workoutID,
              weekID: widget.weekID,
              parent: 0,
              dayID: widget.data.id.toString(),
              workoutType: value,
              circuitScreen: value == 'Circuit' ? true : false,
              restTime: "",
            ),
          ),
        ).then((value) => {workOutCubit.onRefresh()});
      }
    }
  }
}
