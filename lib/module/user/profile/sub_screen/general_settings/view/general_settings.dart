import 'dart:convert';

import 'package:app/module/influencer/more/view/change_password.dart';
import 'package:app/module/influencer/more/view/notifications.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/user/profile/widgets/user_profile_tile.dart';

import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';

import 'package:flutter/material.dart';


class GeneralSettings extends StatefulWidget {
  static const String id = "/general_settings";

  const GeneralSettings({Key? key}) : super(key: key);

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        bgColor: backgroundColor,
        title: 'General Settings',
        // title: AppLocalisation.getTranslated(context, LKLanguages),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SB_1H,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  UserProfileTile(
                    iconPath: ALERT_ICON,
                    text: 'Notifications',
                    onPressed: () {
                      navigatorKey.currentState?.pushNamed(Notifications.id);
                    },
                  ),
                  UserProfileTile(
                    iconPath: LOCK_ICON,
                    text: 'Change Password',
                    onPressed: () {
                      navigatorKey.currentState?.pushNamed(ChangePassword.id);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
