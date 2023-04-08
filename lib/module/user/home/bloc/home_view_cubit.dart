import 'dart:convert';

import 'package:app/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../repo/data_source/remote_data_source.dart';
import '../../../../repo/repository/web_service.dart';
import '../../../../utils/dependency_injection.dart';
import '../../models/dashboard/user_dashboard_model.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit() : super(HomeViewInitialState());

  // final RefreshController _refController = RefreshController();
  //
  // RefreshController get refController => _refController;
  //
  // onRefresh() async {
  //   await getWorkoutDashboard(call: true);
  //   _refController.refreshCompleted();
  // }

  Future<void> getUserDashboard({bool call = false}) async {
    try {
      emit(const HomeViewLoadingState());

      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPI(endPoint: 'api/client-dashboard');

      if (apiResponse.status == APIStatus.success) {
        var response = jsonDecode(apiResponse.data);
        if (response["status"] == "success") {
          UserDashboardModel _dashboardData =
              UserDashboardModel.fromJson(response);
          if ((_dashboardData.responseDetails ?? {}) == {}) {
            emit(const HomeViewEmptyState());
          } else {
            emit(HomeViewLoadedState(dashboardData: _dashboardData));
          }
        } else {
          emit(const HomeViewEmptyState());
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
