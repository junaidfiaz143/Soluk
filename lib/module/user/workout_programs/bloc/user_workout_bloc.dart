import 'dart:async';
import 'dart:convert';

import 'package:app/module/user/workout_programs/model/user_workout_day_exercises_model.dart';
import 'package:app/module/user/workout_programs/model/user_workout_days_model.dart';
import 'package:app/module/user/workout_programs/model/user_workout_week_model.dart';
import 'package:app/module/user/workout_programs/model/user_workouts_model.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'user_workout_bloc_state.dart';

class UserWorkoutBloc extends Cubit<UserWorkoutBlocState> {
  String? userId = null;
  int? selectedTime = null;

  UserWorkoutBloc() : super(UserWorkoutBlocInitial());
  RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  final StreamController<UserWorkoutsModel> userWorkoutDetailController =
      StreamController<UserWorkoutsModel>.broadcast();

  Stream<UserWorkoutsModel> get userWorkoutDetailStream => userWorkoutDetailController.stream;

  StreamSink<UserWorkoutsModel> get _userWorkoutDetailSink => userWorkoutDetailController.sink;

  final StreamController<UserWorkoutWeeksModel> userWorkoutWeeksController =
      StreamController<UserWorkoutWeeksModel>.broadcast();

  Stream<UserWorkoutWeeksModel> get userWorkoutWeeksStream => userWorkoutWeeksController.stream;

  StreamSink<UserWorkoutWeeksModel> get _userWorkoutWeeksSink => userWorkoutWeeksController.sink;

  final StreamController<UserWorkoutDaysModel> userWorkoutDaysController =
      StreamController<UserWorkoutDaysModel>.broadcast();

  Stream<UserWorkoutDaysModel> get userWorkoutDaysStream => userWorkoutDaysController.stream;

  StreamSink<UserWorkoutDaysModel> get _userWorkoutDaysSink => userWorkoutDaysController.sink;

  final StreamController<UserWorkoutDayExercisesModel> userWorkoutDayExercisesController =
      StreamController<UserWorkoutDayExercisesModel>.broadcast();

  Stream<UserWorkoutDayExercisesModel> get userWorkoutDayExercisesStream => userWorkoutDayExercisesController.stream;

  StreamSink<UserWorkoutDayExercisesModel> get _userWorkoutDayExercisesSink => userWorkoutDayExercisesController.sink;

  final StreamController<String> timerController = StreamController<String>.broadcast();

  Stream<String> get timerStream => timerController.stream;

  StreamSink<String> get _timerSink => timerController.sink;

  int pageNumber = 1;

  updateTimer(String value) {
    _timerSink.add(value);
  }

  onLoadMore(String userId) async {
    pageNumber++;
    await getUserWorkouts(initial: false, selectedInfluencerId: userId);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    _refreshController.refreshCompleted();
  }

