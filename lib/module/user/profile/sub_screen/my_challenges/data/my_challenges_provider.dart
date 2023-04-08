import 'dart:convert';

import 'package:app/module/user/models/my_challenges_response.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';

class MyChallengesProvider {
  Future<MyChallengesResponse?> getMyWorkoutList() async {
    final queryParameters = json.encode({
      "load": ["challengeInfo"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(
              endPoint: 'api/user-challenges', body: queryParameters);
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        MyChallengesResponse _getMyChallenges =
        MyChallengesResponse.fromJson(response);
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
