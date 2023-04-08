import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardInkWrapper extends StatelessWidget {
  Key? courseCardKey;
  Color? splashColor;
  BorderRadius? borderRadius;
  VoidCallback? onTap;
  Widget? child;

  CardInkWrapper(
      {this.courseCardKey,
      required this.splashColor,
      @required this.child,
      @required this.onTap,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        child!,
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius,
            splashColor: splashColor,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
