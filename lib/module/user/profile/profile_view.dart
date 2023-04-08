import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/user/profile/sub_screen/in_active_subscription/bloc/payment_method_cubit.dart';
import 'package:app/module/user/profile/widgets/info_card.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/user_appbar.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../repo/data_source/local_store.dart';
import '../../../res/globals.dart';
import '../../../services/localisation.dart';
import '../../../utils/nav_router.dart';
import '../../influencer/login/view/pre_registration_screen.dart';
import '../../influencer/more/widget/more_tile.dart';
import '../../influencer/widgets/info_dialog_box.dart';
import '../../influencer/workout/hive/local/my_hive.dart';
import 'sub_screen/active_subscription/view/active_subcription_screen.dart';
import 'sub_screen/edit_profile/view/edit_profile_screen.dart';
import 'sub_screen/in_active_subscription/view/in_active_subcription_view.dart';
import 'widgets/settings_card.dart';
import 'widgets/subscription_card.dart';
import 'widgets/workouts_card.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // bool? isSubscribed;

  @override
  void initState() {
    super.initState();
    LoginRepository.getUserSubsciption(dummy: false, context: context);

    fetchUserName();
  }

  fetchUserName() async {
    globalUserName = await LocalStore.getData(PREFS_USERNAME);
    globalProfilePic = await LocalStore.getData(PREFS_PROFILE);
    setState(() {});
    Future.delayed(Duration(seconds: 3), () async {
      BlocProvider.of<PaymentMethodCubit>(context).onPaymentMethodChanged("");
      globalUserSubscription = await LocalStore.getData(PREFS_IS_SUBSCRIBED);

      BlocProvider.of<PaymentMethodCubit>(context).onRefresh();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext _context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: UserAppbar(
        hasBackButton: false,
        title: '',
        hasCenteredWidget: true,
        centeredWidget: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            (globalProfilePic == null || globalProfilePic == '')
                ? SvgPicture.asset(
                    'assets/svgs/placeholder.svg',
                    width: 60,
                    height: 60,
                  )
                : CircleAvatar(
                    backgroundColor: const Color(0xFFe7e7e7),
                    backgroundImage: NetworkImage(globalProfilePic!),
                    radius: 30,
                  ),
            SizedBox(height: 7),
            TextView(globalUserName!,
                fontSize: 18, fontWeight: FontWeight.w600),
            BlocConsumer<PaymentMethodCubit, PaymentMethod>(
                listener: (context, state) async {
              print('======================API Call for subscription');
              globalUserSubscription =
                  await LocalStore.getData(PREFS_IS_SUBSCRIBED);
            }, builder: (context, state) {
              solukLog(logMsg: globalUserSubscription);
              solukLog(logMsg: "consumer $state");
              return TextView(
                globalUserSubscription != null &&
                        globalUserSubscription != false
                    ? 'Active, Monthly'
                    : "Not Active Yet",
                fontSize: 10,
                color: Colors.grey,
              );
            }),
          ],
        ),
        action: [
          InkWell(
              onTap: () {
                Navigator.of(_context)
                    .push(
                        MaterialPageRoute(builder: (_) => EditProfileScreen()))
                    .then((value) {
                  LoginRepository.getUserSubsciption(
                      dummy: false, context: context);
                  fetchUserName();
                });
              },
              child: SvgPicture.asset('assets/svgs/ic_edit_profile.svg')),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileHeaderText('Workouts', topPadding: 8),
                    WorkoutsCard(),
                    ProfileHeaderText('Subscription'),
                    BlocConsumer<PaymentMethodCubit, PaymentMethod>(
                        listener: (context, state) async {
                      globalUserSubscription =
                          await LocalStore.getData(PREFS_IS_SUBSCRIBED);
                    }, builder: (context, state) {
                      solukLog(logMsg: "consumer $state");
                      return SubscriptionCard(
                        isSubscribed: globalUserSubscription,
                        call: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          globalUserSubscription != null &&
                                                  globalUserSubscription!
                                              ? ActiveSubscriptionScreen()
                                              : InActiveSubscriptionScreen()))
                              .then((value) async {
                            solukLog(
                                logMsg: value,
                                logDetail: "inside subscription_card");
                            if (value != null && value == true) {
                              setState(() {});
                              LoginRepository.getUserSubsciption(
                                  dummy: false, context: context);
                              await fetchUserName();
                              Future.delayed(Duration(seconds: 3), () async {
                                await fetchUserName();
                              });
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InfoDialogBox(
                                      icon: 'assets/images/tick_ss.png',
                                      title: AppLocalisation.getTranslated(
                                          context, LKCongratulations),
                                      description:
                                          "You have successfully subscribed to Soluk",
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    );
                                  });
                            }
                          });
                        },
                      );
                    }),
                    // SubscriptionCard(
                    //   isSubscribed: isSubscribed,
                    // ),
                    ProfileHeaderText('Settings'),
                    SettingsCard(),
                    ProfileHeaderText('Info'),
                    InfoCard(),
                    SizedBox(height: 60),
                    TextView('Version 1.0.0', color: Colors.grey, fontSize: 14),
                    SizedBox(height: 20),
                    LogoutButton(),
                    SB_1H,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeaderText extends StatelessWidget {
  const ProfileHeaderText(this.text, {Key? key, this.topPadding = 24})
      : super(key: key);
  final String text;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: 15),
      child: TextView(
        text,
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MoreTile(
      title: AppLocalisation.getTranslated(context, LKLogOut),
      asset: EXIT_ICON,
      isLogout: true,
      callback: () async {
        LocalStore.removeData(LSKeyAuthToken);
        LocalStore.removeData(LSKeySelectedLanguage);
        MyHive.setAboutInfo(aboutMeInfo: null);
        LocalStore.deleteData();
        NavRouter.pushAndRemoveUntil(context, const PreRegistrationScreen());
      },
    );
  }
}
