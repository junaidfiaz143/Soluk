import 'dart:convert';

import 'package:app/module/influencer/challenges/cubit/participants_bloc/participants_bloc_state.dart';
import 'package:app/module/influencer/challenges/model/participant_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ParticipantsBlocCubit extends Cubit<ParticipantBlocState> {
  ParticipantsBlocCubit() : super(ParticipantBlocInitial());
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;

  Future<bool> addComment(
    String challengeId,
    String descrip,
  ) async {
    BotToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
      endPoint: 'api/user/challenges/$challengeId/comments',
      body: {"description": descrip},
    );
    BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      pageNumber = 1;
      getParticipants(challengeId, initial: false, refresh: true);
      return true;
    } else {
      return false;
    }
  }

  onLoadMore(String challengeId) async {
    pageNumber++;
    await getParticipants(challengeId, initial: false);
    _refreshController.loadComplete();
  }

  onRefresh(String challengeId) async {
    pageNumber = 1;
    await getParticipants(challengeId, initial: false, refresh: true);
    _refreshController.refreshCompleted();
  }

  Future<void> getParticipants(String challengeId,
      {bool initial = true,
      bool refresh = false,
      bool showRating = false}) async {
    if (initial) {
      pageNumber = 1;
      emit(const ParticipantsLoading());
    }

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPIWithBody(
        endPoint: 'api/user/challenges/$challengeId/participants',
        body: json.encode({
          'limit': '20',
          'pageNumber': '$pageNumber',
          "load": ["rating", "participant"]
        }));
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);

    ParticipantModal _participantData = ParticipantModal.fromJson(response);
    List<DataParticipant> filterList =
        filterRewardedParticipants(_participantData);

    if (initial || refresh) {
      if ((_participantData.responseDetails?.data ?? []).isEmpty) {
        emit(const ParticipantsEmpty());
      } else {
        emit(ParticipantsLoaded(
            participantModal: _participantData, filterList: filterList));
      }
    } else {
      state.participantModal?.responseDetails!.currentPage = pageNumber;
      state.participantModal?.responseDetails?.data = [
        ...state.participantModal?.responseDetails?.data ?? [],
        ..._participantData.responseDetails?.data ?? []
      ];
      emit(ParticipantsLoaded(participantModal: state.participantModal));
    }
  }

  List<DataParticipant> filterRewardedParticipants(
      ParticipantModal participantData) {
    List<DataParticipant> list = [];
    for (DataParticipant item in participantData.responseDetails?.data ?? []) {
      if (item.isRewarded == 1) list.add(item);
    }
    return list;
  }

  Future<bool> callRewardParticipant(
      String challengeId, String participantId) async {
    BotToast.showLoading();

    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
        endPoint: '/api/challenges/$challengeId/participant/$participantId',
        body: {
          'isRewarded': '1',
        });
    BotToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      pageNumber = 1;
      // getParticipants(challengeId, initial: false, refresh: true);
      return true;
    } else {
      return false;
    }
  }
}
