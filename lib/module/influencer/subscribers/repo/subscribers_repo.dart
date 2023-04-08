import 'dart:convert';

import 'package:app/res/globals.dart';

import '../../../../repo/data_source/remote_data_source.dart';
import '../../../../repo/repository/web_service.dart';
import '../../../../utils/dependency_injection.dart';
import '../../../user/community/model/friends_model.dart';

class SubscriberRepo {
  Future<List<Data>?> getSubscribersList({int pageNumber = 1}) async {
    final queryParameters = json.encode({
      "load": ["subscribers"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(endPoint: "api/users", body: queryParameters);

      var response = jsonDecode(apiResponse.data);
      print(apiResponse.statusCode);
      FriendsModel _subscribers = FriendsModel.fromJson(response);
      solukLog(logMsg: _subscribers.responseDetails?.data);
      return _subscribers.responseDetails?.data;
    } catch (e) {
      print(e);
      solukLog(logMsg: e, type: solukLogTypeError);
    }
    return null;
  }
}
