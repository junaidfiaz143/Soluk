import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';

import 'influencer_suggestion_state.dart';

class InfluencerSuggestionRepo {

  Future<bool> postSuggestion(String toUser, String suggestion) async {
    try {
      SolukToast.showLoading();
      ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: 'api/user/add-suggesstion',
          body: {"toUser": toUser, "suggestion": suggestion});
      SolukToast.closeAllLoading();
      print(apiResponse.statusCode);

      print(apiResponse.status == APIStatus.success);
      if (apiResponse.status == APIStatus.success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
