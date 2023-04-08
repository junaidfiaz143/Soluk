import 'dart:ui';

import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class AddWorkoutSetsDialog extends StatefulWidget {
  static const String id = '/AddWorkoutSetsDialog';

  // final Widget contentWidget;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onChanged1;
  final ValueChanged<String> onChanged2;
  ValueChanged<String> onChanged3;
  final String selectedType;
  bool typeReadonly = false;
  final String? selectedTime;
  final String? selectedNoOfReps;
  final bool? dropSet;
  final String? customSetName;
  final String? customSetCount;

  AddWorkoutSetsDialog({
    Key? key,
    required this.onChanged,
    required this.onChanged1,
    required this.onChanged2,
    required this.selectedType,
    required this.typeReadonly,
    required this.onChanged3,
    this.selectedTime,
    this.selectedNoOfReps,
    this.dropSet,
    this.customSetName,
    this.customSetCount,
    //required this.contentWidget,
  }) : super(key: key);

  @override
  State<AddWorkoutSetsDialog> createState() => _AddWorkoutSetsDialogState();
}

class _AddWorkoutSetsDialogState extends State<AddWorkoutSetsDialog> {
  List<String> badges = ["Select", "Time", "Reps", "Failure", "Custom"];
  List<String> emptyBadgesList = [];
  List<String> timeUnits = [
    "Mins",
    "Sec",
  ];
  bool dropout = false;

  String? value = "Select";
  String? selectedTimeValue = "Mins";
  final TextEditingController _customSetNameController =
          TextEditingController(),
      _numberOfRepsController = TextEditingController(),
      _customSetCountController = TextEditingController(),
      _minutesController = TextEditingController(),
      _secondsCountController = TextEditingController();

