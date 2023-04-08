import 'dart:convert';
import 'dart:developer';

import 'package:app/module/influencer/routes.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/user/models/promo/promo_code_model.dart';
import 'package:app/module/user/user_info/view/user_info_step_one.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../user/profile/sub_screen/in_active_subscription/bloc/payment_method_cubit.dart';
import '../../../user/user_dashboard.dart';
import '../../bloc/bottom_nav_bloc.dart';
import '../../main_screen.dart';

class LoginRepository extends WebServiceImp {
  LoginRepository._();

  static Future<void> signIn(
      String emailPhoneNumber, String password, BuildContext context) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().loginAPI(
      body: {
        "emailOrPhone": emailPhoneNumber,
        "password": password,
      },
    );
    print(apiResponse.statusCode);
    print(apiResponse.data);
    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    if (response['responseCode'] != null &&
        response['responseCode'] == ACCOUNT_NOT_VERIFIED) {
      showSnackBar(
        context,
        response['responseDescription'], //response description
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      navigatorKey.currentState?.pushNamed(
        VerificationPinScreen.id,
        arguments: {
          "email": emailPhoneNumber,
          "isFromSignUpScreen": true,
          "password": password,
        },
      );
    } else if (response['responseCode'] != null &&
        response['responseCode'] != SUCCESS) {
      showSnackBar(
        context,
        response['responseDescription'],
        backgroundColor: Colors.black,
      );
    } else {
      sl.get<AccessDataMembers>().setToken(response['access_token']);
      getUserType(context: context);
    }
  }

  static Future<void> getUserSubsciption(
      {required bool? dummy, required BuildContext context}) async {
    BlocProvider.of<PaymentMethodCubit>(context).onPaymentMethodChanged("");

    ApiResponse apiResponse =
        await sl.get<WebServiceImp>().fetchGetAPI(endPoint: "api/subscription");

    solukLog(logMsg: 'GET SUBS CHECK API :: ${apiResponse.data}');

    var response = jsonDecode(apiResponse.data);

    if (response['status'] == 'success' && response['responseCode'] == "00") {
      bool? isSubscribed = response['responseDetails'] ?? false;

      globalUserSubscription = isSubscribed;

      if (dummy!) {
        solukLog(logMsg: "save dummy subscription data");

        LocalStore.saveData(PREFS_IS_SUBSCRIBED, false);
      } else {
        LocalStore.saveData(PREFS_IS_SUBSCRIBED, isSubscribed ?? false);
      }

      BlocProvider.of<PaymentMethodCubit>(context).onRefresh();
    }
  }

