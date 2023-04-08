import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';

class MoreTile extends StatelessWidget {
  final String title, asset;
  final VoidCallback callback;
  const MoreTile({
    Key? key,
    required this.title,
    required this.asset,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: SizedBox(
        height: HEIGHT_2,
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              height: defaultSize.screenHeight * .035,
              width: defaultSize.screenHeight * .035,
              color: Colors.black,
            ),
            SizedBox(
              width: WIDTH_1,
            ),
            Text(
              title,
              style: labelTextStyle(context),
            ),
            const Spacer(),
            SvgPicture.asset(
              IOS_ICON_FORWARD,
              height: defaultSize.screenHeight * .04,
              width: defaultSize.screenHeight * .04,
            ),
          ],
        ),
      ),
    );
  }
}
