import 'package:flutter/material.dart';

import '../../../../res/color.dart';
import '../../../../res/globals.dart';

class DottedCard extends StatelessWidget {
  const DottedCard(
      {Key? key,
      required this.cardWidth,
      required this.assetPath,
      required this.onClick})
      : super(key: key);

  final double cardWidth;
  final String assetPath;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick.call();
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              assetPath,
              fit: BoxFit.fill,
            ),
            Center(
              child: Text(
                "+\nView All",
                textAlign: TextAlign.center,
                style: headingTextStyle(context)?.copyWith(
                  fontSize: 18,
                  color: PRIMARY_COLOR,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
