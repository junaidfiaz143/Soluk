import 'dart:convert';

import 'package:app/module/influencer/workout/hive/local/my_hive.dart';
import 'package:app/module/influencer/workout/model/workout_dashboard_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'workoutdashboardbloc_state.dart';

class WorkoutdashboardblocCubit extends Cubit<WorkoutdashboardblocState> {
  WorkoutdashboardblocCubit() : super(WorkoutdashboardblocInitial());
  final RefreshController _refController = RefreshController();
  RefreshController get refController => _refController;
  onRefresh() async {
    await getWorkoutDashboard(call: true);
    _refController.refreshCompleted();
  }

  Future<void> getWorkoutDashboard({bool call = false}) async {
    emit(const WorkoutdashboardLoading());
    var response;
    if (MyHive.getAboutInfo() == null || call) {
      ApiResponse apiResponse = await sl
          .get<WebServiceImp>()
          .fetchGetAPI(endPoint: 'api/user/workout-dashboard');
      MyHive.setAboutInfo(aboutMeInfo: apiResponse.data);
      response = jsonDecode(apiResponse.data);
    } else {
      response = jsonDecode(MyHive.getAboutInfo());
    }
    WorkoutDashboardModal _dashboardData =
        WorkoutDashboardModal.fromJson(response);
    if ((_dashboardData.responseDetails ?? {}) == {}) {
      emit(const WorkoutdashboardEmpty());
    } else {
      emit(WorkoutdashboardLoaded(dashboardData: _dashboardData));
    }
  }
}
