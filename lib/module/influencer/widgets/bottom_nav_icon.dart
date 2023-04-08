import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavIcon extends StatelessWidget {
  final VoidCallback callback;
  final String asset;
  final bool matched;
  final String title;

  const BottomNavIcon({
    Key? key,
    required this.callback,
    required this.asset,
    required this.matched,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      behavior: HitTestBehavior.opaque,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 22,
              child: SvgPicture.asset(
                asset,
                color: matched ? PRIMARY_COLOR : null,
              ),
            ),
            SizedBox(
              height: defaultSize.screenHeight * .005,
            ),
            Text(
              title,
              style: labelTextStyle(context)?.copyWith(
                color: matched ? PRIMARY_COLOR : null,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
