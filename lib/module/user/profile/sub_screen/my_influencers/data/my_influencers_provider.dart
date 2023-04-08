import 'dart:convert';

import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';

class MyInfluencersProvider {
  Future<MyInfluencersResponse?> getMyInfluencerList() async {
    final queryParameters = json.encode({
      "load": ["Followed"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(
              endPoint: 'api/influencers', body: queryParameters);
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        MyInfluencersResponse _getInfluencerModel =
        MyInfluencersResponse.fromJson(response);
        return _getInfluencerModel;
      }  else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}
