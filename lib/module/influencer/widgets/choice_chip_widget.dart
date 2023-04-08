import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget choiceChipWidget(
  BuildContext context, {
  required String title,
  Function(bool)? onSelected,
  bool isIncomeSelected = false,
  Color unSelectedTextColor = Colors.white,
}) {
  return ChoiceChip(
    disabledColor: const Color(0xFFC4C4C4),
    selectedColor: const Color(0xFF498aee),
    onSelected: onSelected,
    label: IntrinsicWidth(
      child: Center(child: Text(title)),
    ),

    labelStyle: labelTextStyle(context)!.copyWith(
        color: isIncomeSelected ? Colors.white : Colors.black.withOpacity(0.5), fontSize: 9.3.sp),
    // labelStyle: TextStyle(
    //     color: isIncomeSelected ? Colors.white : const Color(0xFFa4a2aa),
    //     fontSize: 9.3.sp
    // ),
    selected: isIncomeSelected,
  );
}
