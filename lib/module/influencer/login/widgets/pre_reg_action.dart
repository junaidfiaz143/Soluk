import 'dart:ui';

import 'package:app/module/influencer/login/view/login_screen.dart';
import 'package:app/module/influencer/login/view/sign_up_screen.dart';
import 'package:app/module/influencer/main_screen.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:flutter/material.dart';

class PreRegAction extends StatelessWidget {
  const PreRegAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      borderRadius: BorderRadius.circular(
        defaultSize.screenHeight * .05,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: const Color(0x28ffffff).withOpacity(0.01),
              border: Border.all(
                color: DROPDOWN_BORDER_COLOR,
                width: defaultSize.screenWidth * .003,
              ),
              borderRadius: BORDER_CIRCULAR_RADIUS,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: EdgeInsets.symmetric(
              horizontal: HORIZONTAL_PADDING,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SB_1H,
                Center(
                  child: Text(
                    "Soluk",
                    style: headingTextStyle(context)?.copyWith(
                      color: Colors.white,
                      fontSize: defaultSize.screenHeight * .06,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SB_1H,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: HORIZONTAL_PADDING,
                  ),
                  child: Text(
                    AppLocalisation.getTranslated(context, LKHealthy),
                    textAlign: TextAlign.center,
                    style: subTitleTextStyle(context)?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                SB_1H,
                Container(
                  width: double.maxFinite,
                  height: HEIGHT_4,
                  decoration: BoxDecoration(
                    borderRadius: BORDER_CIRCULAR_RADIUS,
                    border: Border.all(
                      color: Colors.white,
                      width: defaultSize.screenWidth * .003,
                    ),
                  ),
                  child: InkWell(
                    splashColor: Colors.black45.withOpacity(0.2),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      navigatorKey.currentState?.pushNamedAndRemoveUntil(
                          LoginScreen.id, (_) => false);

                      ///To ByPass login screen with out credentials
                      // navigatorKey.currentState?.pushNamedAndRemoveUntil(
                      //     MainScreen.id, (route) => false);
                    },
                    child: Center(
                      child: Text(
                          AppLocalisation.getTranslated(context, LKLogin)
                              .toUpperCase(),
                          style: buttonTextStyle(context)),
                    ),
                  ),
                ),
                SB_1H,
                SalukGradientButton(
                  title: AppLocalisation.getTranslated(context, LKSignUp),
                  onPressed: () {
                    navigatorKey.currentState?.pushNamedAndRemoveUntil(
                        SignUpScreen.id, (_) => false);
                  },
                  buttonHeight: HEIGHT_4,
                ),
                SB_1H,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
