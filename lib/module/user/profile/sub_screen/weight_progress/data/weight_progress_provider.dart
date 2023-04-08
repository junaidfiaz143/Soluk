import 'dart:convert';

import 'package:app/module/user/models/my_influencers/my_influencers_model.dart';
import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';
import 'package:app/module/user/models/my_workout_response.dart';
import 'package:app/module/user/models/weight_progress_response.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';

class WeightProgressProvider {
  Future<dynamic> getWeightProgressList() async {

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPI(
          endPoint: 'api/user-weight');
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        WeightProgressResponse weightProgressResponse =
        WeightProgressResponse.fromJson(response);
        return weightProgressResponse;
      }  else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }



  Future<bool> deleteWeightProgress(String id) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .delete(endPoint: 'api/user-weight/$id');
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      return true;
    } else {
      return false;
    }
  }

}
