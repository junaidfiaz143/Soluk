import 'dart:convert';

import 'package:app/module/user/models/my_badges_response.dart';
import 'package:app/module/user/models/my_challenges_response.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';

class MyBadgesProvider {
  Future<dynamic> getMyBadgesList() async {

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPI(
          endPoint: 'api/user-badges');
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        MyBadgesResponse _myBadgesResponse =
        MyBadgesResponse.fromJson(response);
        return _myBadgesResponse;
      }  else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
