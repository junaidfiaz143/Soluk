import 'dart:convert';

import 'package:app/module/user/models/dashboard/influencer_blog_view_all_model.dart';
import 'package:app/module/user/models/dashboard/influencer_view_all_model.dart';
import 'package:app/module/user/models/dashboard/influencer_workput_view_all_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../repo/data_source/remote_data_source.dart';
import '../../../../repo/repository/web_service.dart';
import '../../../../utils/dependency_injection.dart';
import '../../../../utils/enums.dart';
import 'influencer_listing_state.dart';

class InfluencerListingCubit extends Cubit<InfluenceListingState> {
  InfluencerListingCubit() : super(InfluencerListingInitialState());

  int pageNumber = 1;
  bool isBlog = false;

  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  onLoadMore(String ingredientId) async {
    pageNumber++;
    if (isBlog) {
      await getInfluencerBlogsList(initial: false);
    } else {
      await getInfluencersList(initial: false);
    }
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    // await getfavoriteMeal(initial: false);
    _refreshController.refreshCompleted();
  }

  Future<void> getInfluencerWorkoutList({bool initial = true}) async {
    try {
      if (initial) {
        pageNumber = 1;
        emit(const InfluencerListingLoadingState());
      }
      var response;
      ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
          endPoint: 'api/user/get-user-workoutplan',
          params: {'limit': '20', 'pageNumber': '$pageNumber'});

      response = jsonDecode(apiResponse.data);
      if (apiResponse.status == APIStatus.success) {
        InfluencerWorkoutViewAllModel _influencerWorkoutViewAllModel =
            InfluencerWorkoutViewAllModel.fromJson(response);
        if ((_influencerWorkoutViewAllModel.responseDetails ?? {}) == {}) {
          emit(const InfluencerListingEmptyState());
        } else {
          emit(InfluencerListingLoadedState(
              influencerWorkoutViewAllModel: _influencerWorkoutViewAllModel));
        }
      } else {
        emit(InternetErrorState(error: apiResponse.errorMessage ?? ''));
      }
    } catch (e) {
      debugPrint("exception workout : ${e.toString()}");
      emit(InternetErrorState(error: e.toString()));
    }
  }

  Future<void> getInfluencersList({bool initial = true}) async {
    try {
      if (initial) {
        pageNumber = 1;
        emit(const InfluencerListingLoadingState());
      }
      var response;
      ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
          endPoint: 'api/influencers',
          params: {'limit': '20', 'pageNumber': '$pageNumber'});

      response = jsonDecode(apiResponse.data);
      if (apiResponse.status == APIStatus.success) {
        InfluencerViewAllModel _influencerViewAllModel =
            InfluencerViewAllModel.fromJson(response);
        if ((_influencerViewAllModel.responseDetails ?? {}) == {}) {
          emit(const InfluencerListingEmptyState());
        } else {
          emit(InfluencerListingLoadedState(
              influencerViewAllModel: _influencerViewAllModel));
        }
      } else {
        emit(InternetErrorState(error: apiResponse.errorMessage ?? ''));
      }
    } catch (e) {
      debugPrint("exception workout : ${e.toString()}");
      emit(InternetErrorState(error: e.toString()));
    }
  }

  Future<void> getInfluencerBlogsList({bool initial = true}) async {
    try {
      if (initial) {
        pageNumber = 1;
        emit(const InfluencerListingLoadingState());
      }
      var response;
      ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
          endPoint: 'api/influencers',
          params: {'limit': '20', 'pageNumber': '$pageNumber'});

      response = jsonDecode(apiResponse.data);
      if (apiResponse.status == APIStatus.success) {
        InfluencerBlogsViewAllModel _influencerBlogsViewAllModel =
            InfluencerBlogsViewAllModel.fromJson(response);
        if ((_influencerBlogsViewAllModel.responseDetails ?? {}) == {}) {
          emit(const InfluencerListingEmptyState());
        } else {
          emit(InfluencerListingLoadedState(
              influencerBlogsViewAllModel: _influencerBlogsViewAllModel));
        }
      } else {
        emit(InternetErrorState(error: apiResponse.errorMessage ?? ''));
      }
    } catch (e) {
      debugPrint("exception workout : ${e.toString()}");
      emit(InternetErrorState(error: e.toString()));
    }
  }
}
