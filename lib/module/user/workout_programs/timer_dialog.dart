import 'dart:ui';

import 'package:app/module/user/workout_programs/bloc/user_workout_bloc.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../widgets/text_view.dart';

class TimerDialog extends StatefulWidget {
  static const String id = '/TimeSelectionDialog';

  // final Widget contentWidget;
  final String heading;
  final Function? onTick;
  final Function? onTimerFinish;
  final List<String> timeList;
  final AsyncSnapshot<String> currentTime;

  TimerDialog({
    Key? key,
    required this.heading,
    required this.onTick,
    required this.onTimerFinish,
    required this.timeList,
    required this.currentTime,
    //required this.contentWidget,
  }) : super(key: key);

  @override
  State<TimerDialog> createState() => _TimerDialogState();
}

class _TimerDialogState extends State<TimerDialog> {
  int selected = 0;

  late UserWorkoutBloc userWorkoutBloc;

  void initState() {
    userWorkoutBloc = BlocProvider.of(context);
    super.initState();
  }

  int firstOpen = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(color: Colors.transparent)),
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.heading,
                          style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SB_1H,
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: 30.h,
                            padding: const EdgeInsets.all(10.0),
                            child: StreamBuilder<String>(
                                stream: userWorkoutBloc.timerStream,
                                initialData: null,
                                builder: (context, snapshot) {
                                  if (userWorkoutBloc.selectedTime == null) {
                                    NavRouter.pop(context);
                                  }
                                  print(
                                      "snapshot $snapshot    timer ${userWorkoutBloc.selectedTime}");

                                  firstOpen++;

                                  int totalCurrentTime = 0;
                                  if (firstOpen == 0 &&
                                      userWorkoutBloc.selectedTime != null) {
                                    totalCurrentTime = userWorkoutBloc
                                            .selectedTime! -
                                        int.parse(
                                            widget.currentTime.data.toString());
                                  } else {
                                    totalCurrentTime =
                                        userWorkoutBloc.selectedTime! -
                                            int.parse(snapshot.data.toString());
                                  }

                                  return CircularPercentIndicator(
                                    radius: 230.0,
                                    lineWidth: 10.0,
                                    percent:
                                        userWorkoutBloc.selectedTime != null
                                            ? getPercent(firstOpen == 0
                                                ? widget.currentTime
                                                : snapshot)
                                            : 1,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    startAngle: 270,
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // TextView(
                                        //   userWorkoutBloc.selectedTime != null
                                        //       ? firstOpen == 0
                                        //           ? "00:${(userWorkoutBloc.selectedTime! - int.parse(widget.currentTime.data.toString())).toString().padLeft(2, "0")}"
                                        //           : "00:${(userWorkoutBloc.selectedTime! - int.parse(snapshot.data.toString())).toString().padLeft(2, "0")}"
                                        //       : "0",
                                        //   color: Colors.black,
                                        //   fontWeight: FontWeight.w700,
                                        //   fontSize: 26,
                                        // ),
                                        TextView(
                                          userWorkoutBloc.selectedTime != null
                                              ? "${(totalCurrentTime / 60).floor().toString().padLeft(2, "0")}:${(totalCurrentTime % 60).toString().padLeft(2, "0")}"
                                              : "00:00",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 26,
                                        ),
                                        SizedBox(height: 4),
                                        TextView(
                                          userWorkoutBloc.selectedTime != null
                                              ? "${(userWorkoutBloc.selectedTime! / 60).floor().toString().padLeft(2, "0")}:${(userWorkoutBloc.selectedTime! % 60).toString().padLeft(2, "0")}"
                                              : "00:00",
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ],
                                    ),
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.5),
                                    progressColor: Colors.blue,
                                  );
                                }),
                          ),
                        ),
                        SB_1H,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                if (userWorkoutBloc.selectedTime != null)
                                  userWorkoutBloc.selectedTime =
                                      userWorkoutBloc.selectedTime! - 10;
                                //       widget.onPressed!(1);
                                // Navigator.pop(context);
                              },
                              child: Container(
                                width: 10.h,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Center(
                                    child: Text(
                                  "-10",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                userWorkoutBloc.selectedTime = null;
                                Navigator.pop(context);
                                // widget.onPressed!(1);
                                // Navigator.pop(context);
                              },
                              child: Container(
                                width: 15.h,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Colors.blue,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Center(
                                    child: Text(
                                  "Stop Timer",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (userWorkoutBloc.selectedTime != null)
                                  userWorkoutBloc.selectedTime =
                                      userWorkoutBloc.selectedTime! + 10;
                                //       widget.onPressed!(1);
                                // Navigator.pop(context);
                              },
                              child: Container(
                                width: 10.h,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Center(
                                    child: Text(
                                  "+10",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset('assets/svgs/cross_icon.svg',
                          height: 25, width: 25),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(color: Colors.transparent)),
            ),
          ],
        ),
      ),
    );
  }

  double getPercent(AsyncSnapshot<String> snapshot) {
    if (snapshot.hasData &&
        snapshot.data != null &&
        userWorkoutBloc.selectedTime != null) {
      // var values=snapshot.data!.split(":");
      // var selectedtime=userWorkoutBloc.selectedTime;

      // return (int.parse(values[1]) * selectedtime!) / 100;
      var value =
          ((int.parse(snapshot.data!) * 100) / userWorkoutBloc.selectedTime!) /
              100; // value should be between 0.0 - 1.0
      return value; // value should be between 0.0 - 1.0
    }
    return 0;
  }
}
