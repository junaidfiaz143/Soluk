import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/color.dart';

Widget infoWidget(BuildContext context,
    {bool isPublished = false, required String type, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        value,
        style: headingTextStyle(context)!.copyWith(fontSize: 15.6.sp),
      ),
      SizedBox(
        height: 1.4.h,
      ),
      Text(
        type,
        style: labelTextStyle(context)!
            .copyWith(color: const Color(0xFFa4a2aa), fontSize: 9.3.sp),
      ),
      SizedBox(
        height: 2.h,
      ),
      Container(
        height: 2.23.h,
        width: 2.23.h,
        color: isPublished ? PRIMARY_COLOR : SECONDARY_COLOR,
      )
    ],
  );
}
