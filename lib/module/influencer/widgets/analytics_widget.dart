import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget analyticsWidget(
    {required BuildContext context,
    required Function() onPress,
    bool isViews = false}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      margin: EdgeInsets.only(top: isViews ? 1.86.h : 1.48.h),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: AssetImage(
              isViews ? 'assets/images/views.png' : 'assets/images/income.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppLocalisation.getTranslated(context, LKMy)}\n${isViews ? AppLocalisation.getTranslated(context, LKViews) : AppLocalisation.getTranslated(context, LKIncome)}',
              style: headingTextStyle(context)!.copyWith(
                color: Colors.white,
                fontSize: defaultSize.screenWidth * .055,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
      ),
    ),
  );
}
