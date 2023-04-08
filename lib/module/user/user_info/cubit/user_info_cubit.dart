import 'dart:convert';

import 'package:app/module/user/user_info/client_info_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../repo/data_source/remote_data_source.dart';
import '../../../../repo/repository/web_service.dart';
import '../../../../res/constants.dart';
import '../../../../utils/dependency_injection.dart';
import '../../../../utils/enums.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<SaveUserInfoState> {
  UserInfoCubit() : super(SaveInfoInitial());

  String username = '';
  String dob = '';
  String gender = '';
  String fat = '';
  String height = '';
  String weight = '';
  String goals = '';
  String activeness = '';
  String diet = '';
  String mealPerDay = '';

  Future<void> saveUserInfo(String userId) async {
    try {
      emit(UserInfoSaving());
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .callPostAPI(endPoint: 'api/client-info/$userId', body: {
        'username': username,
        'dob': '2022-06-29 19:33:45',
        'gender': gender,
        'fat': fat,
        'height': height,
        'weight': weight,
        'goals': goals,
        'activeness': activeness,
        'diet': diet,
        'mealPerDay': mealPerDay,
      });

      var response = jsonDecode(apiResponse.data);
      if (apiResponse.status == APIStatus.success) {
        await LocalStore.saveData(
            USER_CALORIE_RANGE, response['responseDetails']['caloriesRange']);
        emit(UserInfoSaved(response['responseDetails']['caloriesRange']));
      } else {
        emit(UserInfoSaveError(apiResponse.errorMessage ?? ''));
      }
    } catch (e) {
      debugPrint("exception save user info $userId : ${e.toString()}");
      emit(UserInfoSaveError(e.toString()));
      // emit(UserInfoSaved(""));
    }
  }

  Future<bool> updateUserCalorieRange(String userId, String range) async {
    try {
      Map<String, dynamic> body = {};
      if (range != '') body.addAll({'caloriesRange': range});
      if (gender != '') body.addAll({'gender': gender});
      if (fat != '') body.addAll({'fat': fat});
      if (height != '') body.addAll({'height': height});
      if (weight != '') body.addAll({'weight': weight});
      if (goals != '') body.addAll({'goals': goals});
      if (activeness != '') body.addAll({'activeness': activeness});
      if (diet != '') body.addAll({'diet': diet});
      if (mealPerDay != '') body.addAll({'mealPerDay': mealPerDay});

      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .callPutAPI(endPoint: 'api/client-info/$userId', body: {});

      debugPrint("OK ");
      var response = jsonDecode(apiResponse.data);
      if (apiResponse.status == APIStatus.success) {
        if (range != '') {
          await LocalStore.saveData(USER_CALORIE_RANGE, range);
        } else {
          await LocalStore.saveData(
              USER_CALORIE_RANGE, response['responseDetails']['caloriesRange']);
          emit(UserInfoSaved(response['responseDetails']['caloriesRange']));
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("exception save user info : ${e.toString()}");
      return false;
    }
  }

  Future<void> fetchUserInfo(String userId) async {
    try {
      emit(UserInfoFetching());
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPI(endPoint: 'api/client-info', params: {'userId': userId});

      var response = jsonDecode(apiResponse.data);
      print('fetch resp :: $response');
      if (apiResponse.status == APIStatus.success) {
        ClientInfoResponseModel responseModel =
            ClientInfoResponseModel.fromJson(response["responseDetails"]);
        await updateInfo(responseModel.data[responseModel.data.length - 1]);
        await LocalStore.saveData(USER_CALORIE_RANGE,
            responseModel.data[responseModel.data.length - 1].caloriesRange);
        await LocalStore.saveData(USER_WEIGHT,
            responseModel.data[responseModel.data.length - 1].weight);
        emit(UserInfoFetched());
      } else {
        emit(UserInfoFetchError(apiResponse.errorMessage ?? ''));
      }
    } catch (e) {
      debugPrint("exception save user info : ${e.toString()}");
      emit(UserInfoFetchError(e.toString()));
    }
  }

  Future<void> updateInfo(Info info) async {
    username = info.username ?? '';
    dob = info.dob ?? '';
    gender = info.gender ?? '';
    fat = info.fat ?? '';
    height = '${info.height}';
    weight = '${info.weight}';
    goals = '${info.goals}';
    activeness = info.activeness ?? '';
    diet = info.diet ?? '';
    mealPerDay = info.mealPerDay ?? '';
  }
}
