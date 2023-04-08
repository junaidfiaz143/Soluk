import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/challenges/model/challenges_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'challengesbloc_state.dart';

class ChallengesblocCubit extends Cubit<ChallengesblocState> {
  ChallengesblocCubit() : super(ChallengesblocInitial());
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();
  Stream<ProgressFile> get progressStream => progressCont.stream;
  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;
  Future<bool> addChallenge(
      Map<String, String> body, List<String> fields, List<String> paths) async {
/*

    ApiResponse apiResponse = await sl.get<WebServiceImp>().postVideosPictures(
        endPoint: 'api/user/challenge',
        body: body,
        fileKeyword: fields,
        files: paths);

*/

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
            endPoint: 'api/user/challenge',
            body: body,
            fileKeyword: fields,
            files: paths);

    // BotToast.closeAllLoading();
    print(response.data);
    print(response.status);
    print('::::::::::::::::::::::');
    if (response.status == APIStatus.success) {
      getChallengeData();
      return true;
    } else {
      return false;
    }
  }

  Future<void> getChallengeData(
      {bool initial = true, bool isOnlyApprovedChallenges = false}) async {
    if (initial) {
      pageNumber = 1;
      emit(const ChallengesLoading());
    }

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPI(endPoint: 'api/user/challenges');
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    print(';;;;;;;;;;;;;;;;;;;;');
    ChallengesModal _blogData = ChallengesModal.fromJson(response);
    if (initial) {
      if ((_blogData.responseDetails?.data ?? []).isEmpty) {
        emit(const ChallengesEmpty());
      } else {
        List<Data> approve = [];
        List<Data> unApprove = [];
        (_blogData.responseDetails?.data ?? []).forEach((element) {
          if (element.challengeStatus == 'Approved') {
            approve.add(element);
          } else if (element.challengeStatus == 'Unapproved') {
            unApprove.add(element);
          }
        });
        emit(ChallengesLoaded(
            challengesModal: _blogData,
            approveEmpty: approve.isEmpty ? true : false,
            isOnlyApprovedChallenges: isOnlyApprovedChallenges,
            disApproveEmpty: unApprove.isEmpty ? true : false));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.challengeData?.responseDetails!.currentPage = pageNumber;
      state.challengeData?.responseDetails?.data = [
        ...state.challengeData?.responseDetails?.data ?? [],
        ..._blogData.responseDetails?.data ?? []
      ];
      emit(ChallengesLoaded(
          challengesModal: state.challengeData,
          approveEmpty: false,
          disApproveEmpty: false));
    }
  }
}
