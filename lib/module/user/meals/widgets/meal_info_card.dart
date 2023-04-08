import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/globals.dart';

class MealInfoCard extends StatelessWidget {
  const MealInfoCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.verticalDirection = VerticalDirection.down})
      : super(key: key);
  final String title;
  final String subTitle;
  final VerticalDirection? verticalDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: verticalDirection!,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: subTitleTextStyle(context)?.copyWith(
              color: Colors.black,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold),
        ),
        Text(
          subTitle,
          style: subTitleTextStyle(context)?.copyWith(
              color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
