import 'dart:ui';

import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/workout_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_exersise_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SupersetCircuitTypeDialog extends StatefulWidget {
  static const String id = '/SupersetCircuitTypeDialog';
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  final String? supersetImage;
  final String? title;
  final bool? isCircuit;
  final int? exerciseId;

  const SupersetCircuitTypeDialog(
      {Key? key,
      required this.workoutID,
      required this.weekID,
      required this.dayID,
      required this.isCircuit,
      required this.exerciseId,
      required this.supersetImage,
      this.title})
      : super(key: key);

  @override
  State<SupersetCircuitTypeDialog> createState() =>
      _SupersetCircuitTypeDialogState();
}

class _SupersetCircuitTypeDialogState extends State<SupersetCircuitTypeDialog> {
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
  final TextEditingController _minutesController = TextEditingController(),
      _secondsCountController = TextEditingController();
  CircuitWorkOutCubit circuitWorkOutCubit = CircuitWorkOutCubit();
  WorkOutModel? data;

  @override
  void initState() {
    data = WorkOutModel(
        workoutType: value,
        numberOfRounds: numberOfRounds,
        workoutID: widget.workoutID,
        weekID: widget.weekID,
        dayID: widget.dayID,
        isCircuit: widget.isCircuit,
        exerciseId: widget.exerciseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: BlocConsumer<CircuitWorkOutCubit, CircuitWorkOutState>(
          bloc: circuitWorkOutCubit,
          listener: (context, state) async {
            // if (state is ExerciseError) {
            //   showSnackBar(
            //     context,
            //     state.message!,
            //     textColor: Colors.white,
            //   );
            // } else if (state is RoundsLoaded) {
            //   //Navigator.pop(context);
            //   if (value == "Rounds") {
            //     if (state.roundsList!.length > 0) {
            //       ///FOR NOW WE ARE USING SINGLE ROUND
            //       data!.roundId = state.roundsList![0].id;
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (_) => AddRound(
            //             data: data!,
            //             roundsList: state.roundsList,
            //           ),
            //         ),
            //       );
            //     }
            //   } else {
            //     if (state.roundsList!.length > 0) {
            //       data!.timeDuration = state.roundsList![0].exerciseTime;
            //       data!.roundId = state.roundsList![0].id;
            //       data!.workoutType = "Time Based";
            //       data!.superSetImage = widget.supersetImage;
            //       data!.title = widget.title;
            //        Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (_) => AddTimeBasedExercise(
            //             data: data!,
            //           ),
            //         ),
            //       );
            //     }
            //   }
            // }
          },
          builder: (context, state) {
            return BackdropFilter(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.maxFinite,
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
                          horizontal:
                              HORIZONTAL_PADDING + HORIZONTAL_PADDING / 2,
                          vertical: 30,
                        ),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Text(
                              'Create ${widget.isCircuit == true ? "Circuit" : "Superset"}',
                              style: subTitleTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            SB_1H,
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
                                      borderRadius: BorderRadius.all(
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
                            SB_1H,
                            value == 'Rounds'
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppLocalisation.getTranslated(
                                          context, LKNumberofRounds),
                                      style:
                                          subTitleTextStyle(context)?.copyWith(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            value == 'Rounds' ? SB_1H : const SizedBox(),
                            value == 'Rounds'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: WIDTH_6 * 1.8,
                                        height: HEIGHT_3,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(10.0),
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
                                                  if (numberOfRounds > 0) {
                                                    setState(() {
                                                      numberOfRounds--;
                                                    });
                                                  }
                                                },
                                                child: Center(
                                                  child: Text(
                                                    '-',
                                                    style: labelTextStyle(
                                                            context)
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
                                                    style: labelTextStyle(
                                                            context)
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontSize: 25),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            value == 'Rounds' ? SB_1H : const SizedBox(),
                            value == 'Time Base'
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppLocalisation.getTranslated(
                                          context, LKTimeCompleteSet),
                                      style:
                                          subTitleTextStyle(context)?.copyWith(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            value == 'Time Base' ? SB_1H : const SizedBox(),
                            value == 'Time Base'
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: defaultSize.screenWidth * 0.22,
                                        child: SalukTextField(
                                            textEditingController:
                                                _minutesController,
                                            hintText: "",
                                            onChange: (m) {
                                              if (m.length > 2) {
                                                _minutesController.text =
                                                    m.substring(0, 2);
                                              }
                                              if (int.parse(m) > 59) {
                                                _minutesController.text = '59';
                                              }
                                            },
                                            textInputType: TextInputType.number,
                                            labelText: "mm"),
                                      ),
                                      const Text(
                                        ' : ',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 22),
                                      ),
                                      //SB_1W,
                                      Container(
                                        height: 50,
                                        width: defaultSize.screenWidth * 0.22,
                                        child: SalukTextField(
                                            textEditingController:
                                                _secondsCountController,
                                            hintText: "",
                                            onChange: (m) {
                                              if (m.length > 2) {
                                                _minutesController.text =
                                                    m.substring(0, 2);
                                              }
                                              if (int.parse(m) > 59) {
                                                _minutesController.text = '59';
                                              }
                                            },
                                            textInputType: TextInputType.number,
                                            labelText: "ss"),
                                      ),
                                      //SB_1W,
                                      // Container(
                                      //   height: 50,
                                      //   width: defaultSize.screenWidth * 0.22,
                                      //   child: Container(
                                      //     width: defaultSize.screenWidth,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(
                                      //         10,
                                      //       ),
                                      //       border: Border.all(
                                      //         width: defaultSize.screenWidth *
                                      //             .003,
                                      //         color: PRIMARY_COLOR,
                                      //       ),
                                      //       color: Colors.transparent,
                                      //     ),
                                      //     padding: EdgeInsets.symmetric(
                                      //       horizontal:
                                      //           defaultSize.screenWidth * .03,
                                      //     ),
                                      //     clipBehavior:
                                      //         Clip.antiAliasWithSaveLayer,
                                      //     child: DropdownButton<String>(
                                      //       underline: const SizedBox(),
                                      //       style: labelTextStyle(context)
                                      //           ?.copyWith(
                                      //         color: Colors.black,
                                      //       ),
                                      //       borderRadius:
                                      //           const BorderRadius.all(
                                      //         Radius.circular(
                                      //           20,
                                      //         ),
                                      //       ),
                                      //       dropdownColor:
                                      //           DROPDOWN_BACKGROUND_COLOR,
                                      //       isExpanded: true,
                                      //       value: selectedTimeValue ?? "",
                                      //       items:
                                      //           timeUnits.map((String value) {
                                      //         return DropdownMenuItem<String>(
                                      //           value: value,
                                      //           child: Row(
                                      //             mainAxisSize:
                                      //                 MainAxisSize.min,
                                      //             children: [
                                      //               Text(value),
                                      //             ],
                                      //           ),
                                      //           onTap: () {},
                                      //         );
                                      //       }).toList(),
                                      //       onChanged: (_) {
                                      //         if (_ != null && _.isNotEmpty) {
                                      //           setState(() {
                                      //             selectedTimeValue = _;
                                      //           });
                                      //         }
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  )
                                : const SizedBox(),
                            value == 'Time Base' ? SB_1H : const SizedBox(),
                            SalukGradientButton(
                              title: AppLocalisation.getTranslated(
                                  context, LKSave),
                              onPressed: () async {
                                if (value != null && value != "Select") {
                                  if (value == "Rounds") {
                                    // circuitWorkOutCubit.addRounds(
                                    //     data: {"count": numberOfRounds},
                                    //     exerciseData: data);
                                    Navigator.pop(
                                        context, [value, "$numberOfRounds"]);
                                  } else {
                                    if (selectedTimeValue != null &&
                                        _minutesController.text != '') {
                                      String temp = _minutesController.text +
                                          ':' +
                                          _secondsCountController.text;
                                      Navigator.pop(context, [value, '$temp']);

                                      // circuitWorkOutCubit.addTimebaseSuperSet(
                                      //     data: {'exerciseTime': "00:$temp"},
                                      //     exerciseData: data);
                                    } else {
                                      showSnackBar(context,
                                          "Please Add time to continue");
                                    }
                                  }
                                }
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
                  Expanded(
                    child: GestureDetector(
                        child: Container(color: Colors.transparent)),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
