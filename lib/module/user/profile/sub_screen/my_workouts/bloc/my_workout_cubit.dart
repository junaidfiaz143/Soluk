import 'package:app/module/user/profile/sub_screen/my_workouts/data/my_workout_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../models/my_workout_response.dart';
import 'my_workout_state.dart';

class MyWorkoutCubit extends Cubit<MyWorkoutState> {
  MyWorkoutCubit(MyWorkoutState initialState) : super(initialState);
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;

  getMyWorkoutPlans({bool initial = true}) async {
    // if(initial)
    emit(MyWorkoutLoadingState());

    Future.delayed(Duration(milliseconds: 0), () async {
      var repository = MyWorkoutRepository();

      MyWorkoutResponse? myWorkoutResponse =
          await repository.getMyWorkoutList();
      if (myWorkoutResponse != null &&
          myWorkoutResponse.responseDetails?.data?.isNotEmpty == true) {
        emit(MyWorkoutDataLoaded(myWorkoutResponse));
      } else {
        emit(MyWorkoutEmptyState());
      }
    });
  }

  onLoadMore() async {
    pageNumber++;
    await getMyWorkoutPlans(initial: false);
    _refreshController.loadComplete();
  }
}
