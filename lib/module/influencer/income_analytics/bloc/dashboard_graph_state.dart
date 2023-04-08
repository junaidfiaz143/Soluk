part of 'dashboard_data_bloc.dart';

abstract class DashboardGraphState extends Equatable {
  const DashboardGraphState();

  @override
  List<Object> get props => [];
}

class IncomeGraphLoadingState extends DashboardGraphState {}

class ViewsGraphLoadingState extends DashboardGraphState {}

class WorkoutLoadingState extends DashboardGraphState {}

class IncomeGraphLoadedState extends DashboardGraphState {
  final IncomeChart? _incomeGraphFrontData;

  const IncomeGraphLoadedState(this._incomeGraphFrontData);

  IncomeChart? get getIncomeGraphData => _incomeGraphFrontData;
}

class ViewGraphLoadedState extends DashboardGraphState {
  final List<ChartData>? _viewGraphFrontData1;
  final List<ChartData>? _viewGraphFrontData2;

  const ViewGraphLoadedState(
      this._viewGraphFrontData1, this._viewGraphFrontData2);

  List<ChartData>? get getViewGraphData1 => _viewGraphFrontData1;

  List<ChartData>? get getViewGraphData2 => _viewGraphFrontData2;
}

class WorkoutLoadedState extends DashboardGraphState {
  final Workouts? workouts;

  const WorkoutLoadedState(this.workouts);
}

class RatingLoadedState extends DashboardGraphState {
  final int? rating;

  const RatingLoadedState(this.rating);
}

class IncomeGraphErrorState extends DashboardGraphState {}

class ViewGraphErrorState extends DashboardGraphState {}

class RatingGraphErrorState extends DashboardGraphState {}
