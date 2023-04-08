import 'package:app/res/color.dart';
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({Key? key, this.color = Colors.black}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: PRIMARY_COLOR,
      ),
    );
  }
}
