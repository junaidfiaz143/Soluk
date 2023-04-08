import 'dart:convert';

import 'package:app/module/user/models/dashboard/tag_search_influencer_model.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../../../repo/data_source/remote_data_source.dart';
import '../../../../repo/repository/web_service.dart';
import '../../../../utils/dependency_injection.dart';
import '../../../../utils/enums.dart';
import '../../models/dashboard/user_dashboard_model.dart';
import 'influencer_workout_state.dart';

class InfluencerWorkoutCubit extends Cubit<InfluencerWorkoutState> {
  InfluencerWorkoutCubit() : super(InfluencerWorkoutInitialState());

  Future<void> getInfluencerByTagSearch({bool call = false,required int id}) async {
    try {
      emit(const InfluencerWorkoutLoadingState());

      final queryParameters = json.encode({"tagId": id});

      var response;
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPIWithBody(endPoint: 'api/client-tag-search',body: queryParameters);
      BotToast.closeAllLoading();

      response = jsonDecode(apiResponse.data);
      if (apiResponse.status == APIStatus.success) {
        TagSearchInfluencerModel _tagSearchInfluencerModel =
        TagSearchInfluencerModel.fromJson(response);
        if ((_tagSearchInfluencerModel.responseDetails ?? {}) == {}) {
          emit(const InfluencerWorkoutEmptyState());
        } else {
          emit(InfluencerWorkoutLoadedState(
              tagSearchInfluencerModel: _tagSearchInfluencerModel));
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
