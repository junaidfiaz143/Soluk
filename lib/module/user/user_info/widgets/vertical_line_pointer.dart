import 'package:flutter/material.dart';


class VerticalLinePointer extends StatelessWidget {
  const VerticalLinePointer({
    Key? key,
    required this.height,
    required this.width,
    this.color = Colors.black,
  }) : super(key: key);
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: width,
      width: height,
      color: color,
    );
  }
}
