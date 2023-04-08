import 'package:app/module/influencer/income_analytics/widget/total_income_sub_widget.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget viewHorizontalContainer(BuildContext context,
    {bool isExpansion = false,
    required String title,
    required String totalViews,
    required String blogViews,
    required String workoutView}) {
  return Padding(
    padding: EdgeInsets.only(top: isExpansion ? 0.0 : 2.98.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isExpansion
            ? const SizedBox()
            : Text(
                title,
                style: headingTextStyle(context)!.copyWith(fontSize: 15.6.sp),
              ),
        Container(
          height: isExpansion ? 8.69.h : 12.4.h,
          margin: EdgeInsets.only(top: isExpansion ? 0.0 : 1.49.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          width: blogViews == '' ? 150 : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              totalIncomeSubWidget(context,
                  value: totalViews,
                  title: AppLocalisation.getTranslated(context, LKTotalViews)),
              if (blogViews != '')
                totalIncomeSubWidget(context,
                    value: blogViews, title: "Blog Views"),
              if (workoutView != '')
                totalIncomeSubWidget(context,
                    value: workoutView, title: "Workout Views")
            ],
          ),
        )
      ],
    ),
  );
}
