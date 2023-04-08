part of 'dashboard_meals_bloc.dart';

@immutable
abstract class DashboardMealsBlocState {
  final DashboardMealsModel? dashboardMealsModel;
  const DashboardMealsBlocState({this.dashboardMealsModel});
}

class DashboardMealsBlocInitial extends DashboardMealsBlocState {}

class DashboardMealsBlocLoading extends DashboardMealsBlocState {
  const DashboardMealsBlocLoading() : super();
}

class DashboardMealsBlocEmpty extends DashboardMealsBlocState {
  const DashboardMealsBlocEmpty() : super();
}

class DashboardMealsBlocData extends DashboardMealsBlocState {
  const DashboardMealsBlocData({DashboardMealsModel? dashboardMealsModel}) : super(dashboardMealsModel: dashboardMealsModel);
}

