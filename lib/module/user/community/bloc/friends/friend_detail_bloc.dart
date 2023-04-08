import 'dart:async';
import 'dart:convert';

import 'package:app/module/user/community/model/friend_detail_model.dart';
import 'package:app/module/user/community/model/user_activities_model.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../utils/enums.dart';
import '../../../../../utils/soluk_toast.dart';

part 'friend_detail_bloc_state.dart';

class FriendDetailBloc extends Cubit<FriendDetailBlocState> {
  FriendDetailBloc() : super(FriendsBlocInitial());
  RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  final StreamController<UserActivitiesModel> userActivitiesController =
      StreamController<UserActivitiesModel>.broadcast();

  Stream<UserActivitiesModel> get userActivitiesStream =>
      userActivitiesController.stream;

  StreamSink<UserActivitiesModel> get _userActivitiesSink =>
      userActivitiesController.sink;

  final StreamController<bool> followUnFollowController =
      StreamController<bool>.broadcast();

  Stream<bool> get followUnFollowStream =>
      followUnFollowController.stream;

  StreamSink<bool> get _followUnFollowSink =>
      followUnFollowController.sink;

  int pageNumber = 1;

  getFriendDetail(id) async {
    emit(const FriendDetailBlocLoading());

    final queryParameters = json.encode({"userId": id});

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPIWithBody(
        endPoint: "api/user-details", body: queryParameters);

    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    FriendDetailModel _friendDetailModel = FriendDetailModel.fromJson(response);

    if (_friendDetailModel.responseDetails != null) {
      emit(FriendDetailsData(friendDetailModel: _friendDetailModel));
    } /* else {
      emit(FriendsDetailsData(friendDetailModel: _friendDetailModel));
    }*/
  }

  getUserActivitiesDetail(id) async {
    // emit(const FriendDetailBlocLoading());

    final queryParameters = json.encode({"user_id": id});

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .fetchGetAPIWithBody(endPoint: "api/activities", body: queryParameters);

    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    UserActivitiesModel _userActivitiesModel =
        UserActivitiesModel.fromJson(response);

    if (_userActivitiesModel.responseDetails != null) {
      _userActivitiesSink.add(_userActivitiesModel);
      // emit(FriendDetailsData(_userActivitiesModel: _userActivitiesModel));
    } /* else {
      emit(FriendsDetailsData(friendDetailModel: _friendDetailModel));
    }*/
  }

  followUser({String? id}) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .callPostAPI(endPoint: "api/user/client/followType/follow/$id", body: {});

    SolukToast.closeAllLoading();
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);

    if(apiResponse.status==APIStatus.success){
      _followUnFollowSink.add(true);
    }


    /*  FriendsModel _friendsModel = FriendsModel.fromJson(response);
    if (_friendsModel.responseDetails != null) {
      getFriendsList();
    }*/
  }


  unFollowUser({String? id}) async {

    SolukToast.showLoading();

    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .callPostAPI(endPoint: "api/user/client/followType/unfollow/$id", body: {});

    SolukToast.closeAllLoading();

    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);

    if(apiResponse.status==APIStatus.success){
      _followUnFollowSink.add(false);
    }
  }
}
