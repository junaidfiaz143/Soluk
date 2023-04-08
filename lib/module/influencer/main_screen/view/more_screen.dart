import 'package:app/module/influencer/more/more.dart';
import 'package:app/module/influencer/more/view/bank_info.dart';
import 'package:app/module/influencer/more/widget/more_tile.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/repo/data_source/local_store.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../login/view/pre_registration_screen.dart';
import '../../workout/hive/local/my_hive.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: AppLocalisation.getTranslated(context, LKMore),
      showBackButton: false,
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalisation.getTranslated(context, LKSettings)
                    .toUpperCase(),
                style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp),
              ),
              SizedBox(
                height: defaultSize.screenHeight * .02,
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKNotification),
                asset: ALERT_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(Notifications.id);
                },
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKChangePass),
                asset: LOCK_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(ChangePassword.id);
                },
              ),
              MoreTile(
                title:
                    AppLocalisation.getTranslated(context, LKAccountSettings),
                asset: ACCOUNT_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(AccountSettings.id);
                },
              ),
              MoreTile(
                title: "Bank Information",
                asset: BANK_ICON,
                callback: () {
                  navigatorKey.currentState?.push(
                      MaterialPageRoute(builder: (_) => BankInfoScreen()));
                },
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKFeedback),
                asset: FEEDBACK_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(FeedbackScreen.id);
                },
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKPrivacyPolicy),
                asset: PRIVACYPOLICY_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(PrivacyPolicy.id);
                },
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKTermsCondition),
                asset: TERMS_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(TermsCondition.id);
                },
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKLanguages),
                asset: TRANSLATE_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(Languages.id);
                },
              ),
              SB_1H,
              const Divider(
                thickness: 1,
                height: 0,
              ),
              SizedBox(
                height: defaultSize.screenHeight * .02,
              ),
              Text(
                AppLocalisation.getTranslated(context, LKBenefits)
                    .toUpperCase(),
                style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp),
              ),
              SizedBox(
                height: defaultSize.screenHeight * .02,
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKPromoCodes),
                asset: PROMOCODE_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(PromoCode.id);
                },
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKSuggestions),
                asset: SUGGESTIONS_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(Suggestions.id);
                },
              ),
              SB_1H,
              const Divider(
                thickness: 1,
                height: 0,
              ),
              SizedBox(
                height: defaultSize.screenHeight * .02,
              ),
              Text(
                AppLocalisation.getTranslated(context, LKHelp).toUpperCase(),
                style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp),
              ),
              SizedBox(
                height: defaultSize.screenHeight * .02,
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKSupport),
                asset: SUPPORT_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(Support.id);
                },
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKFAQ),
                asset: FAQ_ICON,
                callback: () {
                  navigatorKey.currentState?.pushNamed(FAQs.id);
                },
              ),
              MoreTile(
                title: AppLocalisation.getTranslated(context, LKLogOut),
                asset: EXIT_ICON,
                isLogout: true,
                callback: () async {
                  LocalStore.removeData(LSKeyAuthToken);
                  LocalStore.removeData(LSKeySelectedLanguage);
                  MyHive.setAboutInfo(aboutMeInfo: null);
                  LocalStore.deleteData();

                  NavRouter.pushAndRemoveUntil(
                      context, const PreRegistrationScreen());
                },
              ),
              SB_1H,
            ],
          );
        },
      ),
    );
  }
}
