import 'package:app/module/influencer/more/more.dart';
import 'package:app/module/influencer/more/view/languages.dart';
import 'package:app/module/user/profile/sub_screen/privacy_settings/privacy_settings.dart';
import 'package:app/module/user/profile/sub_screen/terms_and_conditions/terms_and_conditions_screen.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

import '../sub_screen/general_settings/view/general_settings.dart';
import 'user_profile_tile.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_1.svg',
            text: 'General Settings',
            onPressed: () {
              navigatorKey.currentState?.pushNamed(GeneralSettings.id);
            },
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_2.svg',
            text: 'Languages',
            onPressed: () {
              navigatorKey.currentState?.pushNamed(Languages.id);
            },
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_3.svg',
            text: 'Privacy Settings',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PrivacySettings()));
            },
          ),
          // UserProfileTile(
          //   iconPath: 'assets/svgs/ic_profile_settings_4.svg',
          //   text: 'Legals',
          // ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_5.svg',
            text: 'Support',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Support()));
            },
          ),
          UserProfileTile(
            iconPath: 'assets/svgs/ic_profile_settings_6.svg',
            text: 'Terms & Conditions',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TermsAndConditionsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
