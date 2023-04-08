import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class RewardPopUp extends StatelessWidget {
  final String title;
  final String content;
  final Widget actionButtons;
  final Widget? subContent;
  final String iconPath;
  final Function? onDismiss;
  const RewardPopUp({
    Key? key,
    required this.title,
    required this.content,
    required this.actionButtons,
    required this.iconPath,
    this.subContent,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          defaultSize.screenHeight * .03,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  if (onDismiss != null) {
                    onDismiss!();
                  }
                },
                child: Container(
                  height: defaultSize.screenHeight * .03,
                  width: defaultSize.screenHeight * .03,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      size: defaultSize.screenHeight * .015,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Image.asset(
            iconPath,
            height: 70,
            width: 70,
          ),
          SizedBox(
            height: defaultSize.screenHeight * .02,
          ),
          Center(
            child: Text(
              title,
              style: labelTextStyle(context)?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: defaultSize.screenHeight * .01,
          ),
          Container(
            width: defaultSize.screenWidth * .62,
            alignment: Alignment.center,
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: labelTextStyle(context),
            ),
          ),
          (subContent != null) ? subContent! : SB_3H,
          actionButtons,
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