  void initState() {
    super.initState();
    if (widget.selectedType == 'Time') {
      print('.....................${widget.selectedTime}');
      print(widget.selectedTime?.split(':')[0] ?? '');
      _minutesController.text = widget.selectedTime?.split(':')[0] ?? '';
      _secondsCountController.text = widget.selectedTime?.split(':').last ?? '';
      print(_minutesController.text);
    } else if (widget.selectedType == 'Reps') {
      print("--- inside selected No of Reps ---");
      _numberOfRepsController.text = widget.selectedNoOfReps ?? '';
      dropout = widget.dropSet!;
    } else if (widget.selectedType == 'Custom') {
      _customSetNameController.text = widget.customSetName ?? '';
      _customSetCountController.text = widget.customSetCount ?? '';
    }

    if (widget.typeReadonly == true) {
      emptyBadgesList.add(widget.selectedType);
      value = widget.selectedType;
    } else if (widget.typeReadonly == false &&
        widget.selectedType != "" &&
        widget.selectedType != "Temp") {
      value = widget.selectedType;
    } else if (widget.typeReadonly == false &&
        widget.selectedType != "" &&
        widget.selectedType != "Custom") {
      _customSetNameController.text = widget.customSetName ?? '';
    }
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
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
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
                            'Add Sets, Reps or Time',
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
                                    // items: widget.typeReadonly == false
                                    items: widget.typeReadonly == false
                                        ? badges.map((String value) {
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
                                          }).toList()
                                        : emptyBadgesList.map((String value) {
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
                          value == 'Reps'
                              ? SalukTextField(
                                  textEditingController:
                                      _numberOfRepsController,
                                  textInputType: TextInputType.number,
                                  hintText: "",
                                  labelText: "Number of Reps")
                              : const SizedBox(),
                          value == 'Reps' ? SB_1H : const SizedBox(),
                          value == 'Reps'
                              ? Row(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: PRIMARY_COLOR,
                                            ),
                                            child: Center(
                                                child: Container(
                                              width: 18,
                                              height: 18,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                  child: Container(
                                                width: 13,
                                                height: 13,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: dropout == true
                                                      ? PRIMARY_COLOR
                                                      : Colors.white,
                                                ),
                                              )),
                                            )),
                                          ),
                                          onTap: () {
                                            if (dropout == true) {
                                              setState(() {
                                                dropout = false;
                                              });
                                            } else {
                                              setState(() {
                                                dropout = true;
                                              });
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Dropset',
                                      style:
                                          subTitleTextStyle(context)?.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                )
                              : const SizedBox(),
                          value == 'Reps' ? SB_1H : const SizedBox(),
                          value == 'Custom'
                              ? SalukTextField(
                                  textEditingController:
                                      _customSetNameController,
                                  isReadable: widget.typeReadonly,
                                  hintText: "",
                                  labelText: "Enter set name")
                              : const SizedBox(),
                          value == 'Custom' ? SB_1H : const SizedBox(),
                          value == 'Custom'
                              ? SalukTextField(
                                  textEditingController:
                                      _customSetCountController,
                                  textInputType: TextInputType.number,
                                  hintText: "",
                                  labelText: "Count")
                              : const SizedBox(),
                          value == 'Custom' ? SB_1H : const SizedBox(),
                          value == 'Time'
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Time to complete set',
                                    style: subTitleTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          value == 'Time' ? SB_1H : const SizedBox(),
                          value == 'Time'
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Spacer(),
                                    Container(
                                      height: 50,
                                      width: defaultSize.screenWidth * 0.21,
                                      child: SalukTextField(
                                          textEditingController:
                                              _minutesController,
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
                                    SB_1W,
                                    const Text(
                                      ':',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25),
                                    ),
                                    SB_1W,
                                    Container(
                                      height: 50,
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
                                              _secondsCountController.text =
                                                  '59';
                                            }
                                          },
                                          hintText: "00",
                                          labelText: "ss"),
                                    ),
                                    Spacer()
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
                                    //         width:
                                    //             defaultSize.screenWidth * .003,
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
                                    //       style:
                                    //           labelTextStyle(context)?.copyWith(
                                    //         color: Colors.black,
                                    //       ),
                                    //       borderRadius: BorderRadius.all(
                                    //         Radius.circular(
                                    //           20,
                                    //         ),
                                    //       ),
                                    //       dropdownColor:
                                    //           DROPDOWN_BACKGROUND_COLOR,
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
                                )
                              : const SizedBox(),
                          value == 'Time' ? SB_1H : const SizedBox(),
                          SalukGradientButton(
                            title:
                                AppLocalisation.getTranslated(context, LKSave),
                            onPressed: () async {
                              if (value != null && value != "Select") {
                                if (value == 'Time') {
                                  if (_minutesController.text.isNotEmpty ||
                                      _secondsCountController.text.isNotEmpty) {
                                    widget.onChanged(value!);
                                    // widget.onChanged1(selectedTimeValue!);
                                    // String temp = '00:' +
                                    String temp =
                                        _minutesController.text.padLeft(2, '0');
                                    if (_secondsCountController
                                        .text.isNotEmpty) {
                                      temp += ':' +
                                          _secondsCountController.text
                                              .padLeft(2, '0');
                                    } else {
                                      temp += ':00';
                                    }
                                    widget.onChanged1(
                                        solukFormatTime(temp)["type"]!);

                                    solukLog(
                                        logMsg: solukFormatTime(temp)["type"]);
                                    widget.onChanged2(temp);
                                    Navigator.pop(context);
                                  } else {
                                    SolukToast.showToast(
                                        "Must fill all fields");
                                  }
                                } else if (value == 'Failure') {
                                  widget.onChanged(value!);
                                  widget.onChanged2(value!);
                                  Navigator.pop(context);
                                } else if (value == 'Reps') {
                                  print(
                                      "--- inside dialog to change type to Reps ---");
                                  if (_numberOfRepsController.text.isNotEmpty) {
                                    widget.onChanged(value!);
                                    widget.onChanged2(
                                        _numberOfRepsController.text.isNotEmpty
                                            ? _numberOfRepsController.text
                                                .replaceAll(
                                                    getRemovedLeadingZero(), '')
                                            : "1");
                                    widget.onChanged3(
                                        dropout == true ? 'Y' : 'N');
                                    Navigator.pop(context);
                                  } else {
                                    SolukToast.showToast(
                                        "Must fill all fields");
                                  }
                                } else if (value == 'Custom') {
                                  if (_customSetCountController
                                          .text.isNotEmpty &&
                                      _customSetNameController
                                          .text.isNotEmpty) {
                                    widget.onChanged(value!);
                                    widget.onChanged2(_customSetCountController
                                            .text.isNotEmpty
                                        ? _customSetCountController.text
                                        : "1");
                                    widget.onChanged3(
                                        _customSetNameController.text.isNotEmpty
                                            ? _customSetNameController.text
                                            : "Custom");
                                    Navigator.pop(context);
                                  } else {
                                    SolukToast.showToast(
                                        "Must fill all fields");
                                  }
                                }
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
