import 'dart:collection';
import 'dart:convert';

import 'package:app/module/influencer/subscribers/data/dummy_data.dart';
import 'package:app/module/influencer/subscribers/model/subscribers.dart';
import 'package:app/module/influencer/workout_programs/model/AddExerciseSingleWTimeRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/AddWorkoutPlanRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/add_exercise_long_video_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_week_request_model.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';

class WorkoutProgramRepo {
  List<Subscribers> getSubscribersList() {
    return subscribersListData;
  }

  Future getWorkoutPrerequisites() async {
    //String token = sl.get<AccessDataMembers>().token;
    Map<String, dynamic> temp = {
      "load": ["difficultyLevel", "programType", "completionBadge"]
    };

    dynamic response =
        await WebServiceImp.apiGet('/api/user/workout-prerequisites');
    print(response);

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future addWorkoutProgram(
      {required AddWorkoutPlanRequestModel addWorkoutPlanRequestModel}) async {
    Map params = HashMap<String, dynamic>();
    params.putIfAbsent('title', () => addWorkoutPlanRequestModel.workoutTitle);
    params.putIfAbsent(
        'programType', () => addWorkoutPlanRequestModel.programType);
    params.putIfAbsent(
        'completionBadge', () => addWorkoutPlanRequestModel.completionBadgeId);
    params.putIfAbsent(
        'description', () => addWorkoutPlanRequestModel.description);
    params.putIfAbsent('assetType', () => addWorkoutPlanRequestModel.assetType);
    params.putIfAbsent(
        'diffcultyLevel', () => addWorkoutPlanRequestModel.difficultyLevel);

    String urlRoute;
    if (addWorkoutPlanRequestModel.isEditing == true) {
      urlRoute =
          '/api/user/workout/${addWorkoutPlanRequestModel.workoutProgramID}';
    } else {
      urlRoute = '/api/user/add-user-workoutplan';
    }
    dynamic response = await WebServiceImp.addWorkoutPlanMultipartPostApi(
        urlRoute, params, addWorkoutPlanRequestModel.media);

    print(response);
    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future addWorkoutWeekEvent(
      {required AddWorkoutWeekRequestModel addWorkoutWeekRequestModel}) async {
    Map params = HashMap<String, dynamic>();
    params.putIfAbsent('title', () => addWorkoutWeekRequestModel.workoutTitle);

    params.putIfAbsent(
        'description', () => addWorkoutWeekRequestModel.description);
    params.putIfAbsent('assetType', () => addWorkoutWeekRequestModel.assetType);

    dynamic response = await WebServiceImp.addWorkoutPlanMultipartPostApi(
        '/api/user/workout/${addWorkoutWeekRequestModel.workoutID}/week',
        params,
        addWorkoutWeekRequestModel.media);
    print(response);

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future addWorkoutDayEvent(
      {required AddWorkoutWeekRequestModel addWorkoutWeekRequestModel}) async {
    Map params = HashMap<String, dynamic>();
    params.putIfAbsent('title', () => addWorkoutWeekRequestModel.workoutTitle);

    params.putIfAbsent(
        'description', () => addWorkoutWeekRequestModel.description);
    params.putIfAbsent('assetType', () => addWorkoutWeekRequestModel.assetType);

    dynamic response = await WebServiceImp.addWorkoutPlanMultipartPostApi(
        '/api/user/workout/${addWorkoutWeekRequestModel.workoutID}/week/${addWorkoutWeekRequestModel.weekID}/day',
        params,
        addWorkoutWeekRequestModel.media);
    print(response);

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future addExerciseLongVideoEvent(
      {required AddExerciseLongVideoRequestModel
          addExerciseLongVideoRequestModel}) async {
    Map params = HashMap<String, dynamic>();
    params.putIfAbsent(
        'title', () => addExerciseLongVideoRequestModel.workoutTitle);

    params.putIfAbsent(
        'instructions', () => addExerciseLongVideoRequestModel.description);
    params.putIfAbsent(
        'exerciseTime', () => addExerciseLongVideoRequestModel.exerciseTime);
    params.putIfAbsent(
        'assetType', () => addExerciseLongVideoRequestModel.assetType);

    dynamic response = await WebServiceImp.addWorkoutPlanMultipartPostApi(
        '/api/user/workout/${addExerciseLongVideoRequestModel.workoutID}/week/${addExerciseLongVideoRequestModel.weekID}/day/${addExerciseLongVideoRequestModel.dayID}/exercise/longvideo',
        params,
        addExerciseLongVideoRequestModel.media);
    print(response);

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future addExerciseSingleWTimeEvent(
      {required AddExerciseSingleWTimeRequestModel
          addExerciseSingleWTimeRequestModel,
      required var workoutSetsList}) async {
    Map params = HashMap<String, dynamic>();
    params.putIfAbsent(
        'title', () => addExerciseSingleWTimeRequestModel.workoutTitle);

    params.putIfAbsent(
        'instructions', () => addExerciseSingleWTimeRequestModel.description);
    params.putIfAbsent(
        'exerciseTime', () => addExerciseSingleWTimeRequestModel.exerciseTime);
    params.putIfAbsent(
        'restTime', () => addExerciseSingleWTimeRequestModel.restTime);
    params.putIfAbsent(
        'assetType', () => addExerciseSingleWTimeRequestModel.assetType);
    params.putIfAbsent('sets',
        () => jsonEncode(workoutSetsList.map((e) => e.toJson()).toList()));

    dynamic response = await WebServiceImp.addWorkoutPlanMultipartPostApi(
        '/api/user/workout/${addExerciseSingleWTimeRequestModel.workoutID}/week/${addExerciseSingleWTimeRequestModel.weekID}/day/${addExerciseSingleWTimeRequestModel.dayID}/exercise/singleworkout',
        params,
        addExerciseSingleWTimeRequestModel.media);
    print(response);

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future getWorkoutProgramsEvent({int? pageNumber}) async {
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetBody(endPoint: 'api/user/get-user-workoutplan', body: {
      "limit": 15,
      "pageNumber": pageNumber ?? 1,
      "load": [
        {"weeks": "count"},
        {"exercises": "count"},
        "workoutPlanTags",
        "workoutPlanTags.tags"
      ]
    });
    var response = jsonDecode(apiResponse.data);
    // dynamic response = await WebServiceImp.apiGet(
    //   '/api/user/get-user-workoutplan',
    // );
    // print(response);
    print('>>>>>>>>>>>>>123');

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        print('>>>>>>>>>>123124');
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future deleteWorkoutProgramsEvent({int? workoutProgramId}) async {
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .delete(endPoint: 'api/workout/${workoutProgramId}');
    Map<String, dynamic>? response;
    if (apiResponse.data != null) {
      response = jsonDecode(apiResponse.data);
    } else {
      response = {
        "status": apiResponse.status.name,
        "responseCode": "${apiResponse.statusCode}",
        "responseDescription": "${apiResponse.errorMessage}",
      };
    }

    if (response != null) {
      return response;
    }
    return null;
  }

  Future deleteWorkoutDayEvent(
      {int? workoutProgramId, int? weekId, int? dayId}) async {
    ApiResponse apiResponse = await sl.get<WebServiceImp>().delete(
        endPoint: 'api/workout/$workoutProgramId/week/$weekId/day/$dayId');
    Map<String, dynamic>? response;
    if (apiResponse.data != null) {
      response = jsonDecode(apiResponse.data);
    } else {
      response = {
        "status": apiResponse.status.name,
        "responseCode": "${apiResponse.statusCode}",
        "responseDescription": "${apiResponse.errorMessage}",
      };
    }

    if (response != null) {
      return response;
    }
    return null;
  }

  Future getWorkoutWeeksEvent({required String id}) async {
    dynamic response = await WebServiceImp.apiGet(
      '/api/user/workout/${id}/week',
    );
    print(response);

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future getWorkoutDaysEvent(
      {required String id, required String workoutId}) async {
    dynamic response = await WebServiceImp.apiGet(
      '/api/user/workout/${workoutId}/week/${id}/day',
    );
    print(response);

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  Future getWorkoutExerciseEvent({required String id}) async {
    print("test workout excersie event");
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetBody(endPoint: 'api/user/workout/week/day/exercise', body: {
      "workoutDayId": id,
      "load": ["sets", "rounds"]
    });
    print("helo");
    print('api response $apiResponse');
    var response = jsonDecode(apiResponse.data);
    print('response $response');

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        print('>>>>>>>>>>123124');
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }

  // Future getWorkoutDaysEvent(
  //     {required String id, required String workoutId}) async {
  //   dynamic response = await WebServiceImp.apiGet(
  //     '/api/user/workout/${workoutId}/week/${id}/day',
  //   );
  //   print(response);
  //
  //   if (response != null) {
  //     try {
  //       // showSnackBar(context, "Successfully Added!",
  //       //     backgroundColor: Colors.black);
  //       return response;
  //       // Navigator.pop(context);
  //     } catch (e) {
  //       rethrow;
  //     }
  //   } else {
  //     //showSnackBar(context, "Failed to upload.");
  //   }
  // }

  Future getWorkoutProgramsNextBackPageEvent({required String url}) async {
    dynamic response = await WebServiceImp.apiGetFullUrl(
      url,
    );
    print(response);

    if (response != null) {
      try {
        // showSnackBar(context, "Successfully Added!",
        //     backgroundColor: Colors.black);
        return response;
        // Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    } else {
      //showSnackBar(context, "Failed to upload.");
    }
  }
}
