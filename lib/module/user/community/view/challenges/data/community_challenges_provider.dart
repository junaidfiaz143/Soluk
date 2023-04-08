import 'dart:convert';

import 'package:app/module/user/models/community_challenges_response.dart';
import 'package:app/module/user/models/my_challenges_response.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';

import '../../../../models/community_challenges_model.dart';

class CommunityChallengesProvider {
  Future<dynamic> getCommunityChallengesList() async {

    final queryParameters = json.encode({
      "challengeStatus": "Approved",
      "state": "inprogress",
      "load": ["participants","comments"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(
          endPoint: 'api/user/challenges', body: queryParameters);
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        CommunityChallegeModel _getMyChallenges =
        CommunityChallegeModel.fromJson(response);
        return _getMyChallenges;
      }  else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}