  getUserWorkouts({bool initial = true, String? selectedInfluencerId = null}) async {
    if (initial) {
      pageNumber = 1;
      emit(const UserWorkoutsListLoadingState());
    }

    final queryParameters = json.encode({
      'limit': '10',
      'pageNumber': '$pageNumber',
      'userId': selectedInfluencerId,
      'load': [
        "myWorkoutStats",
        {"weeks": "count"},
        {"exercises": "count"}
      ]
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: 'api/user/get-user-workoutplan', body: queryParameters);
    var response = jsonDecode(apiResponse.data);
    solukLog(logMsg: pageNumber, logDetail: "page number");
    solukLog(logMsg: queryParameters, logDetail: "query");
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    // solukLog(logMsg: response[""])
    UserWorkoutsModel _userWorkoutsModel = UserWorkoutsModel.fromJson(response);
    if (initial) {
      if ((_userWorkoutsModel.responseDetails?.data ?? []).isEmpty) {
        emit(const UserWorkoutsListEmptyState());
      } else {
        emit(UserWorkoutsListDataState(userWorkoutsModel: _userWorkoutsModel));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.userWorkoutsModel?.responseDetails!.currentPage = pageNumber;

      state.userWorkoutsModel?.responseDetails?.data = [
        ...state.userWorkoutsModel?.responseDetails?.data ?? [],
        ..._userWorkoutsModel.responseDetails?.data ?? []
      ];

      emit(UserWorkoutsListDataState(userWorkoutsModel: state.userWorkoutsModel));
    }
  }

  Future<int?> getUserWorkoutDetail({String? workoutId = null, bool? checkProgress = false}) async {
    //  emit(const UserWorkoutsDetailsLoadingState());

    solukLog(logMsg: pageNumber, logDetail: "page number getUserWorkoutDetail");

    SolukToast.showLoading();
    final queryParameters = json.encode({
      'id': workoutId,
      'load': [
        "myWorkoutStats",
        {"weeks": "count"},
        {"exercises": "count"},
        "workoutPlanTags",
        "workoutPlanTags.tags"
      ]
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: 'api/user/get-user-workoutplan', body: queryParameters);

    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);

    solukLog(logMsg: response["responseDetails"]["next_page_url"]);

    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);

    if (response["status"] == "success") {
      if (checkProgress!) {
        return response["responseDetails"]["data"][0]["my_workout_stats"]["progress"];
      } else {
        UserWorkoutsModel _userWorkoutsModel = UserWorkoutsModel.fromJson(response);
        if ((_userWorkoutsModel.responseDetails?.data ?? []).isNotEmpty) {
          _userWorkoutDetailSink.add(_userWorkoutsModel);
          //emit(const UserWorkoutsDetailsEmptyState());
        }
        /*else {
        emit(UserWorkoutsDetailsDataState(userWorkoutsDetailModel: _userWorkoutsModel));
      }*/
      }
    }
  }

  Future<ApiResponse> startUserWorkout(
    String workoutId,
  ) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
      endPoint: 'api/workoutPlan/${workoutId}/subscribe',
      body: {},
    );
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print(apiResponse.statusCode);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      return apiResponse;
    } else {
      return apiResponse;
    }
  }

  getUserWorkoutWeeks({String? workoutId = null}) async {
    //  emit(const UserWorkoutsDetailsLoadingState());

    SolukToast.showLoading();
    final queryParameters = json.encode({
      'load': ["myWeekStats"]
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: 'api/user/workout/${workoutId}/week', body: queryParameters);

    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);

    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    UserWorkoutWeeksModel _userWorkoutWeeksModel = UserWorkoutWeeksModel.fromJson(response);
    if ((_userWorkoutWeeksModel.responseDetails?.data ?? []).isNotEmpty) {
      _userWorkoutWeeksSink.add(_userWorkoutWeeksModel);
      //emit(const UserWorkoutsDetailsEmptyState());
    } /*else {
        emit(UserWorkoutsDetailsDataState(userWorkoutsDetailModel: _userWorkoutsModel));
      }*/
  }

  getUserWorkoutDays({String? workoutId = null, String? weekId = null}) async {
    SolukToast.showLoading();
    final queryParameters = json.encode({
      'load': ["myDayStats"]
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: 'api/user/workout/${workoutId}/week/${weekId}/day', body: queryParameters);

    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);

    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    UserWorkoutDaysModel _userWorkoutDaysModel = UserWorkoutDaysModel.fromJson(response);
    if ((_userWorkoutDaysModel.responseDetails?.data ?? []).isNotEmpty) {
      _userWorkoutDaysSink.add(_userWorkoutDaysModel);
    }
  }

  getUserWorkoutDayExercises({String? workoutDayId = null}) async {
    SolukToast.showLoading();
    final queryParameters = json.encode({
      'load': ["myExerciseStats", "sets", "subTypes", "sets.mySetStats", "subTypes.myExerciseSubTypeStats"],
      "workoutDayId": workoutDayId
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: 'api/user/workout/week/day/exercise', body: queryParameters);

    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);

    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    UserWorkoutDayExercisesModel _userWorkoutDayExercisesModel = UserWorkoutDayExercisesModel.fromJson(response);
    if ((_userWorkoutDayExercisesModel.responseDetails?.data ?? []).isNotEmpty) {
      _userWorkoutDayExercisesSink.add(_userWorkoutDayExercisesModel);
    }
  }

  Future<bool> submitExercise({String? exerciseId}) async {
    try {
      // print("rest time : $time");
      SolukToast.showLoading();
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .callPutAPI(endPoint: 'api/client-workoutplan/week/day/exercise/${exerciseId}', body: {'state': "completed"});
      SolukToast.closeAllLoading();

      if (apiResponse.status == APIStatus.success) {
        SolukToast.showToast("Successfully");
        return true;
      } else {
        SolukToast.showToast(apiResponse.data);
        return false;
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      // SolukToast.showToast(e.toString());
      SolukToast.showToast(exerciseId! + " " + e.toString());

      SolukToast.closeAllLoading();
      return false;
    }
  }

  submitExerciseNew({String? exerciseId}) async {
    SolukToast.showLoading();

    var headers = {'Authorization': 'Bearer ${sl.get<AccessDataMembers>().token}', 'Content-Type': 'application/json'};
    var request =
        http.Request('PUT', Uri.parse("https://soluk.app/api/client-workoutplan/week/day/exercise/${exerciseId}"));
    request.body = json.encode({"state": "completed"});
    request.headers.addAll(headers);

    solukLog(logMsg: exerciseId, logDetail: "exercise Id");

    http.StreamedResponse response = await request.send();
    SolukToast.closeAllLoading();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      return true;
    } else {
      SolukToast.showToast(exerciseId! + " " + response.reasonPhrase!);
      return false;
    }
  }

  addWorkoutView({required String? workoutId, required String? subType, required String? subTypeId}) async {
    var headers = {'Authorization': 'Bearer ${sl.get<AccessDataMembers>().token}', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("https://soluk.app/api/view"));
    request.body =
        json.encode({"againstType": "workout", "againstId": workoutId, "subType": subType, "subTypeId": subTypeId});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var jsonRes = jsonDecode(res.body);
      if (jsonRes["status"] == "success") {
        // print(await response.stream.bytesToString());
        return true;
      } else {
        return false;
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<bool> submitRound({String? exerciseId, roundId}) async {
    try {
      // print("rest time : $time");
      SolukToast.showLoading();
      ApiResponse apiResponse = await sl.get<WebServiceImp>().callPutAPI(
          endPoint: 'api/client-workoutplan/week/day/exercise/${exerciseId}/round/${roundId}',
          body: {'state': "completed"});
      SolukToast.closeAllLoading();

      if (apiResponse.status == APIStatus.success) {
        // SolukToast.showToast("Time added successfully");
        return true;
      } else {
        SolukToast.showToast(apiResponse.data + " $exerciseId $roundId");
        return false;
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      SolukToast.showToast(e.toString());
      SolukToast.closeAllLoading();
      return false;
    }
  }

  submitRoundNew({String? exerciseId, roundId}) async {
    SolukToast.showLoading();

    var headers = {'Authorization': 'Bearer ${sl.get<AccessDataMembers>().token}', 'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT', Uri.parse("https://soluk.app/api/client-workoutplan/week/day/exercise/${exerciseId}/round/${roundId}"));
    request.body = json.encode({"state": "completed"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    SolukToast.closeAllLoading();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      return true;
    } else {
      SolukToast.showToast(response.reasonPhrase);
      return false;
    }
  }

  Future<bool> submitExerciseTimeBased({String? exerciseId, subTypeId, setId}) async {
    try {
      // print("rest time : $time");
      SolukToast.showLoading();
      ApiResponse apiResponse = await sl.get<WebServiceImp>().callPutAPI(
          endPoint: 'api/client-workoutplan/week/day/exercise/${exerciseId}/subType/${subTypeId}/set/${setId}',
          body: {'state': "completed"});
      SolukToast.closeAllLoading();

      if (apiResponse.status == APIStatus.success) {
        SolukToast.showToast("Exercise completed");
        return true;
      } else {
        SolukToast.showToast(apiResponse.data);
        return false;
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      SolukToast.showToast(e.toString());
      SolukToast.closeAllLoading();
      return false;
    }
  }

  submitExerciseTimeBasedNew({String? exerciseId, subTypeId, setId}) async {
    SolukToast.showLoading();

    var headers = {'Authorization': 'Bearer ${sl.get<AccessDataMembers>().token}', 'Content-Type': 'application/json'};
    var request = http.Request(
      'PUT',
      Uri.parse('api/client-workoutplan/week/day/exercise/${exerciseId}/subType/${subTypeId}/set/${setId}'),
    );
    request.body = json.encode({"state": "completed"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    SolukToast.closeAllLoading();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      return true;
    } else {
      SolukToast.showToast(response.reasonPhrase);
      return false;
    }
  }
}
