import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/workout_tile_video_thumbnail.dart';
import 'package:app/module/user/workout_programs/bloc/user_workout_bloc.dart';
import 'package:app/module/user/workout_programs/full_video_player.dart';
import 'package:app/module/user/workout_programs/model/user_workout_day_exercises_model.dart';
import 'package:app/module/user/workout_programs/time_selection_dialog.dart';
import 'package:app/module/user/workout_programs/timer_dialog.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/default_size.dart';
import '../../influencer/widgets/back_button.dart';
import '../../influencer/widgets/saluk_gradient_button.dart';
import 'exercise_rating.dart';

class WorkoutExercisePreview extends StatefulWidget {
  final DayExercise exercise;
  final String? title;
  final bool? redirectFeedback;
  bool isVideoOpened = false; // for single workout and long video

  WorkoutExercisePreview(
      {Key? key,
      required this.exercise,
      required this.title,
      required this.redirectFeedback})
      : super(key: key);

  @override
  _WorkoutWeeksState createState() => _WorkoutWeeksState();
}

class _WorkoutWeeksState extends State<WorkoutExercisePreview> {
  late UserWorkoutBloc userWorkoutBloc;

  List<String> timeList = [];

  late DayExercise exc;

  @override
  void initState() {
    timeList.add("00:15");
    timeList.add("00:20");
    timeList.add("00:25");
    timeList.add("00:30");
    timeList.add("00:35");
    timeList.add("00:40");
    timeList.add("00:45");
    timeList.add("00:50");
    timeList.add("00:55");
    timeList.add("00:60");
    timeList.add("00:65");
    timeList.add("00:70");
    timeList.add("00:75");
    timeList.add("00:80");
    timeList.add("00:85");
    timeList.add("00:90");
    timeList.add("00:100");

    super.initState();
    userWorkoutBloc = BlocProvider.of(context);

    exc = widget.exercise;
    isCompleted =
        exc.myExerciseStats != null && exc.myExerciseStats!.state == "completed"
            ? true
            : false;
    setupRoundsList();
  }

  setupRoundsList() {
    if (widget.exercise.workoutType == "Supersets" ||
        widget.exercise.workoutType == "Circuit") {
      if (((widget.exercise.subTypes != null &&
                  widget.exercise.subTypes!.isNotEmpty)
              ? widget.exercise.subTypes![0].subType
              : "timebased") !=
          "timebased") {}
    }
  }

  Timer? _timer;
  bool isCompleted = false; // for single workout and long video

  int selectedTime = 0;
  AsyncSnapshot<String>? currentTimeSnapshot;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        solukLog(logMsg: "timer - > ${timer.tick.toString()}");

        userWorkoutBloc.updateTimer(timer.tick.toString());

        if (userWorkoutBloc.selectedTime == null ||
            timer.tick >= userWorkoutBloc.selectedTime!) {
          _timer?.cancel();
          userWorkoutBloc.selectedTime = null;
        }

