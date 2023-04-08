import 'package:app/module/influencer/dashboard/model/chart.dart';
import 'package:app/module/influencer/income_analytics/bloc/dashboard_graph_event.dart';
import 'package:app/module/influencer/income_analytics/repo/income_graph_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../dashboard/model/dashboard_model.dart';
import '../data/income_dummy_data.dart';

part 'dashboard_graph_state.dart';

class DashboardDataBloc extends Bloc<DashboardGraphEvent, DashboardGraphState> {
  final DashboardDataRepo _incomeGraphRepo;

  DashboardDataBloc(this._incomeGraphRepo) : super(IncomeGraphLoadingState()) {
    on<DashboardGraphLoadedEvent>(
      (event, emit) async {
        emit(IncomeGraphLoadingState());
        emit(ViewsGraphLoadingState());

        IncomeChart? incomeData;
        ResponseDetails? data = await _incomeGraphRepo.getDashboardGraphData();
        if (data != null && data.incomeChart != null) {
          incomeData = data.incomeChart;
          emit(IncomeGraphLoadedState(incomeData));
        } else {
          emit(IncomeGraphErrorState());
        }
        if (data != null && data.views != null) {
          emit(ViewsGraphLoadingState());
          Map<String, List<ChartData>> graphData =
              getBlogAndWorkoutGraphData(data.views);
          emit(ViewGraphLoadedState(graphData['blog'], graphData['workout']));
        } else {
          emit(ViewGraphErrorState());
        }
        if (data != null && data.workoutStats != null) {
          emit(WorkoutLoadingState());
          emit(WorkoutLoadedState(data.workoutStats?.workouts));
        }
        if (data != null && data.influencerInfoWithsubscribers != null) {
          emit(RatingLoadedState(
              data.influencerInfoWithsubscribers?[0].info?.rating));
        }
      },
    );
  }

  List<ChartData>? getDays() {
    List<ChartData>? a = [];
    DateTime datetime = DateTime.now();
    for (int i = 1; i < 7; i++) {
      DateTime date = datetime.subtract(Duration(days: i));
      print('${date.day}');
      String day = DateFormat('EE').format(date);
      a.add(ChartData(day, 0));
    }
    return a;
  }
}
