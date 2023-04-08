import 'dart:convert';

import 'package:app/module/influencer/challenges/model/challenge.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:flutter/material.dart';

class ChallengesRepo with WebServiceImp {
  Future<GetAllChallenges?> 
  allChallengesList(String endPoint) async {
    ApiResponse apiResponse = (await sl.get<WebServiceImp>().callPostAPI(
      endPoint: endPoint,
      body: {},
    ));
    if (apiResponse.data.toString().contains("Unauthorized")) {
      return null;
    }
    var response = jsonDecode(apiResponse.data);

    if (response != null && response["responseCode"] == SUCCESS) {
      try {
        if (response != null &&
            response["responseDetails"] != null &&
            response["responseDetails"] is List &&
            response["responseDetails"].isNotEmpty) {
          GetAllChallenges _allChallenges = GetAllChallenges.fromJson(response);
          return _allChallenges;
        } else {
          await refreshList(endPoint);
        }
      } on Exception {
        return null;
      }

      return null;
    }
    return null;
  }

  Future<void> refreshList(String endPoint) async {
    await allChallengesList(endPoint);
  }

  Future addChallenge(
    String endPoint,
    Map<String, dynamic> body,
    BuildContext context,
    String fileKeyword,
  ) async {
    ApiResponse apiResponse = await sl.get<WebServiceImp>().addVideoPicture(
          endPoint: endPoint,
          body: body,
          files: body[fileKeyword],
          fileKeyword: fileKeyword,
        );
    var response = jsonDecode(apiResponse.data);

    if (response != null && response["responseCode"] == SUCCESS) {
      try {
        showSnackBar(context, "Successfully Added!",
            backgroundColor: Colors.black);
        refreshList("api/user/challenges");
        Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      showSnackBar(context, "Failed to upload.");
    }
  }
}