        /*if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
          });
        }*/
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    userWorkoutBloc.selectedTime = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    solukLog(logMsg: exc.workoutDayId);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: defaultSize.screenHeight * .02,
                      right: defaultSize.screenWidth * .05,
                      left: defaultSize.screenWidth * .05),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Center(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 7,
                            bottom: 0,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              width: DefaultSize.defaultSize.width * 0.50,
                              child: Text(
                                widget.title ?? "",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                // style: headingTextStyle(context),
                                style: subTitleTextStyle(context),
                              ),
                            ),
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SolukBackButton(
                                callback: () {},
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return userWorkoutBloc.selectedTime ==
                                              null
                                          ? TimeSelectionDialog(
                                              heading: "Custom Timer",
                                              onPressed: (int value) {
                                                userWorkoutBloc.selectedTime =
                                                    value;
                                                selectedTime = value;
                                                startTimer();

                                                // selectedTimeIndex=value;
                                                //  print("daud $value");
                                              },
                                              timeList: timeList,
                                            )
                                          : TimerDialog(
                                              currentTime: currentTimeSnapshot!,
                                              heading: "Custom Timer",
                                              onTick: (value) {
                                                // selectedTimeIndex=value;
                                                //  print("daud $value");
                                              },
                                              onTimerFinish: (value) {
                                                // selectedTimeIndex=value;
                                                //  print("daud $value");
                                              },
                                              timeList: timeList,
                                            );
                                    },
                                  );
                                },
                                child: exc.workoutType == "Long Video"
                                    ? Container()
                                    : StreamBuilder<String>(
                                        stream: userWorkoutBloc.timerStream,
                                        builder: (context, snapshot) {
                                          currentTimeSnapshot = snapshot;
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: userWorkoutBloc
                                                          .selectedTime !=
                                                      null
                                                  ? Colors.blue
                                                  : Colors.grey
                                                      .withOpacity(0.1),
                                              border: Border.all(
                                                  color: userWorkoutBloc
                                                              .selectedTime !=
                                                          null
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                defaultSize.screenWidth * .02,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timer_outlined,
                                                    color: userWorkoutBloc
                                                                .selectedTime !=
                                                            null
                                                        ? Colors.white
                                                        : Colors.blue,
                                                    size: defaultSize
                                                            .screenWidth *
                                                        .05,
                                                  ),
                                                  userWorkoutBloc
                                                              .selectedTime !=
                                                          null
                                                      ? Text(
                                                          " ${((userWorkoutBloc.selectedTime! - int.parse(snapshot.data.toString())) / 60).floor().toString().padLeft(2, "0")}:${((userWorkoutBloc.selectedTime! - int.parse(snapshot.data.toString())) % 60).toString().padLeft(2, "0")}",
                                                          style: TextStyle(
                                                              color: userWorkoutBloc
                                                                          .selectedTime !=
                                                                      null
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextLabel(
              label: "Title",
              value: exc.title ?? "",
            ),
            getTextLabel(label: "Instructions", value: exc.instructions ?? ""),
            getTextLabel(
                label: "Workout Type",
                value: exc.workoutType!,
                showWorkoutType: true),
            // getTextLabel(
            //   label: "Exercise Time",
            //   value: exc.exerciseTime != null
            //       ? solukFormatTime(exc.exerciseTime!)["time"]! +
            //           " " +
            //           solukFormatTime(exc.exerciseTime!)["type"]!
            //       : "",
            //   visibility: exc.exerciseTime != null ? true : false,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Row(children: [
                  //   Text(
                  //     "Workout Type: ${exc.workoutType ?? ""}",
                  //     textAlign: TextAlign.justify,
                  //     // maxLines: 1,
                  //     style: hintTextStyle(context)?.copyWith(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 12.sp,
                  //     ),
                  //   ),
                  //   Text(getWorkoutTypeString(exc)),
                  // ]),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      // Text(getWorkoutTimeString(exc) ?? ""),
                      const Spacer(),
                      exc.workoutType == "Long Video"
                          ? Container()
                          : Row(
                              children: [
                                Icon(
                                  Icons.repeat,
                                  size: 6.w,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  exc.workoutType == "Single Workout"
                                      ? "${exc.sets?.length ?? 0} Sets"
                                      : "${exc.subTypes?.length ?? 0} ${getSupersetTypes(exc)}",
                                ),
                              ],
                            ),
                    ],
                  ),
                  // Text("${getWorkoutTimeString(exc)}"),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: defaultSize.screenHeight * 0.7,
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10),
                decoration: const BoxDecoration(
                    // color: Colors.grey.shade200,
                    ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      exc.workoutType == "Single Workout" ||
                              exc.workoutType == "Long Video"
                          ? Column(
                              children: [
                                Row(children: [
                                  InkWell(
                                    onTap: () {
                                      _timer?.cancel();
                                      userWorkoutBloc.selectedTime = null;
                                      widget.isVideoOpened = true;
                                      if (exc.workoutType == "Long Video") {
                                        NavRouter.push(
                                            context,
                                            FullVideoPlayer(
                                              exercise: exc,
                                              title: exc.title ?? "",
                                              isLongVideo: true,
                                            )).then((value) {
                                          _timer?.cancel();
                                          userWorkoutBloc.selectedTime = null;
                                          setState(() {});
                                        });
                                      } else {
                                        NavRouter.push(
                                            context,
                                            FullVideoPlayer(
                                              exercise: exc,
                                              title:
                                                  "${exc.sets?.length ?? 0} Sets",
                                              isSingleWorkout: true,
                                            )).then((value) {
                                          _timer?.cancel();
                                          userWorkoutBloc.selectedTime = null;
                                          setState(() {});
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: defaultSize.screenWidth * 0.78,
                                      height: 18.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: exc.assetType != "Image"
                                          ? WorkoutTileVideoThumbnail(
                                              url: exc.assetUrl,
                                              decorated: true,
                                              playBack: false,
                                              height: 25.h,
                                            )
                                          : ImageContainer(
                                              height: defaultSize.screenWidth *
                                                  0.78,
                                              path: exc.assetUrl!,
                                              onClose: () {},
                                              isCloseShown: false,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {
                                      if (!isCompleted) {
                                        var result = await userWorkoutBloc
                                            .submitExercise(
                                                exerciseId: widget.exercise.id
                                                    .toString());
                                        if (result) {
                                          setState(() {
                                            isCompleted = true;
                                          }); // NavRouter.pushAndRemoveUntil(
                                          //     context, ExerciseRating());
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: defaultSize.screenWidth * 0.06,
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: isCompleted
                                              ? Colors.blue
                                              : Colors.grey,
                                          size: defaultSize.screenWidth * .06,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                (exc.workoutType == "Long Video")
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Workout Sets",
                                            style: labelTextStyle(context)!
                                                .copyWith(
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: ListView.builder(
                                                itemCount:
                                                    exc.sets?.length ?? 0,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  // return Text("kk");
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                            width: 25.w,
                                                            child: Text(
                                                              exc.sets?[index]
                                                                      .title ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color: /*index == 0
                                                          ? Colors.blue
                                                          : */
                                                                      Colors.black),
                                                            )),
                                                        SizedBox(
                                                            width: 25.w,
                                                            child: Text(
                                                                getExerciseType(
                                                                    exc
                                                                        .sets?[
                                                                            index]
                                                                        .type,
                                                                    exc
                                                                        .sets?[
                                                                            index]
                                                                        .meta),
                                                                style: const TextStyle(
                                                                    color: /* index == 0
                                                            ? Colors.blue
                                                            : */
                                                                        Colors.black))),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                        ],
                                      ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      (exc.workoutType == "Supersets" ||
                              exc.workoutType == "Circuit")
                          ? MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              // ! exc.sets != null && exc.sets!.isNotEmpty
                              // !
                              child: (((exc.subTypes != null &&
                                                  exc.subTypes!.isNotEmpty)
                                              ? exc.subTypes![0].subType
                                              : "timebased") ==
                                          "timebased") &&
                                      (exc.sets != null && exc.sets!.isNotEmpty)
                                  ? ListView.builder(
                                      itemCount: exc.sets != null
                                          ? exc.sets?.length
                                          : 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        String type = exc.sets![index].type!;
                                        String key = "";
                                        String roundLabel = "";

                                        if (type == "Time") {
                                          key = "setTime";
                                        } else if (type == "Reps") {
                                          key = "noOfReps";
                                        } else if (type == "Failure") {
                                          key = "setTime";
                                        } else if (type == "Custom") {
                                          key = "setTime";
                                        }

                                        for (int i = 0;
                                            i < exc.sets!.length;
                                            i++) {
                                          if (i == 0) {
                                            roundLabel += json.decode(
                                                exc.sets![index].meta!)[key];
                                          } else {
                                            roundLabel +=
                                                "-${json.decode(exc.sets![index].meta!)[key]}";
                                          }
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {
                                                  NavRouter.push(
                                                    context,
                                                    FullVideoPlayer(
                                                      exercise: exc,
                                                      title:
                                                          "Exercise ${index + 1}",
                                                      isSuperset: true,
                                                      isTimebased: true,
                                                      // subTypes: exc.subTypes![index],
                                                      excerciseId: index,
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                              width: 50.w,
                                                              child: Text(
                                                                "Exercise ${index + 1}",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              )),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          SizedBox(
                                                              width: 50.w,
                                                              child: Text(
                                                                "$roundLabel $type",
                                                                // +
                                                                //         widget
                                                                //             .title! ??
                                                                //     "",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Visibility(
                                                            visible: exc.sets!
                                                                    .isNotEmpty
                                                                ? true
                                                                : false,
                                                            child: Icon(
                                                              Icons
                                                                  .play_circle_fill,
                                                              color:
                                                                  Colors.blue,
                                                              size: 4.h,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            onTap: () async {
                                                              if (!exc
                                                                  .subTypes![
                                                                      index]
                                                                  .isSubmitted) {
                                                                var setId = 0;
                                                                var roundId = exc
                                                                    .subTypes?[
                                                                        index]
                                                                    .id;

                                                                exc.sets?.forEach(
                                                                    (element) {
                                                                  if (element
                                                                          .subTypeId ==
                                                                      roundId) {
                                                                    setId =
                                                                        element
                                                                            .id!;
                                                                  }
                                                                });
                                                                solukLog(
                                                                    logMsg:
                                                                        "inside timebased circuit & supersets submit");
                                                                solukLog(
                                                                    logMsg: widget
                                                                            .exercise
                                                                            .id
                                                                            .toString() +
                                                                        "-" +
                                                                        exc.subTypes![index]
                                                                            .id
                                                                            .toString() +
                                                                        "-" +
                                                                        setId.toString());

                                                                print(widget
                                                                    .exercise
                                                                    .id);
                                                                if (setId ==
                                                                    0) {
                                                                  SolukToast
                                                                      .showToast(
                                                                          "No Exercise found for this round");
                                                                } else {
                                                                  if (!isCompleted) {
                                                                    var result =
                                                                        await userWorkoutBloc
                                                                            .submitExerciseTimeBased(
                                                                      exerciseId: widget
                                                                          .exercise
                                                                          .id
                                                                          .toString(),
                                                                      subTypeId: exc
                                                                          .subTypes![
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      setId:
                                                                          setId,
                                                                    );
                                                                    if (result) {
                                                                      exc
                                                                          .subTypes?[
                                                                              index]
                                                                          .isSubmitted = true;
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              width: defaultSize
                                                                      .screenWidth *
                                                                  0.06,
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: (exc.sets!
                                                                              .isNotEmpty &&
                                                                          exc.sets![index].setStats !=
                                                                              null)
                                                                      ? exc.sets![index].setStats!.state ==
                                                                              'pending'
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .blue
                                                                      : Colors
                                                                          .grey,
                                                                  size: defaultSize
                                                                          .screenWidth *
                                                                      .06,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              if (exc.sets?[index].restTime !=
                                                  null)
                                                Text(
                                                  "${trimTime(exc.subTypes?[index].restTime ?? "00")} sec Rest Time",
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                )
                                            ],
                                          ),
                                        );
                                      })
                                  : ListView.builder(
                                      itemCount: exc.subTypes?.length ?? 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        // return Text("kk");
                                        // solukLog(
                                        //     logMsg:
                                        //         exc.subTypeStats![index].state);

                                        List<Sets> setsList = [];

                                        exc.sets?.forEach((element) {
                                          if (element.subTypeId ==
                                              exc.subTypes?[index].id) {
                                            setsList.add(element);
                                          }
                                        });

                                        return setsList.isNotEmpty
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      onTap: () {
                                                        if (setsList
                                                            .isNotEmpty) {
                                                          NavRouter.push(
                                                              context,
                                                              FullVideoPlayer(
                                                                  exercise: exc,
                                                                  title:
                                                                      "Round ${index + 1}",
                                                                  isSuperset:
                                                                      true,
                                                                  isRound: true,
                                                                  subTypes: exc
                                                                          .subTypes![
                                                                      index]));
                                                        } else {
                                                          SolukToast.showToast(
                                                              "No Sets Found");
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                                width: 25.w,
                                                                child: Text(
                                                                  "Round ${index + 1}",
                                                                  style: const TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color: /*index == 0
                                                              ? Colors.blue
                                                              : */
                                                                          Colors.black),
                                                                )),
                                                            Row(
                                                              children: [
                                                                Visibility(
                                                                  visible: exc
                                                                          .sets!
                                                                          .isNotEmpty
                                                                      ? true
                                                                      : false,
                                                                  child: Icon(
                                                                    Icons
                                                                        .play_circle_fill,
                                                                    color: Colors
                                                                        .blue,
                                                                    size: 4.h,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  onTap:
                                                                      () async {
                                                                    // solukLog(
                                                                    //     logMsg: widget
                                                                    //         .exercise.id
                                                                    //         .toString(),
                                                                    //     logDetail:
                                                                    //         "exercise id");
                                                                    // solukLog(
                                                                    //     logMsg: exc
                                                                    //         .subTypes?[
                                                                    //             index]
                                                                    //         .id
                                                                    //         .toString(),
                                                                    //     logDetail:
                                                                    //         "round id");
                                                                    if (exc
                                                                            .subTypes![index]
                                                                            .subTypeStats!
                                                                            .state ==
                                                                        "pending") {
                                                                      var roundId = exc
                                                                          .subTypes?[
                                                                              index]
                                                                          .id;

                                                                      var result = await userWorkoutBloc.submitRoundNew(
                                                                          exerciseId: widget
                                                                              .exercise
                                                                              .id
                                                                              .toString(),
                                                                          roundId:
                                                                              roundId.toString());
                                                                      if (result) {
                                                                        exc
                                                                            .subTypes![index]
                                                                            .subTypeStats!
                                                                            .state = "completed";
                                                                      }
                                                                    }
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: defaultSize
                                                                            .screenWidth *
                                                                        0.06,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color: exc.sets!.isNotEmpty &&
                                                                                exc.subTypes != null
                                                                            ? exc.subTypes![index].subTypeStats!.state == "completed"
                                                                                ? Colors.blue
                                                                                : Colors.grey
                                                                            : Colors.grey,
                                                                        size: defaultSize.screenWidth *
                                                                            .06,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    setsList.isNotEmpty
                                                        ? ListView.builder(
                                                            itemCount:
                                                                setsList.length,
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 5.0,
                                                                      right:
                                                                          5.0),
                                                                  width: 50.h,
                                                                  child: Text(
                                                                    "${setsList[index].title ?? ""} - ${setsList[index].instructions ?? ""}",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ));
                                                            })
                                                        : Container(
                                                            width: 50.h,
                                                            child: const Text(
                                                              "No Exercises Found",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0),
                                                      child: Text(
                                                        "${trimTime("${solukFormatTime(exc.subTypes![index].restTime ?? '00:00')["time"]!} ${solukFormatTime(exc.subTypes![index].restTime ?? '00:00')["type"]!}")} Rest Time",
                                                        style: const TextStyle(
                                                            color: /*index == 0
                                                      ? Colors.blue
                                                      : */
                                                                Colors.grey),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : const SizedBox.shrink();
                                      }),
                            )
                          : Container(),
                      (exc.workoutType == "Long Video")
                          ? Container()
                          : Visibility(
                              visible: exc.restTime != null ? true : false,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 100.w,
                                    height: 1,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    "Rest Time",
                                    style: labelTextStyle(context)!.copyWith(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer_outlined,
                                          color: Colors.blue,
                                          size: defaultSize.screenWidth * .06,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        // Text("${trimTime(exc.restTime ?? "00")}"),
                                        Text(exc.restTime != null
                                            ? "${solukFormatTime(exc.restTime!)["time"]!} ${solukFormatTime(exc.restTime!)["type"]!}"
                                            : "")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isCompleted == true
                  ? false
                  : exc.workoutType == "Long Video" ||
                          exc.workoutType == "Single Workout"
                      ? true
                      : false,
              child: InkWell(
                child: Container(
                  width: defaultSize.screenWidth,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 20) +
                          EdgeInsets.only(bottom: Platform.isIOS ? 12 : 0),
                  // color: Colors.white,
                  child: SizedBox(
                    width: defaultSize.screenWidth,
                    height: 50,
                    child: SalukGradientButton(
                      dim: false,
                      title: isCompleted == true
                          ? "Completed"
                          : (widget.isVideoOpened == true
                              ? 'Complete Exercise'
                              : 'Start Exercise'),
                      style: buttonTextStyle(context)
                          ?.copyWith(fontWeight: FontWeight.w500),
                      onPressed: () async {
                        solukLog(logMsg: widget.exercise.id);
                        if (!isCompleted) {
                          if (widget.isVideoOpened == false) {
                            NavRouter.push(
                                context,
                                FullVideoPlayer(
                                  exercise: exc,
                                  title: exc.workoutType == "Long Video"
                                      ? exc.title ?? ""
                                      : "${exc.sets?.length ?? 0} Sets",
                                  isLongVideo: exc.workoutType == "Long Video",
                                  isSingleWorkout:
                                      exc.workoutType == "Single Workout",
                                )).then((value) {
                              widget.isVideoOpened = true;
                              _timer?.cancel();
                              userWorkoutBloc.selectedTime = null;
                              setState(() {});
                            });
                          } else {
                            var result =
                                await userWorkoutBloc.submitExerciseNew(
                                    exerciseId: widget.exercise.id.toString());
                            solukLog(logMsg: result);
                            if (result) {
                              exc.myExerciseStats!.state = "completed";
                              var progress =
                                  await userWorkoutBloc.getUserWorkoutDetail(
                                      workoutId:
                                          widget.exercise.workoutId!.toString(),
                                      checkProgress: true);
                              SolukToast.showToast(
                                  progress.toString()); // setState(() {});
                              if (widget.redirectFeedback! && progress == 100) {
                                if (!mounted) return;
                                NavRouter.pushAndRemoveUntil(
                                    context,
                                    ExerciseRating(
                                      workoutId: exc.workoutId,
                                    ));
                              }
                            }
                          }
                        }
                      },
                      buttonHeight: HEIGHT_2 + 5,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getWorkoutTypeString(DayExercise exc) {
    if (exc.workoutType == "Single Workout") {
      if (exc.sets != null && exc.sets!.isNotEmpty) {
        if (exc.sets![0].type == "Time") {
          return " - Timebase";
        } else {
          return " - ${exc.sets?[0].type ?? ""}";
        }
      }
    } else if (exc.workoutType == "Supersets") {
      if (exc.subTypes != null && exc.subTypes!.isNotEmpty) {
        if (exc.subTypes![0].subType == "round") {
          return " - ${exc.subTypes?[0].subType ?? ""}";
        }
      }
    }

    return "";
  }

  String? getWorkoutTimeString(DayExercise exc) {
    if (exc.workoutType == "Single Workout") {
      return "Ex Time - " +
          solukFormatTime(exc.exerciseTime!)["time"]! +
          " " +
          solukFormatTime(exc.exerciseTime!)["type"]!;
    } else if (exc.workoutType == "Supersets") {
      if (exc.subTypes != null && exc.subTypes!.isNotEmpty) {
        if (exc.subTypes![0].subType != "round" &&
            exc.subTypes![0].subType != "Failure") {
          return exc.exerciseTime;
        }
      }
    }

    return "";
  }

  String getSupersetTypes(DayExercise exc) {
    if (exc.workoutType == "Supersets") {
      if (exc.subTypes != null && exc.subTypes!.isNotEmpty) {
        if (exc.subTypes![0].subType == "round") {
          return "Rounds";
        } else {
          return "Exercise";
        }
      }
    }

    return "";
  }

  getTextLabel(
      {required String label,
      required String value,
      bool? showWorkoutType = false,
      bool? visibility = true}) {
    return Visibility(
      visible: visibility!,
      child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          decoration: const BoxDecoration(
            // color: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          child: Row(
            children: [
              Text(
                "$label - ",
                textAlign: TextAlign.justify,
                // maxLines: 1,
                style: hintTextStyle(context)?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.sp,
                ),
              ),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.justify,
                  // maxLines: 1,
                  style: hintTextStyle(context)?.copyWith(
                    color: Colors.black,
                    fontSize: 11.sp,
                  ),
                ),
              ),
              Visibility(
                  visible: showWorkoutType!,
                  child: Text(getWorkoutTypeString(exc))),
            ],
          )),
    );
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

  String trimTime(String time) {
    solukLog(logMsg: time, logDetail: "trim time");
    if (time.startsWith("00:")) {
      var newTime = time.replaceFirst("00:", "");
      return newTime;
    }
    return time;
  }
}
