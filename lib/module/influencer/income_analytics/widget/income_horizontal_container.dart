import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'total_income_sub_widget.dart';


Widget incomeHorizontalContainer(BuildContext context, {bool isExpansion = false, required String title, required String totalIncome, required String directSubEarning, required String viewsEarning}){
  return Padding(
    padding: EdgeInsets.only(top: isExpansion ? 0.0 : 2.98.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isExpansion ? const SizedBox() :  Text(title, style: headingTextStyle(context)!.copyWith(
          fontSize: 15.6.sp
        ),),
        Container(
          height: isExpansion ? 8.69.h : 12.4.h,
          margin: EdgeInsets.only(top: isExpansion ? 0.0 : 1.49.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              totalIncomeSubWidget(context, value: totalIncome, title: AppLocalisation.getTranslated(context, LKTotalIncome)),
              totalIncomeSubWidget(context, value: directSubEarning, title: AppLocalisation.getTranslated(context, LKDirSubEarnings)),
              totalIncomeSubWidget(context, value: viewsEarning, title: AppLocalisation.getTranslated(context, LKViewEarnings)),
            ],
          ),
        )
      ],
    ),
  );
}