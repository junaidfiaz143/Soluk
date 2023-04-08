import 'dart:ui';

import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class TimeSelectionDialog extends StatefulWidget {
  static const String id = '/TimeSelectionDialog';

  // final Widget contentWidget;
  final String heading;
  final Function? onPressed;
  final List<String> timeList;

  const TimeSelectionDialog(
      {Key? key, required this.heading, this.onPressed, required this.timeList
      //required this.contentWidget,
      })
      : super(key: key);

  @override
  State<TimeSelectionDialog> createState() => _TimeSelectionDialogState();
}

class _TimeSelectionDialogState extends State<TimeSelectionDialog> {
  List<String> timeUnits = [
    "Mins",
    "Secs",
  ];

  String? selectedTimeValue = "Mins";
  final TextEditingController _minutesController = TextEditingController(),
      _secondsCountController = TextEditingController();
  int selected = 0;
  List<Widget> times = [];

  void initState() {
    widget.timeList.asMap().forEach((index, value) => {
          times.add(Text(
            value,
            style: TextStyle(
                color: selected == index ? Colors.black : Colors.grey,
                fontSize: selected == index ? 18.0 : 14.0),
          ))
        });

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
                        Text(
                          "Select a duration",
                          style: hintTextStyle(context)?.copyWith(
                            fontSize: 8.sp,
                          ),
                        ),
                        SB_1H,
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: 30.h,
                            padding: const EdgeInsets.all(10.0),
                            child: CupertinoPicker(
                                selectionOverlay:
                                    CupertinoPickerDefaultSelectionOverlay(
                                        background: Colors.transparent),
                                useMagnifier: true,
                                magnification: 1.5,
                                backgroundColor: Colors.white,
                                itemExtent: 30.0,
                                onSelectedItemChanged: (int index) {
                                  print(selected);
                                  setState(() {
                                    selected = index;
                                  });
                                  print(selected);
                                },
                                children: widget.timeList
                                    .map((e) => Text(
                                          e,
                                          style: TextStyle(
                                              fontFamily: FONT_FAMILY,
                                              fontWeight: selected ==
                                                      widget.timeList.indexOf(e)
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: selected ==
                                                      widget.timeList.indexOf(e)
                                                  ? Colors.black
                                                  : Colors.grey,
                                              fontSize: selected ==
                                                      widget.timeList.indexOf(e)
                                                  ? 18.0.sp
                                                  : 12.0.sp),
                                        ))
                                    .toList()

                                /*Text(
                                  "Text 1",
                                  style: TextStyle(
                                      color: selected ==
                                          0
                                          ? Colors
                                          .blue
                                          : Colors
                                          .black,
                                      fontSize:
                                      22.0),
                                ),
                                Text(
                                  "Text 2",
                                  style: TextStyle(
                                      color: selected ==
                                          1
                                          ? Colors
                                          .blue
                                          : Colors
                                          .black,
                                      fontSize:
                                      22.0),
                                ),
                                Text(
                                  "Text 3",
                                  style: TextStyle(
                                      color: selected ==
                                          2
                                          ? Colors
                                          .blue
                                          : Colors
                                          .black,
                                      fontSize:
                                      22.0),
                                ),*/

                                )
                            /*GestureDetector(
                              child: Column(
                                children: [

                                  IconButton(
                                    splashColor: Colors.lightGreenAccent,
                                    icon: Icon(
                                      Icons.add,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.lightBlueAccent,
                                                title: Text(
                                                  'My Dialog',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                content: Container(
                                                  height: 350.0,
                                                  width: 350.0,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: CupertinoPicker(
                                                          useMagnifier: true,
                                                          magnification: 1.5,
                                                          backgroundColor:
                                                              Colors.white,
                                                          itemExtent: 40.0,
                                                          onSelectedItemChanged:
                                                              (int index) {
                                                            print(selected);
                                                            setState(() {
                                                              selected = index;
                                                            });
                                                            print(selected);
                                                          },
                                                          children: <Widget>[
                                                            Text(
                                                              "Text 1",
                                                              style: TextStyle(
                                                                  color: selected ==
                                                                          0
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .black,
                                                                  fontSize:
                                                                      22.0),
                                                            ),
                                                            Text(
                                                              "Text 2",
                                                              style: TextStyle(
                                                                  color: selected ==
                                                                          1
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .black,
                                                                  fontSize:
                                                                      22.0),
                                                            ),
                                                            Text(
                                                              "Text 3",
                                                              style: TextStyle(
                                                                  color: selected ==
                                                                          2
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .black,
                                                                  fontSize:
                                                                      22.0),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Text('Add')
                                ],
                              ),
                            )*/
                            ,
                          ),
                        ),
                        SB_1H,
                        InkWell(
                          onTap: () {
                            widget.onPressed!(int.parse(
                                widget.timeList[selected].split(":")[1]));
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 30.h,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.all(10),
                            child: Center(
                                child: Text(
                              "Start Timer",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            )),
                          ),
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
}
