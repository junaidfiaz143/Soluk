part of 'workoutdashboardbloc_cubit.dart';

@immutable
abstract class WorkoutdashboardblocState {
  final WorkoutDashboardModal? dashboardData;
  const WorkoutdashboardblocState({this.dashboardData});
}

class WorkoutdashboardblocInitial extends WorkoutdashboardblocState {}
class WorkoutdashboardEmpty extends WorkoutdashboardblocState {
  const WorkoutdashboardEmpty():super();
}
class WorkoutdashboardLoading extends WorkoutdashboardblocState {
  const WorkoutdashboardLoading():super();
}
class WorkoutdashboardLoaded extends WorkoutdashboardblocState {
  const WorkoutdashboardLoaded({WorkoutDashboardModal? dashboardData}):super(dashboardData: dashboardData);
}
