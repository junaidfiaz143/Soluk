import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class CircleProfileAvatar extends StatelessWidget {
  const CircleProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
            GYMINSTRUCTOR_AVATAR,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
