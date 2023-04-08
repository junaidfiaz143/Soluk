import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget SubscribersNameProfileWidget(BuildContext context,
    {required String subscriberName, required String subscriberProfile}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.8.h),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(subscriberProfile),
        ),
        SizedBox(width: 4.w,),
        Text(subscriberName, style: subTitleTextStyle(context)!.copyWith(
          fontSize: 13.5.sp
        ),)
      ],
    ),
  );
}