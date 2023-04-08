import 'dart:convert';

import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/user/profile/sub_screen/in_active_subscription/bloc/payment_method_cubit.dart';
import 'package:app/res/constants.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokenFormat.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';

import '../../../repo/data_source/remote_data_source.dart';
import '../../../repo/repository/web_service.dart';
import '../../../res/globals.dart';
import '../../../utils/dependency_injection.dart';

class Subscription {
  static final String CARD = "card";
  static final String APPLE_PAY = "apple_pay";
  static final String GOOGLE_PAY = "google_pay";
  static String CART_ID = "";

  static generateCartId() async {
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(endPoint: "api/generate-cart", body: {});

    var jsonResponse = jsonDecode(apiResponse.data);

    CART_ID = "${jsonResponse["responseDetails"]["cart_id"]}";

    solukLog(logMsg: jsonResponse["responseDetails"]["cart_id"]);
  }

  static Future<PaymentSdkConfigurationDetails> generateConfig() async {
    var appLanguage = await AppLocalisation.getLocale().then((language) {
      solukLog(logMsg: language);
      return language.toString();
    });
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.STC_PAY);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: PAY_PROFILE_ID,
        serverKey: PAY_SERVER_KEY,
        clientKey: PAY_CLIENT_KEY,
        // cartId: "${DateTime.now().millisecondsSinceEpoch}",
        cartId: CART_ID,
        cartDescription: "Soluk Subscription",
        merchantName: PAY_MERCHANT_NAME,
        screentTitle: "Pay with Card",
        amount: subscriptionCharges,
        locale: appLanguage.contains("en") ? PaymentSdkLocale.EN : PaymentSdkLocale.AR,
        showBillingInfo: true,
        forceShippingInfo: false,
        currencyCode: PAY_CURRENCY_CODE,
        merchantCountryCode: PAY_MERCHANT_COUNTRY_CODE,
        alternativePaymentMethods: apms,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();

    theme.logoImage = APP_LOGO;

    // theme.primaryFont = "Neo sans";
    // theme.buttonColor = "#000000";
    // theme.titleFontColor = "#6g6g6g";

    configuration.iOSThemeConfigurations = theme;

    return configuration;
  }

  static Future<PaymentSdkConfigurationDetails> generateConfigApplePay() async {
    var appLanguage = await AppLocalisation.getLocale().then((language) {
      solukLog(logMsg: language);
      return language.toString();
    });
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.STC_PAY);
    var configuration = PaymentSdkConfigurationDetails(
      profileId: PAY_PROFILE_ID,
      serverKey: PAY_SERVER_KEY,
      clientKey: PAY_CLIENT_KEY,
      cartId: "${DateTime.now().millisecondsSinceEpoch}",
      cartDescription: "Soluk Subscription",
      merchantName: PAY_MERCHANT_NAME,
      screentTitle: "Pay with Card",
      amount: subscriptionCharges,
      locale: appLanguage.contains("en") ? PaymentSdkLocale.EN : PaymentSdkLocale.AR,
      showBillingInfo: true,
      forceShippingInfo: false,
      currencyCode: PAY_CURRENCY_CODE,
      merchantCountryCode: PAY_MERCHANT_COUNTRY_CODE,
      merchantApplePayIndentifier: "merchant.com.bundleID",
      tokeniseType: PaymentSdkTokeniseType.MERCHANT_MANDATORY,
      tokenFormat: PaymentSdkTokenFormat.AlphaNum20Format,
    );

    var theme = IOSThemeConfigurations();

    theme.logoImage = APP_LOGO;

    // theme.primaryFont = "Neo sans";
    // theme.buttonColor = "#000000";
    // theme.titleFontColor = "#6g6g6g";

    configuration.iOSThemeConfigurations = theme;

    return configuration;
  }

  static Future<void> startPayment({required paymentMethod, required BuildContext context}) async {
    if (paymentMethod == CARD) {
      FlutterPaytabsBridge.startCardPayment(await generateConfig(), (event) {
        // setState(() {
        if (event["status"] == "success") {
          // print(generateConfig());
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          print(event);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            isPayment_Demo = true;
            BlocProvider.of<PaymentMethodCubit>(context).onTransactionChanged(true);
            Navigator.pop(context, true);
            LoginRepository.getUserSubsciption(dummy: false, context: context);
            // context.read<PaymentMethodCubit>().onTransactionChanged(true);

            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (_) => ProfileView()),
            //     (route) => false);
          } else {
            print("failed transaction");
            isPayment_Demo = false;
            BlocProvider.of<PaymentMethodCubit>(context).onTransactionChanged(false);
            Navigator.pop(context, false);
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
        // });
      }).then((value) {
        solukLog(logMsg: value, logDetail: "inside card payment");
      });
    } else if (paymentMethod == APPLE_PAY) {
      FlutterPaytabsBridge.startApplePayPayment(await generateConfigApplePay(), (event) {
        if (event["status"] == "success") {
          print(generateConfigApplePay());

          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    }
  }
}
