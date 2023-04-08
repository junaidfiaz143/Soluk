import 'dart:async';
import 'dart:convert';

import 'package:app/module/user/community/model/friends_model.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../repo/data_source/local_store.dart';
import '../../../../../res/constants.dart';
import '../../../../../utils/enums.dart';

part 'community_follow_bloc_state.dart';

class CommunityFollowBloc extends Cubit<CommunityFollowBlocState> {
  String? userId = null;

  CommunityFollowBloc() : super(CommunityFollowBlocInitial());
  RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  final StreamController<bool> followUnFollowController =
      StreamController<bool>.broadcast();

  Stream<bool> get followUnFollowStream => followUnFollowController.stream;

  StreamSink<bool> get _followUnFollowSink => followUnFollowController.sink;

  int pageNumber = 1;

  onLoadMore() async {
    pageNumber++;
    await getFriendsList(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    // await getfavoriteMeal(initial: false);
    await getFriendsList(initial: true);
    _refreshController.refreshCompleted();
  }

  getFriendsList({bool initial = true, String searchingText = ''}) async {
    if (initial) {
      /*userId = selectedInfluencerId == null
          ? await LocalStore.getData(PREFS_USERID)
          : selectedInfluencerId;*/

      userId = await LocalStore.getData(PREFS_USERID);
      // userId = "2";

      pageNumber = 1;
      emit(const CommunityFollowBlocLoading());
    }

    final queryParameters = json.encode({
      "pageNumber": "$pageNumber",
      "limit": "10",
      "roleId": "2",
      "load": ["unFollow"],
      "title": searchingText
    });

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: "api/users", body: queryParameters);

    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    FriendsModel _friendsModel = FriendsModel.fromJson(response);
    if (initial) {
      if ((_friendsModel.responseDetails?.data ?? []).isEmpty) {
        emit(const CommunityFollowBlocEmpty());
      } else {
        emit(CommunityFollowBlocData(friendsModel: _friendsModel));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.friendsModel?.responseDetails!.currentPage = pageNumber;
      state.friendsModel?.responseDetails?.data = [
        ...state.friendsModel?.responseDetails?.data ?? [],
        ..._friendsModel.responseDetails?.data ?? []
      ];
      emit(CommunityFollowBlocData(friendsModel: state.friendsModel));
    }
  }

  followUser({String? id}) async {
    try {
      SolukToast.showLoading();
      ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
          endPoint: "api/user/client/followType/follow/$id", body: {});
      SolukToast.closeAllLoading();

      var response = jsonDecode(apiResponse.data);
      print(apiResponse.statusCode);
      print(apiResponse.data);
      print(apiResponse.status);

      FriendsModel _friendsModel = FriendsModel.fromJson(response);
      if (_friendsModel.responseDetails != null) {
        pageNumber = 1;
        getFriendsList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    /*
    if(apiResponse.status==APIStatus.success){
      _followUnFollowSink.add(true);
    }*/
  }

  unFollowUser({String? id}) async {
    ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
        endPoint: "api/user/client/followType/unfollow/$id", body: {});

    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);

    if (apiResponse.status == APIStatus.success) {
      _followUnFollowSink.add(false);
    }
  }
}
