import 'dart:convert';

import 'package:app/module/user/models/my_workout_response.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';

class MyWorkoutProvider {
  Future<MyWorkoutResponse?> getMyWorkoutList() async {
    final queryParameters = json.encode({
      "load": ["workout"]
    });

    try {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(
              endPoint: 'api/client-workouts', body: queryParameters);
      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        print(apiResponse.statusCode);
        print(apiResponse.data);
        print(apiResponse.status);
        MyWorkoutResponse myWorkoutResponse =
        MyWorkoutResponse.fromJson(response);
        return myWorkoutResponse;
      }  else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}
