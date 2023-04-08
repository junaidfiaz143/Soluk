import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget customAppBar({required BuildContext context, required String title}){
  return  Padding(
    padding: EdgeInsets.only(top: 1.98.h),
    child: Row(children: [
      InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          constraints: BoxConstraints(
            maxHeight: defaultSize.screenWidth * .09,
            maxWidth: defaultSize.screenWidth * .09,
          ),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5)
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 4.15.w,
            ),
          ),
        ),
      ),
      Expanded(
        child: Align(
            alignment: Alignment.center,
            child: Text(
              title, style: subTitleTextStyle(context)
            )),
      ),
       SizedBox(
        width: 9.09.w,
      ),
    ],),
  );
}