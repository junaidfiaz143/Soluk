import 'dart:convert';

import 'package:app/animations/slide_up_transparent_animation.dart';
import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/module/influencer/more/model/suggestion_model.dart';
import 'package:app/module/influencer/more/widget/custom_alert_dialog.dart';
import 'package:app/module/influencer/widgets/action_pop_up.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/repo/data_source/local_store.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class MoreRepository with WebServiceImp {
  MoreRepository();

  static Future<void> deleteAccount(BuildContext context) async {
    await sl
        .get<WebServiceImp>()
        .callPostAPI(endPoint: "api/user/delete", body: {});
    Phoenix.rebirth(context);
  }

  static Future<void> changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .callPostAPI(endPoint: "api/user/update-password", body: {
      "newPassword": newPassword,
      "currentPassword": currentPassword,
    });

    if (apiResponse.status == APIStatus.success) {
      showSnackBar(
          context, AppLocalisation.getTranslated(context, LKYourPassChangSucc),
          backgroundColor: Colors.black);
      Navigator.pop(context);
    } else if (apiResponse.statusCode == 12) {
      showSnackBar(context, 'Your current password is incorrect');
    } else {
      showSnackBar(context, apiResponse.data);
    }
  }

  static Future<void> addMoreFeedback(
      String feedback, BuildContext context) async {
    ApiResponse response = await sl.get<WebServiceImp>().callPostAPI(
      endPoint: "api/user/add-user-feedback",
      body: {
        "suggestion": feedback,
      },
    );
    var res = jsonDecode(response.data);
    if (res['responseCode'] != null && res['responseCode'] != SUCCESS) {
      invalidDataSnackBar(context, res['responseCode']);
    } else {
      showSnackBar(context, "Feedback added successfully",
          backgroundColor: Colors.black);
    }
  }

  static Future<void> setLanguage(
      BuildContext context, String language, String languageCode) async {
    AppLocalisation.changeLanguage(languageCode, context);
    sl.get<WebServiceImp>().callPostAPI(
      endPoint: "api/user/add-language",
      body: {"language": language},
    );
  }

  static Future getLanguage() async {
    ApiResponse apiResponse = (await sl
        .get<WebServiceImp>()
        .callPostAPI(endPoint: "api/user/get-language", body: {}));
    var response = jsonDecode(apiResponse.data);
    if (response != null &&
        response['responseCode'] != null &&
        response['responseCode'] == SUCCESS) {
      if (response['responseDetails']['language'] != null) {
        if (response['responseDetails']['language']
            .toString()
            .toLowerCase()
            .contains("eng")) {
          sl.get<LanguageBloc>().add(English());
        } else if (response['responseDetails']['language']
            .toString()
            .toLowerCase()
            .contains("ara")) {
          sl.get<LanguageBloc>().add(Arabic());
        }
      }
    }
  }

  static Future setNotificationStatus(BuildContext context, bool enable) async {
    ApiResponse apiResponse = (await sl.get<WebServiceImp>().callPostAPI(
        endPoint: "api/user/notification",
        body: {
          "notification": enable ? ENABLE_NOTIFICATION : DISABLE_NOTIFICATION
        }));
    var response = jsonDecode(apiResponse.data);
    if (response != null &&
        response['responseCode'] != null &&
        response['responseCode'] == SUCCESS) {
    } else {
      showSnackBar(context, "Please try again later.");
    }
  }

  static Future<bool> getNotificationStatus(BuildContext context) async {
    ApiResponse apiResponse = (await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint: "api/user/get-notification", isAuthTokenRequired: true));

    if (apiResponse.status == APIStatus.success) {
      var response = jsonDecode(apiResponse.data);
      if (response['responseDetails']['notification'] == 1) {
        return true;
      }
      return false;
    }
    return false;
  }

  static Future<String?> getPromoCode(BuildContext context) async {
    ApiResponse apiResponse = (await sl
        .get<WebServiceImp>()
        .callPostAPI(endPoint: "api/user/get-promo-code", body: {}));
    var response = jsonDecode(apiResponse.data);
    if (response != null &&
        response['responseCode'] != null &&
        response['responseCode'] == SUCCESS) {
      if (response['responseDetails'] != null &&
          response['responseDetails']["promoCode"] != null) {
        LocalStore.saveData(
            LSKeyPromoCode, response['responseDetails']["promoCode"]);
        return response['responseDetails']["promoCode"];
      }
    } else {
      showSnackBar(context, "Please try again later.");
      return null;
    }
    showSnackBar(context, "Please try again later.");
    return null;
  }

  static Future<String?> generatePromoCode(BuildContext context) async {
    ApiResponse apiResponse = (await sl
        .get<WebServiceImp>()
        .callPostAPI(endPoint: "api/user/generate-promo-code", body: {}));
    var response = jsonDecode(apiResponse.data);
    if (response != null &&
        response['responseCode'] != null &&
        response['responseCode'] == SUCCESS) {
      if (response['responseDetails'] != null &&
          response['responseDetails']["promoCode"] != null) {
        LocalStore.saveData(
            LSKeyPromoCode, response['responseDetails']["promoCode"]);
        return response['responseDetails']["promoCode"];
      }
    } else {
      showSnackBar(context, "Please try again later.");
      return null;
    }
    showSnackBar(context, "Please try again later.");
    return null;
  }

  static Future<SuggestionsModal?> allSuggestionList(String endPoint) async {
    ApiResponse apiResponse = (await sl.get<WebServiceImp>().fetchGetBody(
      endPoint: endPoint,
      body: {"suggestion": "feedback"},
    ));
    if (apiResponse.data.toString().contains("Unauthorized")) {
      return null;
    }
    var response = jsonDecode(apiResponse.data);

    if (response != null && response["responseCode"] == SUCCESS) {
      try {
        if (response != null &&
            response["responseDetails"] != null &&
            response["responseDetails"] is List) {
          SuggestionsModal _suggestionModel =
              SuggestionsModal.fromJson(response);
          return _suggestionModel;
        } else {
          refreshList(endPoint);
        }
      } on Exception {
        return null;
      }
      return null;
    }
    return null;
  }

  static Future<void> refreshList(String endPoint) async {
    await allSuggestionList(endPoint);
  }
}
