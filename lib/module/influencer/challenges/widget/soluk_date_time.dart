import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';

class SolukDateTime extends StatefulWidget {
  final Function(String) onDateChange;
  final Function(String,String) onTimeChange;

  const SolukDateTime({Key? key,required this.onDateChange,required this.onTimeChange }) : super(key: key);

  @override
  SolukDateTimeState createState() => SolukDateTimeState();
}

class SolukDateTimeState extends State<SolukDateTime> {
  String? date;
  String? time;
  String? tempTime;
  final TextEditingController _dateTimePickerController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalisation.getTranslated(context, LKDate),
                style: subTitleTextStyle(context),
              ),
              SizedBox(
                height: defaultSize.screenHeight * .01,
              ),
              SalukTextField(
                isReadable: true,
                textEditingController: _dateTimePickerController,
                hintText: date ?? "DD/MM/YYYY",
                labelText: "",
                onTap: () {
                  _showDatePicker(context, true);
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: defaultSize.screenWidth * .03,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalisation.getTranslated(context, LKTime),
                style: subTitleTextStyle(context),
              ),
              SizedBox(
                height: defaultSize.screenHeight * .01,
              ),
              SalukTextField(
                isReadable: true,
                textEditingController: _dateTimePickerController,
                hintText: time ?? "hh:mm:ss",
                labelText: "",
                onTap: () {
                  _showDatePicker(context, false);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context, bool isDate) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Material(
            child: Container(
               height:HEIGHT_5 + HEIGHT_5+HEIGHT_2,
              child: Column(
                children: [
                   Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent),
                                ),
                              ),
                            ),
                            // Spacer(),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.pop(context);
                                if (isDate) {
                              widget.onDateChange(date??'');
                        } else {
                              widget.onTimeChange(time!,tempTime!);

                        }
                        setState(() {});
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                  Container(
                    height: HEIGHT_5 + HEIGHT_5,
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      mode: isDate
                          ? CupertinoDatePickerMode.date
                          : CupertinoDatePickerMode.time,
                      onDateTimeChanged: (value) {
                        if (isDate) {
                          date = 
                          value.year.toString() +
                              "-" +
                              value.month.toString() +
                              "-" +
                             value.day.toString() ;
                              // widget.onDateChange(date??'');
                        } else {
                          tempTime = value.hour.toString() +
                              ':' +
                              value.minute.toString() +
                              ':00';
                          time = DateFormat.jm()
                              .format(value);
                              // print(temp);
                              // widget.onTimeChange(time!);

                        }
                        // setState(() {});
                      },
                      initialDateTime: DateTime.now(),
                      minimumYear: DateTime.now().year,
                      dateOrder: DatePickerDateOrder.dmy,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
