import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/bloc/circuit_excerise_state.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/round_exercise_request_model.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/circuit/model/rounds_response.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CircuitWorkOutCubit extends Cubit<CircuitWorkOutState> {
  CircuitWorkOutCubit() : super(ExerciseInitial());
  final RefreshController _refreshController = RefreshController();
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();

  Stream<ProgressFile> get progressStream => progressCont.stream;

  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  RefreshController get refreshController => _refreshController;

  Future<bool> addSuperSet(
      {exerciseRequestModel,
      bool? isCircuit,
      String? workoutSubType,
      int? numberOfRounds}) async {
    // var data = {
    //   'title': exerciseRequestModel.workoutTitle,
    //   //'exerciseTime': exerciseRequestModel.exerciseTime,
    //   'assetType': exerciseRequestModel.assetType,
    // };
    var endPoint =
        'api/user/workout/${exerciseRequestModel.workoutID}/week/${exerciseRequestModel.weekID}/day/${exerciseRequestModel.dayID}/exercise/${isCircuit == true ? 'circuit' : 'supersets'}';
    // BotToast.showLoading();
    try {
      // print("image file : ${exerciseRequestModel.media}");
      Map<String, String> body = {
        'title': exerciseRequestModel.workoutTitle,
        // 'assetType': exerciseRequestModel.assetType ?? "",
        // "exerciseTime": exerciseRequestModel.exerciseTime,
        "instructions": exerciseRequestModel.description,
        "workoutSubType": workoutSubType!,
        // "subTypeCount": "$numberOfRounds",
        "restTime": exerciseRequestModel.restTime,
      };
      if (workoutSubType == "round") {
        body["subTypeCount"] = "$numberOfRounds";
      } else {
        body["exerciseTime"] = exerciseRequestModel.exerciseTime;
      }
      // print(body);
      // return false;
      List<String> fields = [];
      List<String> paths = [];
      if (exerciseRequestModel.media != null) {
        fields.add('imageVideoURL');
        paths.add(exerciseRequestModel.media!.path);
      }
      // String assetType = "";
      // if (exerciseRequestModel.assetType != null) {
      //   assetType = exerciseRequestModel.assetType!;
      // }
      dynamic apiResponse;
      if (exerciseRequestModel.media != null) {
        apiResponse = await sl
            .get<WebServiceImp>()
            .
            // postVideosPictures(
            postdioVideosPictures(
                onUploadProgress: (p) {
                  print(((p.done / p.total) * 100).toInt());
                  if (p.done == p.total) {
                    _progressSink.add(ProgressFile(done: 0, total: 0));
                  } else {
                    _progressSink.add(p);
                  }
                },
                endPoint: endPoint,
                body: body,
                fileKeyword: fields,
                files: paths);
      } else {
        SolukToast.showLoading();
        apiResponse =
            await WebServiceImp.postDataMultiPart(body, endPoint: endPoint);
      }

      // ApiResponse apiResponse = await WebServiceImp.postDataMultiPart(data,
      //     endPoint: endPoint, image: exerciseRequestModel.media);

      SolukToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        Data data = Data.fromJson(apiResponse.data['responseDetails']);
        emit(ExerciseLoaded(data: data));
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }

  Future<bool> addExerciseRound(
      {exerciseRequestModel,
      bool? isCircuit,
      Map<String, String>? data}) async {
    var endPoint =
        'api/user/workout/${exerciseRequestModel.workoutID}/week/${exerciseRequestModel.weekID}/day/${exerciseRequestModel.dayID}/exercise/${isCircuit == true ? 'circuit' : 'supersets'}';
    // BotToast.showLoading();
    try {
      // print("image file : ${exerciseRequestModel.media}");
      // Map<String, String> body = {
      //   'title': exerciseRequestModel.workoutTitle,
      //   'assetType': exerciseRequestModel.assetType ?? "",
      // };
      List<String> fields = [];
      List<String> paths = [];
      if (true) {
        fields.add('imageVideoURL');
        paths.add(data!["imageVideoURL"]!);
      }
      // print(exerciseRequestModel.workoutID);
      // print(exerciseRequestModel.weekID);
      // print(exerciseRequestModel.dayID);
      // print(data);
      // return false;
      // String assetType = "";
      // if (exerciseRequestModel.assetType != null) {
      //   assetType = exerciseRequestModel.assetType!;
      // }
      dynamic apiResponse;
      // if (true) {
      apiResponse = await sl
          .get<WebServiceImp>()
          .
          // postVideosPictures(
          postdioVideosPictures(
              onUploadProgress: (p) {
                print(((p.done / p.total) * 100).toInt());
                if (p.done == p.total) {
                  _progressSink.add(ProgressFile(done: 0, total: 0));
                } else {
                  _progressSink.add(p);
                }
              },
              endPoint: endPoint,
              body: data,
              fileKeyword: fields,
              files: paths);
      // } else {
      //   SolukToast.showLoading();
      //   apiResponse =
      //       await WebServiceImp.postDataMultiPart(data!, endPoint: endPoint);
      // }

      // ApiResponse apiResponse = await WebServiceImp.postDataMultiPart(data,
      //     endPoint: endPoint, image: exerciseRequestModel.media);

      SolukToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        Data data = Data.fromJson(apiResponse.data['responseDetails']);
        emit(ExerciseLoaded(data: data));
        return true;
      } else {
        print(apiResponse.data);
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }

  getExercises({int? parent, required int? workoutDayId}) async {
    try {
      SolukToast.showLoading();
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetBody(endPoint: 'api/user/workout/week/day/exercise',
              //?limit=10&pageNumber=1&userId=8',
              body: {
            "workoutDayId": workoutDayId,
            "parent": parent,
            "load": ["sets"]
          });

      solukLog(
          logMsg: "workoutDayId $workoutDayId  $parent",
          logDetail: "alalalalalaal");

      SolukToast.closeAllLoading();
      var response = jsonDecode(apiResponse.data);
      print("api response code :: ${apiResponse.statusCode}");
      print(apiResponse.data);
      print(apiResponse.status);

      if (apiResponse.status == APIStatus.success) {
        GetAllExerciseResponse exerciseResponse =
            GetAllExerciseResponse.fromJson(response);
        emit(RoundExerciseLoaded(data: exerciseResponse));
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      SolukToast.closeAllLoading();
    }
  }

  Future<bool> addRounds(
      {Map<String, dynamic>? data, WorkOutModel? exerciseData}) async {
    var endPoint =
        '/api/user/workout/week/day/exercise/${exerciseData!.exerciseId}/subType/round';
    SolukToast.showLoading();
    try {
      ApiResponse apiResponse =
          await WebServiceImp.postData(body: data!, endPoint: endPoint);

      SolukToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        var jsonResponse = apiResponse.data['responseDetails'];
        print("json response : ${jsonResponse.length}");
        List<RoundsData> roundsList = jsonResponse
            .map<RoundsData>((data) => RoundsData.fromJson(data))
            .toList();
        print("rounds list :${roundsList.length}");
        emit(RoundsLoaded(roundsList: roundsList));
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }

  Future<bool> addRoundsExercise(
      {RoundExerciseRequest? exerciseData,
      List<int?>? duplicateRoundIds,
      int? setID}) async {
    print("exercise type : ${exerciseData!.exerciseType!}");

    var data = {
      'title': exerciseData.workoutTitle,
      'assetType': exerciseData.assetType,
    };

    Map<String, String> body = {
      'title': exerciseData.workoutTitle!,
      'assetType': exerciseData.assetType!,
      'instructions': exerciseData.description!,
      'type': exerciseData.exerciseType!,
    };

    if (exerciseData.isTimeBaseExercise == true) {
      data.addAll({'restTime': exerciseData.restTime});
      body.addAll({'restTime': exerciseData.restTime ?? ""});
    }

    if (duplicateRoundIds != null) {
      data.addAll({'duplicateRounds': duplicateRoundIds.join(',')});
      body.addAll({'duplicateRounds': duplicateRoundIds.join(',')});
    }

    if (exerciseData.exerciseType == "Time") {
      print("her");
      data.addAll({'setTime': exerciseData.exerciseValue});
      body.addAll({'setTime': exerciseData.exerciseValue ?? ""});
    } else if (exerciseData.exerciseType == "Reps") {
      data.addAll({
        'noOfReps': exerciseData.exerciseValue,
        'dropSet': exerciseData.dropSet.toString()
      });

      body.addAll({
        'noOfReps': exerciseData.exerciseValue ?? "",
        'dropSet': exerciseData.dropSet.toString()
      });
    } else if (exerciseData.exerciseType == "Custom") {
      data.addAll({'count': exerciseData.exerciseCustomValue});
      body.addAll({'count': exerciseData.exerciseCustomValue ?? ""});
    }
    print("body : $data");
    print("body New : $data");
    var endPoint =
        'api/user/workout/week/day/exercise/${exerciseData.exerciseId}/subType/${exerciseData.roundId}/set${setID == null ? '' : '/$setID'}';
    // SolukToast.showLoading();
    try {
      List<String> fields = [];
      List<String> paths = [];
      if (exerciseData.media != null) {
        fields.add('imageVideoURL');
        paths.add(exerciseData.media!.path);
      }
      // String assetType = "";
      // if (exerciseData.assetType != null) {
      //   assetType = exerciseData.assetType!;
      // }

      dynamic apiResponse;

      if (exerciseData.media!.path.contains("com.saluk.app")) {
        apiResponse = await sl
            .get<WebServiceImp>()
            .
            postdioVideosPictures(
                onUploadProgress: (p) {
                  print(((p.done / p.total) * 100).toInt());
                  if (p.done == p.total) {
                    _progressSink.add(ProgressFile(done: 0, total: 0));
                  } else {
                    _progressSink.add(p);
                  }
                },
                endPoint: endPoint,
                body: body,
                fileKeyword: fields,
                files: paths);
      } else {
        apiResponse =
            await WebServiceImp.postDataMultiPart(data, endPoint: endPoint);
        SolukToast.closeAllLoading();
      }

      if (apiResponse.status == APIStatus.success) {
        var jsonResponse = apiResponse.data['responseDetails'];
        print("json response : ${jsonResponse.length}");
        if (jsonResponse is List) {
          List<RoundsData> roundsList = jsonResponse
              .map<RoundsData>((data) => RoundsData.fromJson(data))
              .toList();
          print("rounds list :${roundsList.length}");
          emit(RoundsLoaded(roundsList: roundsList));
        } else {
          emit(const RoundsLoaded(roundsList: []));
        }
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }

  getRoundExercises(
      {bool initial = true, String? id, bool withRounds = false}) async {
    try {
      SolukToast.showLoading();
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetBody(endPoint: 'api/user/workout/week/day/exercise',
              //?limit=10&pageNumber=1&userId=8',
              body: {
            withRounds == true ? 'workoutDayId' : 'exerciseId': id,
            'load': withRounds == true ? ["sets", "subTypes"] : ["sets"]
          });

      SolukToast.closeAllLoading();
      var response = jsonDecode(apiResponse.data);
      print("api response code :: ${apiResponse.statusCode}");
      print(apiResponse.data);
      print(apiResponse.status);

      if (apiResponse.status == APIStatus.success) {
        GetAllExerciseResponse exerciseResponse =
            GetAllExerciseResponse.fromJson(response);
        emit(RoundExerciseLoaded(data: exerciseResponse));
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      SolukToast.closeAllLoading();
    }
  }

  updateExerciseCount(int count) {
    emit(ExerciseCountState(count));
  }

  Future<bool> putRoundRestTime(
      {String? time, exerciseId, exerciseSubType}) async {
    try {
      print("rest time : $time");
      SolukToast.showLoading();
      ApiResponse apiResponse = await sl.get<WebServiceImp>().callPutAPI(
          endPoint:
              'api/user/workout/week/day/exercise/$exerciseId/subType/exerciseSubType/$exerciseSubType',
          //?limit=10&pageNumber=1&userId=8',
          body: {'restTime': time});
      SolukToast.closeAllLoading();

      if (apiResponse.status == APIStatus.success) {
        SolukToast.showToast("Time added successfully");
        return true;
      } else {
        SolukToast.showToast(apiResponse.errorMessage!);
        return false;
      }
    } catch (e) {
      print("exception workout : ${e.toString()}");
      SolukToast.showToast(e.toString());
      SolukToast.closeAllLoading();
      return false;
    }
  }

  Future<bool> addTimebaseSuperSet(
      {Map<String, dynamic>? data, WorkOutModel? exerciseData}) async {
    var endPoint =
        '/api/user/workout/week/day/exercise/${exerciseData!.exerciseId}/subType/timebased';
    SolukToast.showLoading();
    try {
      ApiResponse apiResponse =
          await WebServiceImp.postData(body: data!, endPoint: endPoint);

      SolukToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        var jsonResponse = apiResponse.data['responseDetails'];
        print("json response : ${jsonResponse.length}");
        List<RoundsData> roundsList = jsonResponse
            .map<RoundsData>((data) => RoundsData.fromJson(data))
            .toList();
        print("rounds list :${roundsList.length}");
        emit(RoundsLoaded(roundsList: roundsList));
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      print("exc : ${e.toString()}");
      emit(ExerciseError(message: e.toString()));
      return false;
    }
  }

  Future<bool> updateTimebaseDuration(
      {Map<String, dynamic>? data, int? exerciseId, int? timebaseID}) async {
    var endPoint =
        '/api/user/workout/week/day/exercise/$exerciseId/subType/timebased/$timebaseID';
    SolukToast.showLoading();
    try {
      ApiResponse apiResponse =
          await WebServiceImp.updateData(body: data!, endPoint: endPoint);
      SolukToast.closeAllLoading();
      print("api response :: ${apiResponse.data}");

      if (apiResponse.status == APIStatus.success) {
        return true;
      } else {
        emit(ExerciseError(message: apiResponse.errorMessage));
        return false;
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      print("exc : ${e.toString()}");
      // emit(ExerciseError(message: e.toString()));
      return false;
    }
  }
}
