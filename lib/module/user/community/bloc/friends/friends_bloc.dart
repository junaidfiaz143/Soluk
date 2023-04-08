import 'dart:convert';

import 'package:app/module/user/community/model/friend_detail_model.dart';
import 'package:app/module/user/community/model/friends_model.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../repo/data_source/local_store.dart';

part 'friends_bloc_state.dart';

class FriendsBloc extends Cubit<FriendsBlocState> {
  String? userId = null;

  Data? selectedFriend = null;

  FriendsBloc() : super(FriendsBlocInitial());
  RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  int pageNumber = 1;

  onLoadMore() async {
    pageNumber++;
    await getFriendsList(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    await getFriendsList(initial: true);
    _refreshController.refreshCompleted();
  }

  getFriendsList({bool initial = true}) async {
    if (initial) {

      userId = await LocalStore.getData(PREFS_USERID);
      pageNumber = 1;
      emit(const FriendsBlocLoading());
    }

    final queryParameters = json.encode({
      "pageNumber": "$pageNumber",
      "limit": "10",
      "load": ["Followed"]
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
        emit(const FriendsBlocEmpty());
      } else {
        emit(FriendsBlocData(friendsModel: _friendsModel));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.friendsModel?.responseDetails!.currentPage = pageNumber;
      state.friendsModel?.responseDetails?.data = [
        ...state.friendsModel?.responseDetails?.data ?? [],
        ..._friendsModel.responseDetails?.data ?? []
      ];
      emit(FriendsBlocData(friendsModel: state.friendsModel));
    }
  }

}
