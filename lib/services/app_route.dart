import 'package:app/animations/slide_up_transparent_animation.dart';
import 'package:app/module/influencer/challenges/view/participants/participants_detail_screen.dart';
import 'package:app/module/influencer/challenges/view/add_challenges.dart';
import 'package:app/module/influencer/main_screen.dart';
import 'package:app/module/influencer/more/more.dart';
import 'package:app/module/influencer/more/widget/custom_alert_dialog.dart';
import 'package:app/module/influencer/onboarding_screen.dart';
import 'package:app/module/influencer/routes.dart';
import 'package:app/module/influencer/splash_screen.dart';
import 'package:app/module/influencer/subscribers/view/subscribers_screen.dart';
import 'package:app/module/influencer/workout_programs/view/workout_programs.dart';
import 'package:app/module/user/profile/grocery_screen.dart';
import 'package:app/module/user/workout_programs/user_workout_programs.dart';
import 'package:flutter/material.dart';

import '../module/user/profile/sub_screen/general_settings/view/general_settings.dart';

class AppRoute {
  static Map<String, Widget Function(BuildContext)> route = {
    SplashScreen.id: (_) => const SplashScreen(),
    LoginScreen.id: (_) => const LoginScreen(),
    ForgotPasswordScreen.id: (_) => const ForgotPasswordScreen(),
    VerificationPinScreen.id: (_) => const VerificationPinScreen(),
    SignUpScreen.id: (_) => const SignUpScreen(),
    PreRegistrationScreen.id: (_) => const PreRegistrationScreen(),
    OnboardingScreen.id: (_) => const OnboardingScreen(),
    CreatePasswordScreen.id: (_) => const CreatePasswordScreen(),
    MainScreen.id: (_) => const MainScreen(),
    Languages.id: (_) => const Languages(),
    Notifications.id: (_) => const Notifications(),
    ChangePassword.id: (_) => const ChangePassword(),
    ResetPasswordScreen.id: (_) => const ResetPasswordScreen(),
    AccountSettings.id: (_) => const AccountSettings(),
    PromoCode.id: (_) => const PromoCode(),
    PrivacyPolicy.id: (_) => const PrivacyPolicy(),
    TermsCondition.id: (_) => const TermsCondition(),
    Support.id: (_) => const Support(),
    FAQs.id: (_) => const FAQs(),
    FeedbackScreen.id: (_) => FeedbackScreen(),
    Suggestions.id: (_) => const Suggestions(),
    SuggestionDetails.id: (_) => SuggestionDetails(),
    ChallengesScreen.id: (_) => const ChallengesScreen(),
    AddChallenges.id: (_) => const AddChallenges(),
    ParticipantsDetailsScreen.id: (_) => ParticipantsDetailsScreen(),
    SubscribersScreen.id: (_) => const SubscribersScreen(),
    WorkoutPrograms.id: (_) => WorkoutPrograms(),
    CustomAlertDialog.id: (_) =>  CustomAlertDialog(
          contentWidget: SizedBox(),
        ),
  };

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SplashScreen(),
        );
      case OnboardingScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
        );
      case LoginScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen(),
        );
      case ForgotPasswordScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ForgotPasswordScreen(),
        );
      case VerificationPinScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const VerificationPinScreen(),
        );
      case SignUpScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SignUpScreen(),
        );
      case PreRegistrationScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PreRegistrationScreen(),
        );
      case CreatePasswordScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const CreatePasswordScreen(),
        );
      case ResetPasswordScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ResetPasswordScreen(),
        );
      case MainScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainScreen(),
        );
      case Notifications.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Notifications(),
        );
      case Languages.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Languages(),
        );
      case GeneralSettings.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const GeneralSettings(),
        );
      case GroceryScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  GroceryScreen(),
        );
      case ChangePassword.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ChangePassword(),
        );
      case AccountSettings.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AccountSettings(),
        );
      case PromoCode.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PromoCode(),
        );
      case PrivacyPolicy.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PrivacyPolicy(),
        );
      case TermsCondition.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const TermsCondition(),
        );
      case FeedbackScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => FeedbackScreen(),
        );
      case Support.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Support(),
        );
      case FAQs.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const FAQs(),
        );
      case Suggestions.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const Suggestions(),
        );
      case SuggestionDetails.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SuggestionDetails(),
        );
      case ChallengesScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ChallengesScreen(),
        );
      case AddChallenges.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => AddChallenges(),
        );
      case ParticipantsDetailsScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>  ParticipantsDetailsScreen(),
        );
      case SubscribersScreen.id:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SubscribersScreen(),
        );
      case CustomAlertDialog.id:
        return SlideUpTransparentRoute(
          enterWidget:  CustomAlertDialog(
            contentWidget: SizedBox(),
          ),
          routeName: CustomAlertDialog.id,
        );
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const SplashScreen(),
    );
  }
}
