import 'dart:async';
import 'dart:convert';

import 'package:app/module/user/community/model/community_participants_model.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../repo/data_source/local_store.dart';
import '../../../../../../repo/data_source/remote_data_source.dart';
import '../../../../../../repo/repository/web_service.dart';
import '../../../../../../res/constants.dart';
import '../../../../../../utils/dependency_injection.dart';
import '../../../../../../utils/enums.dart';
import '../../../../models/community_challenges_model.dart';
import '../data/community_challenges_repository.dart';

part 'community_challenges_state.dart';

class CommunityChallengesCubit extends Cubit<CommunityChallengesState> {
  String userId = "";
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;

  CommunityChallengesCubit() : super(CommunityChallengesInitial());

  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();

  Stream<ProgressFile> get progressStream => progressCont.stream;

  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  final StreamController<CommunityChallenge?> userChallengeStatusController =
      StreamController<CommunityChallenge?>.broadcast();

  Stream<CommunityChallenge?> get userChallengeStatusStream =>
      userChallengeStatusController.stream;

  StreamSink<CommunityChallenge?> get _userChallengeStatusSink =>
      userChallengeStatusController.sink;

  final StreamController<bool> verifyUSerRatingController =
      StreamController<bool>.broadcast();

  Stream<bool> get verifyUSerRatingStream => verifyUSerRatingController.stream;

  StreamSink<bool> get _verifyUSerRatingSink => verifyUSerRatingController.sink;

  final StreamController<bool> rateParticipentController =
      StreamController<bool>.broadcast();

  Stream<bool> get rateParticipentStream => rateParticipentController.stream;

  StreamSink<bool> get _rateParticipentSink => rateParticipentController.sink;

  getUserId() async {
    userId = await LocalStore.getData(PREFS_USERID);
  }

  getCommunityChallengesList({bool initial = true}) async {
    // if(initial)
    emit(CommunityChallengesLoadingState());

    Future.delayed(Duration(milliseconds: 3000), () async {
      var repository = CommunityChallengesRepository();

      CommunityChallegeModel response =
          await repository.getCommunityChallengesList();
      if (response != null &&
          response.responseDetails?.data?.isNotEmpty == true) {
        emit(CommunityChallengesDataLoaded(response));
      } else {
        emit(CommunityChallengesEmptyState());
      }
    });
  }

  onLoadMore() async {
    pageNumber++;
    await getCommunityChallengesList(initial: false);
    _refreshController.loadComplete();
  }

  Future<void> userChallengeStatus(
    int challengeId, {
    bool initial = true,
  }) async {
    SolukToast.showLoading();

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetBody(endPoint: 'api/user/challenges', body: {
      "challengeId": challengeId,
      "load": [
        "participants",
        "comments",
        {"participants": "count"},
        {"comments": "count"}
      ]
    });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    CommunityChallegeModel _communityChallegeModel =
        CommunityChallegeModel.fromJson(response);
    SolukToast.closeAllLoading();

    _userChallengeStatusSink
        .add(_communityChallegeModel.responseDetails?.data?[0] ?? null);
  }

  Future<bool> startParticipateInChallenge(int challengeId) async {
    SolukToast.showLoading();

    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
        endPoint: 'api/user/challenges/$challengeId/participants', body: {});
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    CommunityChallegeModel _communityChallegeModel =
        CommunityChallegeModel.fromJson(response);
    SolukToast.closeAllLoading();

    if (_communityChallegeModel.status == APIStatus.success.name) {
      return true;
    } else {
      SolukToast.showToast(_communityChallegeModel.responseDescription);
    }
    return false;
  }

  Future<bool> submitChallenge(Map<String, String> body, List<String> fields,
      List<String> paths, int challengeId) async {
    dynamic response = await sl.get<WebServiceImp>().postdioVideosPictures(
        onUploadProgress: (p) {
          print(((p.done / p.total) * 100).toInt());
          if (p.done == p.total) {
            _progressSink.add(ProgressFile(done: 0, total: 0));
          } else {
            _progressSink.add(p);
          }
        },
        endPoint: 'api/challenges/$challengeId/participant/$userId',
        body: body,
        fileKeyword: fields,
        files: paths);

    // BotToast.closeAllLoading();
    print(response.data);
    print(response.status);
    print('::::::::::::::::::::::');
    if (response.status == APIStatus.success) {
      //   getChallengeData();
      return true;
    } else {
      return false;
    }
  }

  Future<void> verifyUserRatedByCurrentUSer(
      int challengeId, int ratedTo) async {
    SolukToast.showLoading();

    final queryParameters =
        json.encode({"rated_by": userId, "rated_to": ratedTo.toString()});

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPIWithBody(
        endPoint: 'api/user/challenges/$challengeId/participant/ratings',
        body: queryParameters);
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    CommunityParticipantsModel _communityParticipantsModel =
        CommunityParticipantsModel.fromJson(response);
    SolukToast.closeAllLoading();

    if (_communityParticipantsModel.responseDetails?.data?.isNotEmpty ??
        false) {
      _verifyUSerRatingSink.add(true);
    } else {
      _verifyUSerRatingSink.add(false);
    }
  }

  Future<bool?> rateParticipent(
      int challengeId, int ratedTo, int cpId, double rating) async {
    SolukToast.showLoading();

    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
        endPoint: 'api/user/challenges/$challengeId/participant/$cpId/rating',
        body: {
          "rated_to": ratedTo.toString(),
          "ratingValue": rating.toString()
        });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    _verifyUSerRatingSink.add(true);
    SolukToast.closeAllLoading();
    if (apiResponse.status == APIStatus.success.name) {
      return true;
    }
  }
}
