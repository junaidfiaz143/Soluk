import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExerciseTile extends StatelessWidget {
  Color? titleColor;
  Color? titleDetailColor;
  String? title;
  String? titleDetail;
  var onEditPress;
  var onDeletePress;
  final double? horizontalPadding;
  ExerciseTile(
      {Key? key,
      required this.titleColor,
      required this.titleDetailColor,
      required this.title,
      required this.titleDetail,
      this.onEditPress,
      this.onDeletePress,
      this.horizontalPadding = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: horizontalPadding!),
          child: Row(
            children: [
              Text(
                title!,
                style: labelTextStyle(context)?.copyWith(
                  color: titleColor ?? Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
              SB_4W,
              Text(
                titleDetail!,
                style: labelTextStyle(context)?.copyWith(
                  color: titleDetailColor ?? Colors.grey,
                  fontSize: 12.sp,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: onEditPress,
                child: const Icon(
                  Icons.edit,
                  color: PRIMARY_COLOR,
                ),
              ),
              SB_4W,
              InkWell(
                onTap: onDeletePress,
                child: const Icon(
                  Icons.delete_outline_outlined,
                  color: RED_COLOR,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
