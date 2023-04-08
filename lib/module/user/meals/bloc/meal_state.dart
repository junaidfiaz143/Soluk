part of 'meal_cubit.dart';

@immutable
abstract class MealState {}

class MealInitial extends MealState {}

class MealInfoLoading extends MealState {}

class MealInfoLoaded extends MealState {
  final MealPerDay mealDashboard;

  MealInfoLoaded(this.mealDashboard);
}

class MealInfoError extends MealState {
  final String error;

  MealInfoError(this.error);
}
