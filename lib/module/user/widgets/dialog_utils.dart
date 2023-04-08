import 'package:app/animations/slide_up_transparent_animation.dart';
import 'package:app/module/influencer/widgets/reward_popup.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';

import '../../influencer/more/widget/custom_alert_dialog.dart';
import '../../influencer/widgets/saluk_gradient_button.dart';

class DialogUtils {
  void showDeleteConfirmationDialog(BuildContext context,
      Function onDeletePress, String title, String description) {
    navigatorKey.currentState?.push(
      SlideUpTransparentRoute(
        enterWidget: CustomAlertDialog(
          contentWidget: RewardPopUp(
            iconPath: 'assets/images/ic_dialog_delete.png',
            title: title,
            content: description,
            actionButtons: Row(
              children: [
                SizedBox(
                  width: defaultSize.screenWidth * .37,
                  child: SalukGradientButton(
                    title: AppLocalisation.getTranslated(context, LKYes),
                    onPressed: () {
                      Navigator.pop(context);
                      onDeletePress();
                    },
                    buttonHeight: HEIGHT_3,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: defaultSize.screenWidth * .37,
                  child: SalukGradientButton(
                    title: AppLocalisation.getTranslated(context, LKNo),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    buttonHeight: HEIGHT_3,
                    linearGradient: const LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        routeName: CustomAlertDialog.id,
      ),
    );
  }

  void showSuccessMessageDialog(BuildContext context,
      {String title = "Successful!",
      String description = "Success",
      required Function onDismiss}) {
    navigatorKey.currentState?.push(
      SlideUpTransparentRoute(
        enterWidget: CustomAlertDialog(
          sigmaX: 0,
          sigmaY: 0,
          contentWidget: RewardPopUp(
            onDismiss: onDismiss,
            iconPath: 'assets/images/ic_success_tick.png',
            title: title,
            content: description,
            actionButtons: SizedBox(
              child: SalukGradientButton(
                title: AppLocalisation.getTranslated(context, LKDone),
                onPressed: () {
                  Navigator.pop(context);
                  onDismiss();
                },
                buttonHeight: HEIGHT_2 + 5,
              ),
            ),
          ),
        ),
        routeName: CustomAlertDialog.id,
      ),
    );
  }
}
