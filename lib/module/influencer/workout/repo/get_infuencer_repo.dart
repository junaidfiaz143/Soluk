import 'dart:convert';

import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';

import '../../../../repo/data_source/local_store.dart';

class GetInfluencerRepo {
  Future<dynamic> getInfluencerInfo() async {

    try {
      String userId = await LocalStore.getData(PREFS_USERID);

      ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
          endPoint: 'api/influencer/get-info',
          params: {'userId': userId}
          // body: {},
          );
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        GetInfluencerModel _getInfluencerModel =
            GetInfluencerModel.fromJson(response);
        return _getInfluencerModel;
      } else if(apiResponse.statusCode == 15) {
        return GetInfluencerModel(responseCode: 15.toString());

      }else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
