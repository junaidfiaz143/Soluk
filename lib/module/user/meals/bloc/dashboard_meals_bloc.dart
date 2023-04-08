import 'dart:async';
import 'dart:convert';

import 'package:app/module/user/models/meals/dashboard_meals_model.dart';
import 'package:app/module/user/models/meals/restaurant_model.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../res/constants.dart';

part 'dashboard_meals_bloc_state.dart';

class DashboardMealsBloc extends Cubit<DashboardMealsBlocState> {
  String? userId = null;
  String? selectedMealType = null;
  String resturantSearchTitle = "";
  DashboardMealsModel? customizedMealInfluencerTabModel = null;
  RestaurantModel? customizedResturantModel = null;
  DashboardMealsModel? customMealModel = null;

  DashboardMealsBloc() : super(DashboardMealsBlocInitial());
  RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  final StreamController<DashboardMealsModel?> influencerMealsController =
      StreamController<DashboardMealsModel?>.broadcast();

  Stream<DashboardMealsModel?> get influencerMealsStream =>
      influencerMealsController.stream;

  StreamSink<DashboardMealsModel?> get _influencerMealsSink =>
      influencerMealsController.sink;

  final StreamController<RestaurantModel?> resturantController =
      StreamController<RestaurantModel?>.broadcast();

  Stream<RestaurantModel?> get resturantStream => resturantController.stream;

  StreamSink<RestaurantModel?> get _resturantSink => resturantController.sink;

  final StreamController<DashboardMealsModel?> customMealController =
      StreamController<DashboardMealsModel?>.broadcast();

  Stream<DashboardMealsModel?> get customMealStream =>
      customMealController.stream;

  StreamSink<DashboardMealsModel?> get _customMealSink =>
      customMealController.sink;

  int pageNumber = 1;

  onLoadMore() async {
    pageNumber++;
    await getMealsList(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    // await getfavoriteMeal(initial: false);
    _refreshController.refreshCompleted();
  }

  getMealsList({bool initial = true}) async {
    if (initial) {
      pageNumber = 1;
      emit(const DashboardMealsBlocLoading());
    }

    final queryParameters = json.encode({
      "pageNumber": "$pageNumber",
      "limit": "10",
      "mealType": "$selectedMealType",
      "load": ["ingredients"]
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: "api/meals", body: queryParameters);

    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    DashboardMealsModel _dashboardMealsModel =
        DashboardMealsModel.fromJson(response);
    if (initial) {
      if ((_dashboardMealsModel.responseDetails?.data ?? []).isEmpty) {
        emit(const DashboardMealsBlocEmpty());
      } else {
        emit(DashboardMealsBlocData(dashboardMealsModel: _dashboardMealsModel));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.dashboardMealsModel?.responseDetails!.currentPage = pageNumber;
      state.dashboardMealsModel?.responseDetails?.data = [
        ...state.dashboardMealsModel?.responseDetails?.data ?? [],
        ..._dashboardMealsModel.responseDetails?.data ?? []
      ];
      emit(DashboardMealsBlocData(
          dashboardMealsModel: state.dashboardMealsModel));
    }
  }

  getInfluencerMealsList({bool initial = true}) async {
    if (initial) {
      pageNumber = 1;
      SolukToast.showLoading();
    }

    final queryParameters = json.encode({
      "influencerMeals": true,
      "pageNumber": "$pageNumber",
      "limit": "10",
      "mealType":
          "${selectedMealType == MealType.MainMeal.name ? 'Main meal' : '$selectedMealType'}",
      "load": ["ingredients"]
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: "api/meals", body: queryParameters);

    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    DashboardMealsModel _dashboardMealsModel =
        DashboardMealsModel.fromJson(response);
    if (initial) {
      if ((_dashboardMealsModel.responseDetails?.data ?? []).isEmpty) {
        _influencerMealsSink.add(null);
        //  emit(const DashboardMealsBlocEmpty());
      } else {
        customizedMealInfluencerTabModel = _dashboardMealsModel;
        _influencerMealsSink.add(_dashboardMealsModel);
        // emit(DashboardMealsBlocData(dashboardMealsModel: _dashboardMealsModel));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      customizedMealInfluencerTabModel?.responseDetails!.currentPage =
          pageNumber;
      customizedMealInfluencerTabModel?.responseDetails?.data = [
        ...customizedMealInfluencerTabModel?.responseDetails?.data ?? [],
        ..._dashboardMealsModel.responseDetails?.data ?? []
      ];
      _influencerMealsSink.add(customizedMealInfluencerTabModel);
    }
  }

  getSalukResturantsList({bool initial = true, String searchTitle = ""}) async {
    if (initial) {
      resturantSearchTitle = searchTitle;
      pageNumber = 1;
      SolukToast.showLoading();
    }

    final queryParameters = json.encode({
      "pageNumber": "$pageNumber",
      "limit": "10",
      "title": "$resturantSearchTitle",
      "load": ["meals"]
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: "api/resturants", body: queryParameters);

    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    RestaurantModel _resturantModel = RestaurantModel.fromJson(response);
    if (initial) {
      if ((_resturantModel.responseDetails?.data ?? []).isEmpty) {
        _influencerMealsSink.add(null);
        //  emit(const DashboardMealsBlocEmpty());
      } else {
        customizedResturantModel = _resturantModel;
        _resturantSink.add(_resturantModel);

        // emit(DashboardMealsBlocData(dashboardMealsModel: _dashboardMealsModel));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      customizedResturantModel?.responseDetails!.currentPage = pageNumber;
      customizedResturantModel?.responseDetails?.data = [
        ...customizedResturantModel?.responseDetails?.data ?? [],
        ..._resturantModel.responseDetails?.data ?? []
      ];
      _resturantSink.add(customizedResturantModel);
    }
  }

  getCustomMealsList({bool initial = true}) async {
    if (initial) {
      pageNumber = 1;
      userId = await LocalStore.getData(PREFS_USERID);
      SolukToast.showLoading();
    }

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint: 'api/user/get-fav-meal', //?limit=10&pageNumber=1&userId=8',
        params: {
          'limit': '10',
          'pageNumber': '$pageNumber',
          'userId': userId,
        });

    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    DashboardMealsModel _customMealModel =
        DashboardMealsModel.fromJson(response);
    if (initial) {
      if ((_customMealModel.responseDetails?.data ?? []).isEmpty) {
        _influencerMealsSink.add(null);
        //  emit(const DashboardMealsBlocEmpty());
      } else {
        customMealModel = _customMealModel;
        _customMealSink.add(_customMealModel);

        // emit(DashboardMealsBlocData(dashboardMealsModel: _dashboardMealsModel));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      customMealModel?.responseDetails!.currentPage = pageNumber;
      customMealModel?.responseDetails?.data = [
        ...customMealModel?.responseDetails?.data ?? [],
        ..._customMealModel.responseDetails?.data ?? []
      ];
      _resturantSink.add(customizedResturantModel);
    }
  }
}
