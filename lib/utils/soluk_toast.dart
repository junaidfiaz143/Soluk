import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SolukToast {
  static showToast(String? message,
      {Color bgColor = Colors.red, Color textColor = Colors.white}) {
    BotToast.showText(
        text: message!,
        contentColor: bgColor,
        textStyle: TextStyle(color: textColor, fontSize: 12.sp),
        duration: Duration(seconds: 2));
  }

  static showLoading() {
    BotToast.showLoading();
  }

  static closeAllLoading() {
    BotToast.closeAllLoading();
  }
}
