import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  final bool isWithLogo;
  final String? logo;
  final VoidCallback? callback;
  final bool showBackButton;
  final double titleHeight;
  final bool applyPaddingH;
  final Color bgColor;
  const DefaultAppBar(
      {Key? key,
      required this.title,
      this.isWithLogo = false,
      this.logo,
      this.callback,
      this.showBackButton = true,
      this.titleHeight = 20,
      this.applyPaddingH = true,
      this.bgColor = backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      automaticallyImplyLeading: false,

      // status bar color
      flexibleSpace: Center(
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Visibility(
              visible: showBackButton,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: SolukBackButton(
                callback: () {
                  if (callback != null) {
                    callback!();
                  }
                },
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                // style: headingTextStyle(context),
                style: subTitleTextStyle(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
