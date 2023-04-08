import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView(
    this.text, {
    Key? key,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.textAlign = TextAlign.center,
    this.color = Colors.black,
    this.maxLines,
        this.overflow
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final double? height;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      ),
    );
  }
}
