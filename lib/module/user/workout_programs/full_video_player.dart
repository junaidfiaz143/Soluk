import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/workout_programs/bloc/full_screen_bloc.dart';
import 'package:app/module/user/workout_programs/time_selection_dialog.dart';
import 'package:app/module/user/workout_programs/timer_dialog.dart';
import 'package:app/res/globals.dart';
import 'package:cast/device.dart';
import 'package:cast/discovery_service.dart';
import 'package:cast/session.dart';
import 'package:cast/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import "package:story_view/story_view.dart";
import 'package:video_player/video_player.dart';

import 'bloc/user_workout_bloc.dart';
import 'model/user_workout_day_exercises_model.dart';

class FullVideoPlayer extends StatefulWidget {
  final String title;
  final bool isSingleWorkout;
  final bool isSuperset;
  final bool isTimebased;
  final bool isRound;
  final bool isLongVideo;
  final DayExercise exercise;
  final SubTypes? subTypes;
  final int? excerciseId;

  const FullVideoPlayer({
    Key? key,
    required this.exercise,
    required this.title,
    this.isSingleWorkout = false,
    this.isSuperset = false,
    this.isTimebased = false,
    this.isRound = false,
    this.isLongVideo = false,
    this.subTypes,
    this.excerciseId,
  }) : super(key: key);

  @override
  FullVideoPlayerState createState() => FullVideoPlayerState();
}

class FullVideoPlayerState extends State<FullVideoPlayer> {
  late VideoPlayerController _videoController;
  late FullScreenBloc fullScreenBloc;

  final DraggableScrollableController _draggableController =
      DraggableScrollableController();

  static const double minExtent = 0.12;
  static const double maxExtent = 0.7;
  bool isDrggableExpanded = false;
  double initialExtent = minExtent;

  late DayExercise exc;

  Set<String> setTitle = {};
  List<String> setType = [];

  List<String> timeList = [];
  bool isCastDevicesVisible = false;

  @override
  void initState() {
    super.initState();
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

    userWorkoutBloc = BlocProvider.of(context);

    fullScreenBloc = BlocProvider.of(context);
    fullScreenBloc.storyItems = [];
    fullScreenBloc.initController();
    initData();

    solukLog(
        logMsg: widget.exercise.assetUrl,
        logDetail: "initState FullVideoPlayer");
    // _videoController = VideoPlayerController.network(widget.exercise.assetUrl
    //         .toString()
    //         .contains("mp4")
    //     ? widget.exercise.assetUrl!
    //     : 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });

    if (exc.myExerciseStats != null) {
      userWorkoutBloc.addWorkoutView(
        workoutId: exc.workoutId.toString(),
        subType: exc.subTypes!.isNotEmpty ? "round" : "exercise",
        subTypeId: exc.subTypes!.isNotEmpty
            ? exc.subTypes![0].workoutDayExerciseId.toString()
            : exc.myExerciseStats!.workoutWeekDayExerciseId.toString(),
      );
    } else {
      userWorkoutBloc.addWorkoutView(
        workoutId: exc.workoutId.toString(),
        subType: exc.subTypes!.isNotEmpty ? "round" : "exercise",
        subTypeId: "",
      );
    }
    fullScreenBloc.state;
    fullScreenBloc.state;
    fullScreenBloc.storyController.playbackNotifier.stream.listen((data) {
      print('Full Screen Playback');
      print(data);
      print(fullScreenBloc.storyItems);
    });
    fullScreenBloc.stream.listen((data) {
      print('Full Screen Stream');
      print(data);
    });
  }

  Timer? _timer;
  late UserWorkoutBloc userWorkoutBloc;
  AsyncSnapshot<String>? currentTimeSnapshot;
  int selectedTime = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        userWorkoutBloc.updateTimer(timer.tick.toString());

