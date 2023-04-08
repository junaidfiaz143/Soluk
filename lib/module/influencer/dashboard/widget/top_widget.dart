import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget topWidget(BuildContext context, {required String name, required int notification}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${AppLocalisation.getTranslated(context, LKHi)}!', style: labelTextStyle(context)!.copyWith(
              fontSize: 18.75.sp
          )),
          Text(name, style: headingTextStyle(context),),
          // textWidget(text: name, fontSize: 18.75.sp, color: Colors.black, fontWeight: FontWeight.bold),
        ],
      ),
    ],
  );
}