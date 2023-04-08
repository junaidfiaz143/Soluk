import 'dart:convert';

import 'package:app/module/influencer/dashboard/model/dashboard_model.dart';

import '../../../../repo/data_source/remote_data_source.dart';
import '../../../../repo/repository/web_service.dart';
import '../../../../utils/dependency_injection.dart';

class DashboardDataRepo {
  Future<ResponseDetails?> getDashboardGraphData() async {
    final queryParameters = json.encode({
      "load": [
        "info",
        {"followedInfluencers": "count"}
      ],
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(
              endPoint: "api/influencer-dashboard", body: queryParameters);

      var response = jsonDecode(apiResponse.data);
      print(apiResponse.statusCode);
      DashboardModel data = DashboardModel.fromJson(response);
      return data.responseDetails;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
