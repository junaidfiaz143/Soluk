import 'package:flutter/material.dart';

import '../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../res/color.dart';
import '../../../../../res/globals.dart';
import '../../../more/widget/custom_alert_dialog.dart';
import '../../../widgets/reward_popup.dart';
import '../../../widgets/saluk_gradient_button.dart';


class ChallengerBottomRewardButton extends StatelessWidget {
  const ChallengerBottomRewardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding:
      const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 35),
      color: Colors.white,
      child: SalukGradientButton(
        title: "Give Reward",
        buttonWidth: WIDTH_5 * 2.2,
        borderColor: PRIMARY_COLOR,
        onPressed: () {
          navigatorKey.currentState?.push(
            SlideUpTransparentRoute(
              enterWidget: CustomAlertDialog(
                sigmaX: 0,
                sigmaY: 0,
                contentWidget: RewardPopUp(
                  iconPath: 'assets/images/ic_success_tick.png',
                  title: 'Successfully!',
                  content: 'Your Challenge Riward has been given successfully.',
                  actionButtons: SizedBox(
                    child: SalukGradientButton(
                      title: 'Done',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      buttonHeight: HEIGHT_2+5,
                    ),
                  ),
                ),
              ),
              routeName: CustomAlertDialog.id,
            ),
          );
        },
        buttonHeight: HEIGHT_1 + 2,
        style: labelTextStyle(context)?.copyWith(
            fontSize: defaultSize.screenWidth * .037,
            color: Colors.white,
            fontWeight: FontWeight.w600),
        borderRadius: BorderRadius.circular(
          defaultSize.screenWidth * .02,
        ),
      ),
    );
  }
}
