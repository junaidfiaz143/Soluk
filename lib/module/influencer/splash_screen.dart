import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/module/influencer/login/view/login_screen.dart';
import 'package:app/module/user/user_info/view/user_info_step_three.dart';
import 'package:app/module/user/user_info/view/user_info_step_two.dart';
import 'package:app/repo/data_source/local_store.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/nav_router.dart';
import '../common/commonbloc.dart';
import '../user/user_dashboard.dart';
import 'main_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "/splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Image? appLogo;


  @override
  void initState() {
    super.initState();
    appLogo = Image.asset(
      APP_LOGO,
      scale: defaultSize.scaleHeight,
    );
    Future.delayed(const Duration(seconds: 3), () async {
      final _languageBloc = BlocProvider.of<LanguageBloc>(context);
      String? authToken = await LocalStore.getData(LSKeyAuthToken);
      String? userType = await LocalStore.getData(PREFS_USERTYPE);
      bool? profileCompleted = await LocalStore.getData(USER_PROFILE_COMPLETED);


      if (authToken != null) {
        sl.get<AccessDataMembers>().setToken(authToken);

        if (userType == INFLUENCER) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
              MainScreen.id, (Route<dynamic> route) => false);
          // navigatorKey.currentState?.pushNamed(MainScreen.id);
        } else if (userType == NORMAL_USER) {
          if (profileCompleted == null || profileCompleted == false) {
            NavRouter.pushAndRemoveUntil(context, LoginScreen());
          } else {
            NavRouter.pushAndRemoveUntil(context, UserDashboard());
          }
        } else {
          // navigatorKey.currentState?.pushNamed(MainScreen.id);
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
              MainScreen.id, (Route<dynamic> route) => false);
        }
      } else {
        _languageBloc.add(English());
        AppLocalisation.changeLanguage("en", context);
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
            OnboardingScreen.id, (Route<dynamic> route) => false);
      }
      // NavRouter.push(context, UserDashboard());
    });
  }

  @override
  void didChangeDependencies() {
    precacheImage(appLogo!.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: defaultSize.screenHeight * .3,
              width: defaultSize.screenHeight * .3,
              child: appLogo,
            ),
          ),
        ],
      ),
    );
  }
}
