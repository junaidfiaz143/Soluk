import 'dart:convert';

import 'package:app/module/influencer/dashboard/model/dashboard_model.dart';

import '../../../../repo/data_source/remote_data_source.dart';
import '../../../../repo/repository/web_service.dart';
import '../../../../utils/dependency_injection.dart';

class ViewsGraphRepo {
  List<dynamic> viewsGraphData = [];

  Future<ResponseDetails?> getAnalyticsViewsGraphData(bool isMonthly) async {
    final queryParameters = json.encode({
      "load": isMonthly ? ["total", "monthly"] : ["weekly", "total"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(endPoint: "api/views", body: queryParameters);

      var response = jsonDecode(apiResponse.data);
      print(apiResponse.statusCode);
      DashboardModel data = DashboardModel.fromJson(response);
      return data.responseDetails;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ResponseDetailsIncome?> getAnalyticsIncomeOverAllGraphData() async {
    final queryParameters = json.encode({
      "load": ["weekly", "total"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(endPoint: "api/income", body: queryParameters);

      var response = jsonDecode(apiResponse.data);
      print(apiResponse.statusCode);
      DashboardModel data = DashboardModel.fromJson(response, isIncome: true);
      return data.responseDetailsIncome;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ResponseDetails?> getAnalyticsIncomeMonthlyGraphData() async {
    final queryParameters = json.encode({
      "load": ["total", "monthly"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(endPoint: "api/income", body: queryParameters);

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
