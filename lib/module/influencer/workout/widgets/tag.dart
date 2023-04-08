import 'package:flutter/material.dart';

import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';

class Tag extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final VoidCallback callback;
  const Tag({
    Key? key,
    this.backgroundColor,
    this.textColor,
    required this.text,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: WIDTH_1,
          vertical: defaultSize.screenHeight * .008,
        ),
        child: Text(
          text,
          style: labelTextStyle(context)?.copyWith(
            color: textColor ?? Colors.white,
            fontSize: defaultSize.screenWidth * .03,
          ),
        ),
      ),
    );
  }
}
