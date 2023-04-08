import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget loading(BuildContext context){
  return Container(
    height: MediaQuery.of(context).size.height * 0.4,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 2.48.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    child: const Center(child: CircularProgressIndicator(color: Colors.blueGrey,)),
  );
}