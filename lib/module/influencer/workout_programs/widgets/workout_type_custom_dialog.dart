import 'dart:async';
import 'dart:ui';

import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/views/circuit_workout_screen.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/long_video/view/long_video_excersise.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/single_work_out/view/single_work_exercise.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

class WorkoutTypeCustomDialog extends StatefulWidget {
  static const String id = '/WorkoutTypeCustomDialog';
  final Widget contentWidget;
  final String workoutID;
  final String weekID;
  final String dayID;
  final data;
  const WorkoutTypeCustomDialog({
    Key? key,
    required this.contentWidget,
    required this.workoutID,
    required this.weekID,
    required this.dayID,
    required this.data,
  }) : super(key: key);

  @override
  State<WorkoutTypeCustomDialog> createState() =>
      _WorkoutTypeCustomDialogState();
}

class _WorkoutTypeCustomDialogState extends State<WorkoutTypeCustomDialog> {
  List<String> badges = [
    "Select",
    "Single Workout",
    "Superset",
    "Circuit",
    "Long Video"
  ];

  String? value = "Select";
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.maxFinite,
                    height: HEIGHT_5 * 3,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: HORIZONTAL_PADDING + HORIZONTAL_PADDING / 2,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            AppLocalisation.getTranslated(
                                context, LKWorkoutType),
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: HEIGHT_3,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
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
                                )),
                          ),
                          SalukGradientButton(
                            title:
                                AppLocalisation.getTranslated(context, LKNext),
                            onPressed: () async {
                              Navigator.pop(context, value);

                              // if (value != null && value != "Select") {
                              //   if (value == "Long Video") {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (_) => LongVideoExerciseScreen(
                              //           title: AppLocalisation.getTranslated(
                              //               context, LKAddExercises),
                              //           workoutType: value,
                              //           workoutID: widget.workoutID,
                              //           weekID: widget.weekID,
                              //           dayID: widget.dayID,
                              //         ),
                              //       ),
                              //     ).then((value) =>
                              //         Navigator.of(context).pop(value));
                              //   } else if (value == "Single Workout") {
                              //     //Navigator.pop(context);
                              //     // Navigator.pop(context);
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (_) =>
                              //             SingleWorkOutExerciseScreen(
                              //           title: AppLocalisation.getTranslated(
                              //               context, LKAddExercises),
                              //           workoutID: widget.workoutID,
                              //           weekID: widget.weekID,
                              //           dayID: widget.dayID,
                              //           data: widget.data,
                              //         ),
                              //       ),
                              //     ).then((value) {
                              //       Navigator.of(context).pop(value);
                              //     });
                              //   } else {
                              //     Navigator.pop(context);
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (_) => CircuitWorkOutScreen(
                              //           title: AppLocalisation.getTranslated(
                              //               context, LKDayExercise),
                              //           workoutID: widget.workoutID,
                              //           weekID: widget.weekID,
                              //           dayID: widget.dayID,
                              //           workoutType: value,
                              //           circuitScreen:
                              //               value == 'Circuit' ? true : false,
                              //         ),
                              //       ),
                              //     ).then((value) =>
                              //         Navigator.of(context).pop(value));
                              //   }
                              //   // Navigator.pop(context);
                              // }
                            },
                            buttonHeight: HEIGHT_3,
                            dim: (value != null && value != "Select")
                                ? false
                                : true,
                          ),
                        ],
                      ),
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
                      width: 20,
                      height: 20,
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
}
