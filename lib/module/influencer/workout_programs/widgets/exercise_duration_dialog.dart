import 'dart:ui';

import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/soluk_toast.dart';

class ExerciseDurationDialog extends StatefulWidget {
  static const String id = '/ExerciseDurationDialog';
  // final Widget contentWidget;
  final String heading;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onChanged2;
  final Function? onPressed;
  final String? minutes;
  final String? second;

  const ExerciseDurationDialog(
      {Key? key,
      required this.heading,
      required this.onChanged,
      required this.onChanged2,
      this.minutes,
      this.second,
      this.onPressed
      //required this.contentWidget,
      })
      : super(key: key);

  @override
  State<ExerciseDurationDialog> createState() => _ExerciseDurationDialogState();
}

class _ExerciseDurationDialogState extends State<ExerciseDurationDialog> {
  List<String> timeUnits = [
    "Mins",
    "Secs",
  ];

  String? selectedTimeValue = "Mins";
  final TextEditingController _minutesController = TextEditingController(),
      _secondsCountController = TextEditingController();
  void initState() {
    solukLog(logMsg: widget.minutes);
    _minutesController.text = (widget.minutes?.split(':')[0]) ?? '';
    _secondsCountController.text = (widget.minutes?.split(':').last) ?? '';
    super.initState();
  }

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
                        vertical: 30,
                      ),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            widget.heading,
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          SB_1H,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(right: 10),
                                width: defaultSize.screenWidth * 0.21,
                                child: SalukTextField(
                                    textEditingController: _minutesController,
                                    textInputType: TextInputType.number,
                                    onChange: (m) {
                                      if (m.length > 2) {
                                        _minutesController.text =
                                            m.substring(0, 2);
                                      }
                                      if (int.parse(m) > 59) {
                                        _minutesController.text = '59';
                                      }
                                    },
                                    hintText: "00",
                                    labelText: "mm"),
                              ),
                              const Text(
                                ':',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25),
                              ),
                              //SB_1W,
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(left: 10),
                                width: defaultSize.screenWidth * 0.2,
                                child: SalukTextField(
                                    textEditingController:
                                        _secondsCountController,
                                    textInputType: TextInputType.number,
                                    onChange: (s) {
                                      if (s.length > 2) {
                                        _secondsCountController.text =
                                            s.substring(0, 2);
                                      }
                                      if (int.parse(s) > 59) {
                                        _secondsCountController.text = '59';
                                      }
                                    },
                                    hintText: "00",
                                    labelText: "ss"),
                              ),
                              Spacer(),

                              //SB_1W,
                              // Container(
                              //   height: 50,
                              //   width: defaultSize.screenWidth * 0.2,
                              //   child: Container(
                              //     width: defaultSize.screenWidth,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(
                              //         10,
                              //       ),
                              //       border: Border.all(
                              //         width: defaultSize.screenWidth * .003,
                              //         color: PRIMARY_COLOR,
                              //       ),
                              //       color: Colors.transparent,
                              //     ),
                              //     padding: EdgeInsets.symmetric(
                              //       horizontal: defaultSize.screenWidth * .03,
                              //     ),
                              //     clipBehavior: Clip.antiAliasWithSaveLayer,
                              //     child: DropdownButton<String>(
                              //       underline: const SizedBox(),
                              //       style: labelTextStyle(context)?.copyWith(
                              //         color: Colors.black,
                              //       ),
                              //       borderRadius: const BorderRadius.all(
                              //         Radius.circular(
                              //           20,
                              //         ),
                              //       ),
                              //       dropdownColor: DROPDOWN_BACKGROUND_COLOR,
                              //       isExpanded: true,
                              //       value: selectedTimeValue ?? "",
                              //       items: timeUnits.map((String value) {
                              //         return DropdownMenuItem<String>(
                              //           value: value,
                              //           child: Row(
                              //             mainAxisSize: MainAxisSize.min,
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
                          ),
                          SB_1H,
                          SalukGradientButton(
                            title:
                                AppLocalisation.getTranslated(context, LKSave),
                            onPressed: () async {
                              if (selectedTimeValue != null) {
                                if (_minutesController.text.isNotEmpty ||
                                    _secondsCountController.text.isNotEmpty) {
                                  // if (_minutesController.text.isEmpty) {
                                  //   _minutesController.text = "00";
                                  // }
                                  // if (_secondsCountController.text.isEmpty) {
                                  //   _secondsCountController.text = "00";
                                  // }
                                  // String temp =
                                  //     _minutesController.text.padLeft(2, "0") +
                                  //         ':' +
                                  //         _secondsCountController.text;
                                  String temp =
                                      _minutesController.text.padLeft(2, '0');
                                  if (_secondsCountController.text.isNotEmpty) {
                                    temp += ':' +
                                        _secondsCountController.text
                                            .padLeft(2, '0');
                                  } else {
                                    temp += ':00';
                                  }

                                  widget.onChanged(temp);
                                  // widget.onChanged2(selectedTimeValue!);
                                  widget.onChanged2(
                                      solukFormatTime(temp)["type"]!);
                                  widget.onPressed?.call();
                                  Navigator.pop(context);
                                } else {
                                  SolukToast.showToast("Must fill time values");
                                }

                                // String temp = "";

                                // widget.onChanged(temp);
                                // widget.onChanged2(selectedTimeValue!);
                                // widget
                                //     .onChanged2(solukFormatTime(temp)["type"]!);

                                // widget.onPressed?.call();
                                // Navigator.pop(context);

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) => AddExercise(
                                //       title: 'Add Exercise',
                                //       workoutType: value,
                                //     ),
                                //   ),
                                // );
                              }
                            },
                            buttonHeight: HEIGHT_3,
                            dim: (selectedTimeValue != null) ? false : true,
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
