import 'package:app/module/influencer/bloc/onboarding_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/enums.dart';
import 'package:app/module/influencer/widgets/language_dropdown.dart';
import 'package:app/module/influencer/widgets/onboarding.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/view/pre_registration_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = "/onboarding_screen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final _onboardingBloc = BlocProvider.of<OnboardingBloc>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                      horizontal: HORIZONTAL_PADDING,
                    ) +
                    EdgeInsets.only(
                      top: defaultSize.screenHeight * .01,
                    ),
                child: Row(
                  children: [
                    const LanguageDropDownButton(
                      isPreRegScreen: false,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        navigatorKey.currentState?.pushNamedAndRemoveUntil(
                            PreRegistrationScreen.id, (route) => false);
                      },
                      child: Text(
                        AppLocalisation.getTranslated(context, LKSkip),
                        style: hintTextStyle(context),
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              BlocBuilder<OnboardingBloc, Screens>(
                builder: (context, state) {
                  return Onboarding(
                    svgImage: state == Screens.Screen_1
                        ? ONBOARDING_IMAGE
                        : state == Screens.Screen_2
                            ? ONBOARDING_IMAGE2
                            : ONBOARDING_IMAGE3,
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: HORIZONTAL_PADDING,
                ),
                child: BlocBuilder<OnboardingBloc, Screens>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Container(
                          width: state == Screens.Screen_1
                              ? defaultSize.screenWidth * .1
                              : defaultSize.screenWidth * .05,
                          height: defaultSize.screenHeight * .007,
                          decoration: BoxDecoration(
                            color: state == Screens.Screen_1
                                ? PRIMARY_COLOR
                                : Colors.grey,
                            borderRadius: BORDER_CIRCULAR_RADIUS,
                          ),
                        ),
                        SizedBox(
                          width: defaultSize.screenWidth * .02,
                        ),
                        Container(
                          width: state == Screens.Screen_2
                              ? defaultSize.screenWidth * .1
                              : defaultSize.screenWidth * .05,
                          height: defaultSize.screenHeight * .007,
                          decoration: BoxDecoration(
                            color: state == Screens.Screen_2
                                ? PRIMARY_COLOR
                                : Colors.grey,
                            borderRadius: BORDER_CIRCULAR_RADIUS,
                          ),
                        ),
                        SizedBox(
                          width: defaultSize.screenWidth * .02,
                        ),
                        Container(
                          width: state == Screens.Screen_3
                              ? defaultSize.screenWidth * .1
                              : defaultSize.screenWidth * .05,
                          height: defaultSize.screenHeight * .007,
                          decoration: BoxDecoration(
                            color: state == Screens.Screen_3
                                ? PRIMARY_COLOR
                                : Colors.grey,
                            borderRadius: BORDER_CIRCULAR_RADIUS,
                          ),
                        ),
                        const Spacer(),
                        SalukGradientButton(
                          title: AppLocalisation.getTranslated(context, LKNext),
                          onPressed: () {
                            if (state == Screens.Screen_1) {
                              _onboardingBloc.add(OnboardingScreen1());
                            } else if (state == Screens.Screen_2) {
                              _onboardingBloc.add(OnboardingScreen2());
                            } else if (state == Screens.Screen_3) {
                              _onboardingBloc.add(OnboardingScreen3());
                            }
                          },
                          buttonHeight: HEIGHT_4,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SB_1H,
            ],
          ),
        ),
      ),
    );
  }
}
