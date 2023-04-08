import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/workout_programs/view/add_exercise/single_work_out/bloc/singe_work_out_excerise_state.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SingleWorkOutCubit extends Cubit<SingleWorkOutState> {
  SingleWorkOutCubit() : super(ExerciseInitial());
  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;

  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();
  Stream<ProgressFile> get progressStream => progressCont.stream;
  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  Future<bool> addSingleWorkOutExercise(
      {addExerciseSingleWTimeRequestModel, workoutSetsList}) async {
    // var data = {
    //   'title': addExerciseSingleWTimeRequestModel.workoutTitle,
    //   'instructions': addExerciseSingleWTimeRequestModel.description,
    //   'exerciseTime': addExerciseSingleWTimeRequestModel.exerciseTime,
    //   'restTime': addExerciseSingleWTimeRequestModel.restTime,
    //   'assetType': addExerciseSingleWTimeRequestModel.assetType,
    //   'sets': jsonEncode(workoutSetsList.map((e) => e.toJson()).toList())
    // };
    var endPoint =
        'api/user/workout/${addExerciseSingleWTimeRequestModel.workoutID}/week/${addExerciseSingleWTimeRequestModel.weekID}/day/${addExerciseSingleWTimeRequestModel.dayID}/exercise/singleworkout';
    // BotToast.showLoading();
    try {
      print("image file : ${addExerciseSingleWTimeRequestModel.media}");
      print(
          "sets : ${jsonEncode(workoutSetsList.map((e) => e.toJson()).toList())}");

      Map<String, String> body = {
        'title': addExerciseSingleWTimeRequestModel.workoutTitle,
        'instructions': addExerciseSingleWTimeRequestModel.description,
        'exerciseTime': addExerciseSingleWTimeRequestModel.exerciseTime,
        'restTime': addExerciseSingleWTimeRequestModel.restTime,
        'assetType': addExerciseSingleWTimeRequestModel.assetType,
        'sets': jsonEncode(workoutSetsList.map((e) => e.toJson()).toList())
      };

      List<String> fields = [];
      List<String> paths = [];
      if (addExerciseSingleWTimeRequestModel.media != null) {
        fields.add('imageVideoURL');
        paths.add(addExerciseSingleWTimeRequestModel.media!.path);
      }

      dynamic response = await sl
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

/*      ApiResponse apiResponse = await WebServiceImp.postDataMultiPart(data,
          endPoint: endPoint, image: addExerciseSingleWTimeRequestModel.media);*/
      SolukToast.closeAllLoading();
      // print(apiResponse.data);
      // print(apiResponse.status);
      // print(apiResponse.errorMessage);
      print('::::::::::::::::::::::');
      if (response.status == APIStatus.success) {
        return true;
      } else {
        SolukToast.showToast(response.errorMessage!);
        return false;
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      print("exc : ${e.toString()}");
      SolukToast.showToast(e.toString());
      return false;
    }
  }

  Future<bool> updateExercise(
      {id, addExerciseSingleWTimeRequestModel, workoutSetsList, pData}) async {
    var data = {
      'title': "",
      'instructions': "",
      'exerciseTime': "",
      'restTime': "",
      'assetType': "",
      'sets': jsonEncode(workoutSetsList.map((e) => e.toJson()).toList())
    };

    bool? updateImage = false;

    try {
      if (addExerciseSingleWTimeRequestModel.workoutTitle != pData.title) {
        data['title'] = addExerciseSingleWTimeRequestModel.workoutTitle;
      } else {
        data.removeWhere((key, value) => key == "title");
      }
      if (addExerciseSingleWTimeRequestModel.description !=
          pData.instructions) {
        data['instructions'] = addExerciseSingleWTimeRequestModel.description;
      } else {
        data.removeWhere((key, value) => key == "instructions");
      }
      if (addExerciseSingleWTimeRequestModel.exerciseTime !=
          pData.exerciseTime) {
        data['exerciseTime'] = addExerciseSingleWTimeRequestModel.exerciseTime;
      } else {
        data.removeWhere((key, value) => key == "exerciseTime");
      }
      if (addExerciseSingleWTimeRequestModel.restTime != pData.restTime) {
        data['restTime'] = addExerciseSingleWTimeRequestModel.restTime;
      } else {
        data.removeWhere((key, value) => key == "restTime");
      }
      if (addExerciseSingleWTimeRequestModel.assetType == "") {
        solukLog(logMsg: "no need for image");
        updateImage = false;
        data.removeWhere((key, value) => key == "assetType");
      } else {
        solukLog(logMsg: "need to update image");
        data['assetType'] = addExerciseSingleWTimeRequestModel.assetType;
        updateImage = true;
      }

      solukLog(logMsg: data, logDetail: "checking data mapping for update");
      // solukLog(logMsg: datar, logDetail: "checking data mapping for update");

      // return false;
      // SolukToast.showLoading();
      // print("Fields : ${fields.length}");
      // print("path : ${paths.length}");
      // print("body : $body");

      if (updateImage == true) {
        Map<String, String> body = {};

        body.addAll(data);

        List<String> fields = [];
        List<String> paths = [];
        if (addExerciseSingleWTimeRequestModel.media != null) {
          fields.add('imageVideoURL');
          paths.add(addExerciseSingleWTimeRequestModel.media!.path);
        }

        dynamic apiResponse = await sl
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
                endPoint:
                    'api/user/workout/week/day/exercise/singleworkout/$id',
                body: body,
                fileKeyword: fields,
                files: paths);

        // solukLog(logMsg: "update data with image", type: solukLogTypeWarning);
        // ApiResponse apiResponse = await WebServiceImp.postDataMultiPart(data,
        //     endPoint: 'api/user/workout/week/day/exercise/singleworkout/$id',
        //     image: addExerciseSingleWTimeRequestModel.media);
        // SolukToast.closeAllLoading();
        // print(apiResponse.data);
        // print(apiResponse.status);
        print('::::::::::::::::::::::');
        if (apiResponse.status == APIStatus.success) {
          //getBlogs();
          return true;
        } else {
          return false;
        }
      } else {
        // List<String> fields = [];
        // List<String> paths = [];
        // if (event.addWorkoutWeekRequestModel.media != null) {
        //   fields.add('imageVideoURL');
        //   paths.add(event.addWorkoutWeekRequestModel.media!.path);
        // }

        // dynamic response = await sl.get<WebServiceImp>().
        // // postVideosPictures(
        // postdioVideosPictures(
        //     onUploadProgress: (p) {
        //       print(((p.done/p.total)*100).toInt());
        //       if (p.done == p.total) {
        //         _progressSink.add(ProgressFile(done: 0, total: 0));
        //       } else {
        //         _progressSink.add(p);
        //       }
        //     },
        //     endPoint: 'api/user/workout/week/day/exercise/singleworkout/$id',
        //     body: data,
        //     fileKeyword: fields,
        //     files: paths);
        //

        Map<String, String> body = {};

        body.addAll(data);

        List<String> fields = [];
        List<String> paths = [];
        if (addExerciseSingleWTimeRequestModel.media != null) {
          fields.add('imageVideoURL');
          paths.add(addExerciseSingleWTimeRequestModel.media!.path);
        }

        dynamic apiResponse = await sl
            .get<WebServiceImp>()
            .
            // postVideosPictures(
            // postdioVideosPictures(
            callPostAPI(
              // onUploadProgress: (p) {
              //   print(((p.done/p.total)*100).toInt());
              //   if (p.done == p.total) {
              //     _progressSink.add(ProgressFile(done: 0, total: 0));
              //   } else {
              //     _progressSink.add(p);
              //   }
              // },
              endPoint: 'api/user/workout/week/day/exercise/singleworkout/$id',
              body: body,
              // fileKeyword: fields,
              // files: paths
            );

        // ApiResponse apiResponse = await WebServiceImp.postDataMultiPart(
        //   data,
        //   endPoint: 'api/user/workout/week/day/exercise/singleworkout/$id',
        // );
        // SolukToast.closeAllLoading();
        print(apiResponse.data);
        print(apiResponse.status);
        print('::::::::::::::::::::::');
        if (apiResponse.status == APIStatus.success) {
          //getBlogs();
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      SolukToast.closeAllLoading();
      solukLog(logMsg: "Error", logDetail: e, type: solukLogTypeError);

      return false;
    }
  }

  // Future<bool> delete(String id) async {
  //   BotToast.showLoading();
  //   ApiResponse apiResponse =
  //       await sl.get<WebServiceImp>().delete(endPoint: 'api/user/delete-user-blog/$id');
  //   BotToast.closeAllLoading();
  //   print(apiResponse.data);
  //   print(apiResponse.status);
  //   print('::::::::::::::::::::::');
  //   if (apiResponse.status == APIStatus.success) {
  //
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
