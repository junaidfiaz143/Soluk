import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

  Widget faqExpansionTileWidget(BuildContext context, String title, String description) {
    return Card(
      margin: EdgeInsets.only(top: 1.5.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.49.h),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            title: Text(
              title,
              style: labelTextStyle(context)?.copyWith(
                fontSize: defaultSize.screenHeight * .019,
                fontWeight: FontWeight.w500,
              ),
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 1.h),
                child: Text(description,
                  style: hintTextStyle(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
}
