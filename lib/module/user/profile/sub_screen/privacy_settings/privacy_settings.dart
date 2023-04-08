
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/user/profile/sub_screen/privacy_settings/PrivacySettingsModel.dart';
import 'package:app/module/user/profile/sub_screen/privacy_settings/privacy_settings_bloc.dart';

import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../influencer/widgets/notification_switch.dart';

class PrivacySettings extends StatefulWidget {
  static const String id = "/general_settings";

  const PrivacySettings({Key? key}) : super(key: key);

  @override
  State<PrivacySettings> createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  @override
  Widget build(BuildContext context) {
    PrivacySettingsBloc _privacySettingsBloc=BlocProvider.of(context);
    _privacySettingsBloc.getPrivacySettings();
    return Scaffold(
      body: AppBody(
        bgColor: backgroundColor,
        title: 'Privacy Settings',
        // title: AppLocalisation.getTranslated(context, LKLanguages),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SB_1H,
            StreamBuilder<ResponseDetails>(
              stream: _privacySettingsBloc.privacySettingsStream,
              builder: (context, snapshot) {
                ResponseDetails? responseDetail = snapshot.data;

                return responseDetail != null ?  Column(
                  children: [
                    SB_1H,
                    Container(
                      height: HEIGHT_4,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            spreadRadius: 4.0,
                            blurRadius: 14.0,
                          ),
                        ],
                        borderRadius: BORDER_CIRCULAR_RADIUS,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: WIDTH_1,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ALERT_ICON,
                              color: PRIMARY_COLOR,
                              height: WIDTH_4,
                              width: WIDTH_4,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              "Show Badges",
                              style: labelTextStyle(context),
                            ),
                            const Spacer(),
                            NotificationSwitch(initialValue : responseDetail.allowBagdes == 1 ? true : false , callback: (value) {
                              _privacySettingsBloc.updatePrivacySettings(body: {"allowBagdes": value ? "1": "0"});
                            })
                          ],
                        ),
                      ),
                    ),
                    SB_1H,
                    Container(
                      height: HEIGHT_4,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            spreadRadius: 4.0,
                            blurRadius: 14.0,
                          ),
                        ],
                        borderRadius: BORDER_CIRCULAR_RADIUS,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: WIDTH_1,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ALERT_ICON,
                              color: PRIMARY_COLOR,
                              height: WIDTH_4,
                              width: WIDTH_4,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              "Direct Messages",
                              style: labelTextStyle(context),
                            ),
                            const Spacer(),
                            NotificationSwitch(initialValue : responseDetail.allowDirectMessages == 1 ? true : false, callback: (value) {
                              _privacySettingsBloc.updatePrivacySettings(body: {"allowDirectMessages": value ? "1": "0"});
                            })
                          ],
                        ),
                      ),
                    ),
                    SB_1H,
                    Container(
                      height: HEIGHT_4,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            spreadRadius: 4.0,
                            blurRadius: 14.0,
                          ),
                        ],
                        borderRadius: BORDER_CIRCULAR_RADIUS,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: WIDTH_1,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ALERT_ICON,
                              color: PRIMARY_COLOR,
                              height: WIDTH_4,
                              width: WIDTH_4,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              "Show Socail Meida accounts",
                              style: labelTextStyle(context),
                            ),
                            const Spacer(),
                            NotificationSwitch(initialValue : responseDetail.allowSocialMediaAccounts == 1 ? true : false, callback: (value) {
                              _privacySettingsBloc.updatePrivacySettings(body: {"allowSocialMediaAccounts": value ? "1": "0"});
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                ):Container();
              }
            )
          ],
        ),
      ),
    );
  }
}

typedef BoolCallback = Function(bool value);

