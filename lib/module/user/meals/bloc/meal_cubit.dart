import 'dart:convert';

import 'package:app/module/user/models/meal/meal_dashboard.dart';
import 'package:app/module/user/models/meals/dashboard_meals_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../repo/data_source/remote_data_source.dart';
import '../../../../repo/repository/web_service.dart';
import '../../../../res/constants.dart';
import '../../../../utils/dependency_injection.dart';
import '../../../../utils/enums.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealInitial());

  int currentDay = 1;

  Future<void> saveUserInfo(String userId) async {
    try {
      emit(MealInfoLoading());
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPI(endPoint: 'api/client-meal-dashboard');

      var response = jsonDecode(apiResponse.data);
      if (apiResponse.status == APIStatus.success) {
        await LocalStore.saveData(
            USER_CALORIE_RANGE, response['responseDetails']['caloriesRange']);
        emit(MealInfoLoaded(response['responseDetails']['caloriesRange']));
      } else {
        emit(MealInfoError(apiResponse.errorMessage ?? ''));
      }
    } catch (e) {
      debugPrint("exception save user info : ${e.toString()}");
      emit(MealInfoError(e.toString()));
    }
  }

  getMealInfo(int day) async {
    String? mealPerDay = await LocalStore.getData('$day');
    if (mealPerDay == null) {
      fetchMealDashboardData(day);
      return;
    }
    emit(MealInfoLoaded(MealPerDay.fromJson(jsonDecode(mealPerDay))));
  }

  Future<void> fetchMealDashboardData(int day) async {
    try {
      emit(MealInfoLoading());

      if (day < 1 || day > 7) {
        ApiResponse apiResponse = await sl
            .get<WebServiceImp>()
            .fetchGetAPI(endPoint: 'api/client-meal-dashboard');
        var response = jsonDecode(apiResponse.data);
        if (apiResponse.status == APIStatus.success) {
          MealDashboard responseModel = MealDashboard.fromJson(response);
          await saveMealFetchingTime();
          await saveMealDaysCount(
              responseModel.responseDetails?.toJson().keys.length == 1);
          await saveMealInfo(responseModel);
        } else {
          emit(MealInfoError(apiResponse.errorMessage ?? ''));
        }
      } else {}
    } catch (e) {
      debugPrint("exception save user info : ${e.toString()}");
      emit(MealInfoError(e.toString()));
    }
  }

  saveMealInfo(MealDashboard mealDashboard) async {
    final Map<String, dynamic>? meal = mealDashboard.responseDetails?.toJson();
    meal?.keys.forEach((key) async {
      await LocalStore.saveData(key, jsonEncode(meal[key]));
    });
    int day = await isNeedToUpdateMealInfo();
    getMealInfo(day);
  }

  Future updateExistingMealInfo(Meal? meal) async {
    String? data = await LocalStore.getData('$currentDay');
    if (data != null) {
      var mapData = jsonDecode(data);
      MealPerDay mealPerDay = MealPerDay.fromJson(mapData);
      int? mealItemIndex = -1;
      if (meal?.mealType == MealType.Breakfast.name) {
        mealItemIndex = mealPerDay.breakfast
            ?.indexWhere((element) => element.id == meal?.id);
        mealPerDay.breakfast?[mealItemIndex!] = meal!;
      } else if (meal?.mealType == MealType.Lunch.name) {
        mealItemIndex =
            mealPerDay.lunch?.indexWhere((element) => element.id == meal?.id);
        mealPerDay.lunch?[mealItemIndex!] = meal!;
      } else if (meal?.mealType == MealType.Snack.name) {
        mealItemIndex =
            mealPerDay.snack?.indexWhere((element) => element.id == meal?.id);
        mealPerDay.snack?[mealItemIndex!] = meal!;
      } else if (meal?.mealType == MealType.Dinner.name) {
        mealItemIndex =
            mealPerDay.dinner?.indexWhere((element) => element.id == meal?.id);
        mealPerDay.dinner?[mealItemIndex!] = meal!;
      } else if (meal?.mealType == MealType.MainMeal.name) {
        mealItemIndex = mealPerDay.mainMeal
            ?.indexWhere((element) => element.id == meal?.id);
        mealPerDay.mainMeal?[mealItemIndex!] = meal!;
      }
      if (mealItemIndex != -1) {
        await LocalStore.saveData('$currentDay', jsonEncode(mealPerDay));
      } else {}
    } else {
      await LocalStore.saveData('$currentDay', jsonEncode(meal));
    }
  }

  Future<void> deletionOfMeal(
      {required Meal? meals, required String? mealType}) async {
    // int totalCalorie = 0;
    // int totalFat = 0;
    // int totalProteins = 0;
    // int totalCarbs = 0;
    //
    // meals?.forEach((element) {
    //   totalCalorie = totalCalorie + (element.calories ?? 0);
    //   totalFat = totalFat + (element.fats ?? 0);
    //   totalProteins = totalProteins + (element.proteins ?? 0);
    //   totalCarbs = totalCarbs + (element.carbs ?? 0);
    // });
    String? data = await LocalStore.getData('$currentDay');
    if (data != null && meals != null) {
      var mapData = jsonDecode(data);
      MealPerDay mealPerDay = MealPerDay.fromJson(mapData);
      if (mealType == MealType.Breakfast.name) {
        mealPerDay.breakfast?.removeWhere((element) => element.id == meals.id);
      } else if (mealType == MealType.Lunch.name) {
        mealPerDay.lunch?.removeWhere((element) => element.id == meals.id);
      } else if (mealType == MealType.Snack.name) {
        mealPerDay.snack?.removeWhere((element) => element.id == meals.id);
      } else if (mealType == MealType.Dinner.name) {
        mealPerDay.dinner?.removeWhere((element) => element.id == meals.id);
      } else if (mealType == MealType.MainMeal.name) {
        mealPerDay.mainMeal?.removeWhere((element) => element.id == meals.id);
      }
      await LocalStore.saveData('$currentDay', jsonEncode(mealPerDay));
    }
  }

  Future<void> customizationOfMeal(
      {required List<Meal>? meals,
      required String? mealType,
      String? day}) async {
    // int totalCalorie = 0;
    // int totalFat = 0;
    // int totalProteins = 0;
    // int totalCarbs = 0;
    //
    // meals?.forEach((element) {
    //   totalCalorie = totalCalorie + (element.calories ?? 0);
    //   totalFat = totalFat + (element.fats ?? 0);
    //   totalProteins = totalProteins + (element.proteins ?? 0);
    //   totalCarbs = totalCarbs + (element.carbs ?? 0);
    // });
    //
    String? data;
    if (day != null) {
      data = await LocalStore.getData(day);
    } else {
      data = await LocalStore.getData('$currentDay');
    }

    if (data != null && meals != null) {
      var mapData = jsonDecode(data);
      MealPerDay mealPerDay = MealPerDay.fromJson(mapData);
      if (mealType == MealType.Breakfast.name) {
        mealPerDay.breakfast?.addAll(meals);
      } else if (mealType == MealType.Lunch.name) {
        mealPerDay.lunch?.addAll(meals);
      } else if (mealType == MealType.Snack.name) {
        mealPerDay.snack?.addAll(meals);
      } else if (mealType == MealType.Dinner.name) {
        mealPerDay.dinner?.addAll(meals);
      } else if (mealType == MealType.MainMeal.name) {
        mealPerDay.mainMeal?.addAll(meals);
      }

      await LocalStore.saveData('$currentDay', jsonEncode(mealPerDay));
    }
  }

  Future<int> isNeedToUpdateMealInfo() async {
    DateTime? updateDate = await getMealFetchingDate();
    if (updateDate == null) return 0;
    DateTime currentDate = DateTime.now();
    int difference = currentDate.difference(updateDate).inDays;
    return difference + 1;
  }

  Future<DateTime?> getMealFetchingDate() async {
    String? time = await LocalStore.getData(MEAL_FETCH_TIME);
    if (time != null)
      return new DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);
    else
      return null;
  }

  saveMealFetchingTime() async {
    String currentDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    await LocalStore.saveData(MEAL_FETCH_TIME, currentDate);
  }

  saveMealDaysCount(bool isOnlyOneMeal) async {
    await LocalStore.saveData(MEAL_DAYS_COUNT, isOnlyOneMeal);
  }
}
