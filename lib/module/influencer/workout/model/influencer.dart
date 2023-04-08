import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';

abstract class Influencer {
  Future changePassword(String currentPassword, String newPassword);
}

class InfluencerAction with WebServiceImp implements Influencer {
  @override
  Future<ApiResponse> changePassword(
      String currentPassword, String newPassword) async {
    ApiResponse apiResponse =
        await callPostAPI(endPoint: "api/user/update-password", body: {
      "newPassword": newPassword,
      "currentPassword": currentPassword,
    });
    print('CHANGE PASSWORD API RESPONSE :: ${apiResponse.data}');
    if (apiResponse.data['responseCode'] != null &&
        apiResponse.data['responseCode'] == SUCCESS) {
      return ApiResponse.success(data: apiResponse.data);
    } else {
      return ApiResponse.failure(statusCode: apiResponse.data['responseCode']);
    }
  }
}
