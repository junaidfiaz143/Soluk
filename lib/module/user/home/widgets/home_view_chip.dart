import 'package:flutter/material.dart';

import '../../../../res/color.dart';
import '../../../../res/globals.dart';

class HomeViewChip extends StatelessWidget {
   HomeViewChip(
      {Key? key,
      required this.label,
      required this.isSelectedChip})
      : super(key: key);

  final String label;
  final bool isSelectedChip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        backgroundColor: isSelectedChip ? PRIMARY_COLOR : Colors.white,
        shape: StadiumBorder(side: BorderSide(color: PRIMARY_COLOR)),
        label: Text(
          label,
          style: isSelectedChip
              ? labelTextStyle(context)?.copyWith(
                  color: Colors.white,
                )
              : hintTextStyle(context)?.copyWith(color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