        if (userWorkoutBloc.selectedTime == null ||
            timer.tick >= userWorkoutBloc.selectedTime!) {
          _timer?.cancel();
          userWorkoutBloc.selectedTime = null;
        }
      },
    );
  }

  Future<void> toggleDraggableSheet() async {
    print('Toggle Draggable Sheet $isDrggableExpanded');
    if (isDrggableExpanded) {
      isDrggableExpanded = false;
      // print(_draggableController.pixels);
      _draggableController.animateTo(
        minExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      // await _draggableController.animateTo(
      //   minExtent,
      //   duration: const Duration(milliseconds: 200),
      //   curve: Curves.easeInOutBack,
      // );
    } else {
      isDrggableExpanded = true;

      _draggableController.animateTo(
        maxExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      // await _draggableController.animateTo(
      //   maxExtent,
      //   duration: const Duration(milliseconds: 200),
      //   curve: Curves.easeInOutBack,
      // );
    }
  }

  initData() async {
    exc = widget.exercise;
    for (Sets set in exc.sets!) {
      setTitle.add(set.title!);
      setType.add(set.type!);
    }

    if (widget.isSingleWorkout) {
      if (exc.assetType == "Image") {
        fullScreenBloc.loadStoryItemImage(url: exc.assetUrl ?? "");
      } else {
        _videoController = VideoPlayerController.network(
          exc.assetUrl ?? "",
        );
        await _videoController.initialize();
        fullScreenBloc.loadStoryItemVideo(
            url: exc.assetUrl ?? "", duration: _videoController.value.duration);
      }
      fullScreenBloc.showStory();
    } else if (widget.isSuperset &&
        widget.isTimebased &&
        widget.excerciseId != null) {
      print("hshsh");
      setTitle.clear();
      setType.clear();
      setTitle.add(exc.sets![widget.excerciseId!].title!);
      setType.add(exc.sets![widget.excerciseId!].type!);
      // if (exc.sets?[widget.excerciseId!].assetType == "Image") {
      if (exc.assetType == "Image") {
        // fullScreenBloc.loadStoryItemImage(
        //     url: exc.sets?[widget.excerciseId!].assetUrl ?? "");
        fullScreenBloc.loadStoryItemImage(url: exc.assetUrl ?? "");
      } else {
        // _videoController = VideoPlayerController.network(
        //     exc.sets?[widget.excerciseId!].assetUrl ?? "");
        _videoController = VideoPlayerController.network(exc.assetUrl ?? "");
        await _videoController.initialize();
        // fullScreenBloc.loadStoryItemVideo(
        //     url: exc.sets?[widget.excerciseId!].assetUrl ?? "",
        //     duration: _videoController.value.duration);
        fullScreenBloc.loadStoryItemVideo(
            url: exc.assetUrl ?? "", duration: _videoController.value.duration);
      }
      fullScreenBloc.showStory();
    } else if (widget.isSuperset) {
      setTitle.clear();
      setType.clear();
      for (int i = 0; i < (exc.sets?.length ?? 0); i++) {
        // if (widget.subTypes?.id == exc.sets?[i].subTypeId) {
        // solukLog(
        //     logMsg: exc.sets?[i].assetUrl,
        //     logDetail: "FullVideoScreen superset");
        // setTitle.add(exc.sets![i].title!);
        // setType.add(exc.sets![i].type!);
        if (exc.assetType == "Image") {
          // if (exc.sets?[i].assetType == "Image") {
          // fullScreenBloc.loadStoryItemImage(url: exc.sets?[i].assetUrl ?? "");
          fullScreenBloc.loadStoryItemImage(url: exc.assetUrl ?? "");
          solukLog(logMsg: "image added for superset", logDetail: exc.assetUrl);
        } else {
          // _videoController =
          //     VideoPlayerController.network(exc.sets?[i].assetUrl ?? "");
          _videoController = VideoPlayerController.network(exc.assetUrl ?? "");
          await _videoController.initialize();
          // fullScreenBloc.loadStoryItemVideo(
          //     url: exc.sets?[i].assetUrl ?? "",
          //     duration: _videoController.value.duration);
          fullScreenBloc.loadStoryItemVideo(
              url: exc.assetUrl ?? "",
              duration: _videoController.value.duration);
          solukLog(logMsg: "video added for superset", logDetail: exc.assetUrl);
        }
        // }
      }
      fullScreenBloc.showStory();
    } else if (widget.isLongVideo) {
      solukLog(logMsg: "story added for LongView", logDetail: exc.assetUrl);
      try {
        if (exc.assetType == "Image") {
          fullScreenBloc.loadStoryItemImage(url: exc.assetUrl ?? "");
        } else {
          _videoController = VideoPlayerController.network(exc.assetUrl ?? "");
          await _videoController.initialize();
          fullScreenBloc.loadStoryItemVideo(
              url: exc.assetUrl ?? "",
              duration: _videoController.value.duration);
        }
        fullScreenBloc.showStory();
      } catch (e) {
        solukLog(logMsg: "story added for LongView", logDetail: e);
      }
      solukLog(
          logMsg: "showing story added for LongView", logDetail: exc.assetUrl);
    }
  }

  void Function(void Function())? _setPopupState;
  int currReelIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            BlocBuilder<FullScreenBloc, FullScreenBlocState>(
              buildWhen: (pre, c) {
                return c is! UpdateCheckState;
              },
              builder: (context, data) {
                if (fullScreenBloc.storyItems.isNotEmpty) {
                  return Container(
                    color: Colors.black,
                    padding: const EdgeInsets.only(top: 80),
                    height: 75.h,
                    width: 100.w,
                    child: StoryView(
                      onStoryShow: (value) {
                        // print("Show ShowShowShowShowShow: ${value.duration}");
                        // print("Show ShowShowShowShowShow: ${value.shown}");
                        // print("Show ShowShowShowShowShow: ${value.hashCode}");
                        final pos = fullScreenBloc.storyItems.indexOf(value);
                        currReelIndex = pos;

                        WidgetsBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            _setPopupState?.call(() {
                              currReelIndex = pos;
                            });
                          },
                        );

                        // print("Show ShowShowShowShowShow: $pos");
                      },
                      inline: true,
                      storyItems: fullScreenBloc.storyItems,
                      controller: fullScreenBloc.storyController,
                      onComplete: () async {
                        // Navigator.pop(context);
                        // fullScreenBloc.storyController.next();
                      },
                      repeat: false,
                      progressPosition: ProgressPosition.top,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Column(
              children: [
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 30.0, 30.0, 20.0),
                      width: 100.w,
                      // height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        // border: Border.all(color: Colors.red)
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SalukTransparentButton(
                                    borderColor: Colors.white70,
                                    title: "",
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // NavRouter.push(context, ExerciseRating());
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white,
                                      size: defaultSize.screenWidth * .05,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    buttonWidth: defaultSize.screenWidth * .09,
                                    buttonHeight:
                                        defaultSize.screenWidth * .09),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Icon(
                                  Icons.repeat,
                                  size: 6.w,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  widget.title,
                                  style: labelTextStyle(context)!.copyWith(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w100),
                                ),
                                const Spacer(),
                                StreamBuilder<String>(
                                  stream: userWorkoutBloc.timerStream,
                                  builder: (context, snapshot) {
                                    currentTimeSnapshot = snapshot;
                                    return SalukTransparentButton(
                                        borderColor:
                                            userWorkoutBloc.selectedTime != null
                                                ? Colors.blue
                                                : Colors.white70,
                                        title: userWorkoutBloc.selectedTime ==
                                                null
                                            ? "Rest"
                                            : " ${((userWorkoutBloc.selectedTime! - int.parse(snapshot.data.toString())) / 60).floor().toString().padLeft(2, "0")}:${((userWorkoutBloc.selectedTime! - int.parse(snapshot.data.toString())) % 60).toString().padLeft(2, "0")}",
                                        buttonColor:
                                            userWorkoutBloc.selectedTime != null
                                                ? Colors.blue
                                                : Colors.white.withOpacity(0.2),
                                        style: labelTextStyle(context)!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w100),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return userWorkoutBloc
                                                            .selectedTime ==
                                                        null
                                                    ? TimeSelectionDialog(
                                                        heading: "Custom Timer",
                                                        onPressed: (int value) {
                                                          userWorkoutBloc
                                                                  .selectedTime =
                                                              value;
                                                          selectedTime = value;
                                                          startTimer();
                                                        },
                                                        timeList: timeList,
                                                      )
                                                    : TimerDialog(
                                                        currentTime:
                                                            currentTimeSnapshot!,
                                                        heading: "Custom Timer",
                                                        onTick: (value) {},
                                                        onTimerFinish:
                                                            (value) {},
                                                        timeList: timeList,
                                                      );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.timer_outlined,
                                          color: Colors.white,
                                          size: defaultSize.screenWidth * .05,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        buttonWidth:
                                            defaultSize.screenWidth * .18,
                                        buttonHeight:
                                            defaultSize.screenWidth * .09);
                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            userWorkoutBloc.selectedTime != null
                                                ? Colors.blue
                                                : Colors.grey.withOpacity(0.1),
                                        border: Border.all(
                                            color:
                                                userWorkoutBloc.selectedTime !=
                                                        null
                                                    ? Colors.blue
                                                    : Colors.grey,
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(
                                          defaultSize.screenWidth * .02,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.timer_outlined,
                                              color: userWorkoutBloc
                                                          .selectedTime !=
                                                      null
                                                  ? Colors.white
                                                  : Colors.blue,
                                              size:
                                                  defaultSize.screenWidth * .05,
                                            ),
                                            userWorkoutBloc.selectedTime != null
                                                ? Text(
                                                    " ${((userWorkoutBloc.selectedTime! - int.parse(snapshot.data.toString())) / 60).floor().toString().padLeft(2, "0")}:${((userWorkoutBloc.selectedTime! - int.parse(snapshot.data.toString())) % 60).toString().padLeft(2, "0")}",
                                                    style: TextStyle(
                                                        color: userWorkoutBloc
                                                                    .selectedTime !=
                                                                null
                                                            ? Colors.white
                                                            : Colors.black),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // SalukTransparentButton(
                                //     borderColor: Colors.white70,
                                //     title: "Rest",
                                //     style: labelTextStyle(context)!.copyWith(
                                //         color: Colors.white,
                                //         fontSize: 13.sp,
                                //         fontWeight: FontWeight.w100),
                                //     onPressed: () {
                                //       solukLog(logMsg: "logMsg");

                                //       showDialog(
                                //           context: context,
                                //           barrierDismissible: false,
                                //           builder: (BuildContext context) {
                                //             return userWorkoutBloc.selectedTime ==
                                //                     null
                                //                 ? TimeSelectionDialog(
                                //                     heading: "Custom Timer",
                                //                     onPressed: (int value) {
                                //                       userWorkoutBloc
                                //                           .selectedTime = value;
                                //                       selectedTime = value;
                                //                       startTimer();
                                //                     },
                                //                     timeList: timeList,
                                //                   )
                                //                 : TimerDialog(
                                //                     currentTime:
                                //                         currentTimeSnapshot!,
                                //                     heading: "Custom Timer",
                                //                     onTick: (value) {},
                                //                     onTimerFinish: (value) {},
                                //                     timeList: timeList,
                                //                   );
                                //           });
                                //     },
                                //     icon: Icon(
                                //       Icons.timer_outlined,
                                //       color: Colors.white,
                                //       size: defaultSize.screenWidth * .05,
                                //     ),
                                //     borderRadius: BorderRadius.circular(10),
                                //     buttonWidth: defaultSize.screenWidth * .18,
                                //     buttonHeight: defaultSize.screenWidth * .09),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            // storyItems.isNotEmpty
                            //     ? SizedBox(
                            //         height: 100.h,
                            //         width: 100.w,
                            //         child: StoryPageView(
                            //           itemBuilder:
                            //               (context, pageIndex, storyIndex) {
                            //             return Center(
                            //               child: Text(
                            //                   "Index of PageView: $pageIndex Index of story on each page: $storyIndex"),
                            //             );
                            //           },
                            //           storyLength: (pageIndex) {
                            //             return 3;
                            //           },
                            //           pageLength: 4,
                            //         ),
                            //       )
                            // storyItems.isNotEmpty
                            //     ?
                            //     SizedBox(
                            //         height: 75.h,
                            //         width: 100.w,
                            //         child: StoryView(
                            //           storyItems: storyItems,
                            //           controller: controller,
                            //           onComplete: () {
                            //             controller.next();
                            //           },
                            //           repeat: false,
                            //           progressPosition: ProgressPosition.top,
                            //         ),
                            //       )
                            // : Container()

                            /*ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: .25,
                              color: Colors.white,
                              backgroundColor: Colors.grey,
                            ),
                          )*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isCastDevicesVisible = true;
                  });
                },
                icon: const Icon(
                  Icons.cast,
                  color: Colors.white,
                ),
              ),
            ),
            isCastDevicesVisible == true
                ? Positioned(
                    bottom: 20,
                    right: 0,
                    left: 0,
                    child: FutureBuilder<List<CastDevice>>(
                      future: CastDiscoveryService()
                          .search(timeout: const Duration(seconds: 15)),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: TextView(
                              'Error: ${snapshot.error.toString()}',
                              color: Colors.white,
                            ),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.data!.isEmpty) {
                          return Column(
                            children: const [
                              Center(
                                child: TextView(
                                  'No Chromecast founded',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        }

                        return Column(
                          children: snapshot.data!.map((device) {
                            return ListTile(
                              title: Text(device.name),
                              onTap: () {
                                _connectToYourApp(context, device);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            Visibility(
              visible: widget.isLongVideo == false,
              child: DraggableScrollableSheet(
                controller: _draggableController,
                initialChildSize: initialExtent,
                minChildSize: minExtent,
                maxChildSize: maxExtent,
                builder: (draggableSheetContext, scrollSheetController) {
                  return StatefulBuilder(
                    builder: (context, setDraggableState) {
                      _setPopupState = setDraggableState;
                      print('Curr POSSS:: $currReelIndex');
                      // ! ==========================================================
                      return SingleChildScrollView(
                        // physics: ClampingScrollPhysics(),
                        controller: scrollSheetController,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                              width: 100.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                // border: Border.all(color: Colors.red)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Workout Sets",
                                        style: headingTextStyle(context)!
                                            .copyWith(color: Colors.white),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          toggleDraggableSheet();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          // color: Colors.red,
                                          child: Icon(
                                            isDrggableExpanded
                                                ? Icons.keyboard_arrow_down
                                                : Icons.keyboard_arrow_up,
                                            size: WIDTH_3,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: exc.sets!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  exc.sets![index].title!,
                                                  style:
                                                      labelTextStyle(context)!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  // ";;",
                                                  getExerciseType(
                                                      exc.sets?[index].type,
                                                      // setType.elementAt(index),
                                                      exc.sets?[index].meta
                                                      // setMeta.elementAt(index) ?? "",
                                                      ),
                                                  style:
                                                      labelTextStyle(context)!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                BlocBuilder<FullScreenBloc,
                                                    FullScreenBlocState>(
                                                  builder: (context, state) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        exc.sets
                                                            ?.elementAt(index)
                                                            .isChecked = !(exc
                                                                .sets
                                                                ?.elementAt(
                                                                    index)
                                                                .isChecked ==
                                                            true);
                                                        fullScreenBloc
                                                            .updateCheckBox();
                                                      },
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: exc.sets
                                                                    ?.elementAt(
                                                                        index)
                                                                    .isChecked ==
                                                                true
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        size: defaultSize
                                                                .screenWidth *
                                                            .05,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                              color: Colors.white70
                                                  .withOpacity(0.5),
                                              width: 100.w,
                                              height: 1,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  // ListView.builder(
                                  //   shrinkWrap: true,
                                  //   physics: NeverScrollableScrollPhysics(),
                                  //   itemCount: setTitle.length,
                                  //   itemBuilder: (context, index) {
                                  //     return Container(
                                  //       child: Column(
                                  //         children: [
                                  //           SizedBox(
                                  //             height: 2.h,
                                  //           ),
                                  //           Row(
                                  //             children: [
                                  //               Text(
                                  //                 setTitle.elementAt(index),
                                  //                 style: labelTextStyle(context)!.copyWith(color: Colors.white),
                                  //               ),
                                  //               Spacer(),
                                  //               Text(
                                  //                 getExerciseType(
                                  //                     // exc.sets?[index].type,
                                  //                     setType.elementAt(index),
                                  //                     exc.sets?[index].meta
                                  //                     // setMeta.elementAt(index) ?? "",
                                  //                     ),
                                  //                 style: labelTextStyle(context)!.copyWith(color: Colors.white),
                                  //               ),
                                  //               SizedBox(
                                  //                 width: 10.w,
                                  //               ),
                                  //               BlocBuilder<FullScreenBloc, FullScreenBlocState>(
                                  //                 builder: (context, state) {
                                  //                   return GestureDetector(
                                  //                     onTap: () {
                                  //                       exc.sets?.elementAt(index).isChecked =
                                  //                           !(exc.sets?.elementAt(index).isChecked == true);
                                  //                       fullScreenBloc.updateCheckBox();
                                  //                     },
                                  //                     child: Icon(
                                  //                       Icons.check_circle,
                                  //                       color: exc.sets?.elementAt(index).isChecked == true
                                  //                           ? Colors.blue
                                  //                           : Colors.grey,
                                  //                       size: defaultSize.screenWidth * .05,
                                  //                     ),
                                  //                   );
                                  //                 },
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             height: 1.h,
                                  //           ),
                                  //           Container(
                                  //             color: Colors.white70.withOpacity(0.5),
                                  //             width: 100.w,
                                  //             height: 1,
                                  //           )
                                  //         ],
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Instructions",
                                    style: headingTextStyle(context)!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    exc.instructions == null
                                        ? (exc.sets
                                                ?.elementAt(currReelIndex)
                                                .instructions ??
                                            '')
                                        : exc.instructions ?? '',
                                    textAlign: TextAlign.justify,
                                    style: labelTextStyle(context)!.copyWith(
                                        color: Colors.white, fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
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

  Duration getDuration(String? type, String? meta, {bool isLongVideo = false}) {
    int hour = 0;
    int minute = 0;
    int seconds = 0;
    String value = '';

    if (isLongVideo) {
      value = meta!;
    } else if (type == "Time") {
      value = json.decode(meta ?? '')["setTime"] ?? "";
    } else {
      return const Duration();
    }

    if (value.isEmpty) return const Duration();

    var timesArray = value.split(":");
    switch (timesArray.length) {
      case 1:
        {
          seconds = int.parse(timesArray[0]);
        }
        break;
      case 2:
        {
          minute = int.parse(timesArray[0]);
          seconds = int.parse(timesArray[1]);
        }
        break;
      case 3:
        {
          hour = int.parse(timesArray[0]);
          minute = int.parse(timesArray[1]);
          seconds = int.parse(timesArray[2]);
        }
    }
    var duration = Duration(hours: hour, minutes: minute, seconds: seconds);

    return duration;
  }

  @override
  void dispose() {
    try {
      _videoController.dispose();
    } catch (e) {
      debugPrint(e.toString());
    }
    fullScreenBloc.disposeController();
    _timer?.cancel();
    userWorkoutBloc.selectedTime = null;
    super.dispose();
  }

  Future<void> _connectToYourApp(
      BuildContext context, CastDevice device) async {
    final session = await CastSessionManager().startSession(device);

    session.stateStream.listen((state) {
      if (state == CastSessionState.connected) {
        session.sendMessage('urn:x-cast:com.connectsdk', {
          'type': 'sample',
        });
      }
    });

    session.messageStream.listen((message) {
      print('receive message: $message');
    });

    session.sendMessage(CastSession.kNamespaceReceiver, {
      'type': 'LAUNCH',
      'appId': 'com.saluk.app', // set the appId of your app here
    });
  }
}
