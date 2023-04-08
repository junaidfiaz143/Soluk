import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

Widget subscribersTopWidget(BuildContext context, {required String subscribers}){
  return Stack(
    children: [
      SvgPicture.asset(
        'assets/svgs/subscribers_top.svg',
        width: MediaQuery.of(context).size.width,
      ),
      Positioned(
        right: 18.w,
        top: 5.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(subscribers, style: headingTextStyle(context)!.copyWith(
              color: Colors.white
            ),),
            Text(AppLocalisation.getTranslated(context, LKSubscribers), style: labelTextStyle(context)!.copyWith(
                color: Colors.white
            ),),
          ],
        ),
      )
    ],
  );
}