  static Future<void> getUserType(
      {bool? updateKeys = false, BuildContext? context}) async {
    ApiResponse apiResponse = await sl.get<WebServiceImp>().getUserTypeApi();

    log('GET USER TYPE API :: $apiResponse');

    var response = jsonDecode(apiResponse.data);

    if (response['status'] == 'success' && response['responseCode'] == "00") {
      int userId = response['responseDetails']['userId'];
      String userName = response['responseDetails']['username'];
      String userType = response['responseDetails']['userType'].toString();
      String? userProfile = response['responseDetails']['imageUrl'];
      bool? isSubscribed = response['responseDetails']['isSubscribed'];
      print('type is :: $userType');

      //
      bool? profileCompleted;
      if (userType == NORMAL_USER) {
        profileCompleted = response['responseDetails']['profileCompleted'];
        LocalStore.saveData(USER_PROFILE_COMPLETED, profileCompleted ?? false);
      }
      LocalStore.saveData(PREFS_USERID, userId.toString());
      LocalStore.saveData(PREFS_USERNAME, userName);
      LocalStore.saveData(PREFS_USERTYPE, userType);
      LocalStore.saveData(PREFS_PROFILE, userProfile ?? '');
      LocalStore.saveData(PREFS_IS_SUBSCRIBED, isSubscribed ?? false);

      print('api user type is :: $userType');

      if (updateKeys == false) {
        if (userType == INFLUENCER) {
          /// Navigate to influencer dashboard
          final _bottomNavBloc = BlocProvider.of<BottomNavBloc>(context!);
          _bottomNavBloc.add(Dashboard());
          navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(MainScreen.id, (route) => false);
        } else if (userType == NORMAL_USER) {
          /// Navigate to user dashboard

          if (profileCompleted == true) {
            navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => UserDashboard(),
                ),
                (route) => false);
          } else {
            navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => UserInfoStepOne(),
                ),
                (route) => false);
          }
        }
      }
    }
  }

  static Future<void> forgotPassword(BuildContext context, String email) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/user/forget-password",
          body: {
            "emailOrPhone": email,
          },
          isAuthTokenRequired: false,
        );
    SolukToast.closeAllLoading();
    // if(apiResponse.status == APIStatus.success)
    //  apiResponse = jsonDecode(apiResponse.data);

    // if (response['responseCode'] != null && response['responseCode'] != SUCCESS)
    if (apiResponse != null && apiResponse.status != APIStatus.success) {
      showSnackBar(context,
          apiResponse.data ?? "Server ERROR CODE : ${apiResponse.statusCode}");
    } else {
      navigatorKey.currentState?.pushNamed(
        VerificationPinScreen.id,
        arguments: {
          "email": email,
          "isFromSignUpScreen": false,
        },
      );
    }
  }

  static Future<void> resetPassword(
      String pin, String email, String password, BuildContext context) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/user/reset-password",
          body: {"email": email, "otp": pin, "newPassword": password},
          isAuthTokenRequired: false,
        );
    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    if (response['responseCode'] != null &&
        response['responseCode'] != SUCCESS) {
      invalidDataSnackBar(context, response['responseCode']);
    } else {
      showSnackBar(
        context,
        "New password created successfully.",
        textColor: Colors.white,
        backgroundColor: Colors.black,
      );
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.id,
        (_) => false,
      );
    }
  }

  static Future<void> signUp(
      String roleId,
      String fullname,
      String email,
      String password,
      String phoneNumber,
      String instagram,
      String youtube,
      String country,
      String intro,
      String contentType,
      BuildContext context) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/user/signup",
          body: {
            "fullname": fullname,
            "email": email,
            "password": password,
            "phone": phoneNumber,
            "new_password": password,
            "instagram": instagram,
            "youtube": youtube,
            "roleId": roleId,
            "country": country,
            "intro_credentials": intro,
            "contentType": contentType,
          },
          isAuthTokenRequired: false,
        );
    SolukToast.closeAllLoading();

    if (apiResponse.status == APIStatus.error) {
      if (apiResponse.statusCode == 11) {
        showSnackBar(context, "Email/Phone already exist.");
      }
    } else {
      SolukToast.showToast("Registration successful, Please login to continue",
          bgColor: Colors.black);
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.id,
        (_) => false,
      );
    }
  }

  static Future<void> verifyOTP(BuildContext context, String pin,
      {String? password}) async {
    Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: data['isFromSignUpScreen']
              ? 'api/user/account-verify'
              : "api/user/otp-verify",
          body: {
            "emailOrPhone": data['email'],
            "otp": pin,
          },
          isAuthTokenRequired: false,
        );

    SolukToast.closeAllLoading();
    if (apiResponse.status == APIStatus.success) {
      if (data['isFromSignUpScreen'] == false) {
        Navigator.pop(context);
        navigatorKey.currentState?.pushNamed(
          ResetPasswordScreen.id,
          arguments: {
            "email": data['email'],
            "pin": pin,
          },
        );
      } else {
        signIn(data['email'], data['password'], context);
      }
    } else {
      showSnackBar(context, apiResponse.data);
    }
  }

  static Future<bool> verifyPromoCode(String code) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
          endPoint: "api/promocodes/$code",
          isAuthTokenRequired: false,
        );

    SolukToast.closeAllLoading();
    if (apiResponse.status == APIStatus.success) {
      var response = json.decode(apiResponse.data);
      PromoCodeModel model = PromoCodeModel.fromJson(response);

      if (model.responseDetails?.data?.isNotEmpty == true) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<void> resendOTP(BuildContext context) async {
    Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    SolukToast.showLoading();
    ApiResponse apiResponse = (await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/login",
          body: {
            "emailOrPhone": data['email'],
            "password": data['password'],
          },
          isAuthTokenRequired: false,
        ));
    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    if (response['responseCode'] != null &&
        response['responseCode'] == ALREADY_EXIST) {
      showSnackBar(context, "Code successfully sent to your email");
    }
    if (response['responseCode'] != null &&
        response['responseCode'] != SUCCESS) {
      invalidDataSnackBar(context, response['responseCode']);
    } else {
      sl.get<AccessDataMembers>().setToken(response['access_token']);
    }
  }
}
