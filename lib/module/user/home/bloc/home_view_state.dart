part of 'home_view_cubit.dart';

@immutable
abstract class HomeViewState {
  final UserDashboardModel? dashboardData;

  const HomeViewState({this.dashboardData});
}

class HomeViewInitialState extends HomeViewState {}

class HomeViewEmptyState extends HomeViewState {
  const HomeViewEmptyState() : super();
}

class HomeViewLoadingState extends HomeViewState {
  const HomeViewLoadingState() : super();
}

class HomeViewLoadedState extends HomeViewState {
  const HomeViewLoadedState({UserDashboardModel? dashboardData})
      : super(dashboardData: dashboardData);
}

class InternetErrorState extends HomeViewState {
  final String error;

  InternetErrorState({required this.error});
}
