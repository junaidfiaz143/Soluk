import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget totalIncomeSubWidget(BuildContext context, {required String value, required String title}){
  return SizedBox(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value == "" ? "0" : value,
            style: headingTextStyle(context)!
                .copyWith(color: const Color(0xFF498aee), fontSize: 14.06.sp),
          ),
          SizedBox(height: 0.49.h,),
          Text(title, style: labelTextStyle(context)!.copyWith(
              color: const Color(0xFFa4a2aa),
              fontSize: 7.81.sp
          ),),
        ],
      ),
    ),
  );
}