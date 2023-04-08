import 'package:flutter/material.dart';

import '../../../../res/color.dart';

class MealsEditWidget extends StatelessWidget {
  const MealsEditWidget({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: PRIMARY_COLOR, borderRadius: BorderRadius.circular(8)),
        child: Icon(Icons.edit, color: Colors.white, size: 16),
      ),
    );
  }
}
