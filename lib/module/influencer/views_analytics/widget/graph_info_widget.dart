import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget graphInfoWidget({required String title, required Color color}){
  return Row(
    children: [
      CircleAvatar(
        radius: 4,
        backgroundColor: color,
      ),
      Padding(
        padding: EdgeInsets.only(left: 2.07.w),
        child: Text(title,
          style: TextStyle(
            fontSize: 7.81.sp,
          ),),
      ),
    ],
  );
}