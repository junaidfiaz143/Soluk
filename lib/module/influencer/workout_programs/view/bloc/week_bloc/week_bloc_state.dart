part of 'week_bloc_bloc.dart';

@immutable
abstract class WeekBlocState {}

class WeekBlocInitial extends WeekBlocState {}


class WorkoutPrerequisitesLoadedState extends WeekBlocState {
  WorkoutPrerequisitesListResponse workoutPrerequisitesListResponse;
  WorkoutPrerequisitesLoadedState(
      {required this.workoutPrerequisitesListResponse});

  //List<Subscribers> get subscribersList => _subscribersList;
}

class AddWeekBlocState extends WeekBlocState {
  AddWorkoutPlanResponse addWorkoutPlanResponse;
  AddWeekBlocState({required this.addWorkoutPlanResponse});
}

class UpdateWeekBlocState extends WeekBlocState {
  UpdateWorkoutProgramResponse updateWorkoutProgramResponse;
  UpdateWeekBlocState({required this.updateWorkoutProgramResponse});
}

class AddWorkoutWeekState extends WeekBlocState {
  AddWorkoutWeekResponse addWorkoutWeekResponse;
  AddWorkoutWeekState({required this.addWorkoutWeekResponse});
}

class AddWorkoutDayState extends WeekBlocState {
  AddWorkoutDayResponse addWorkoutDayResponse;
  AddWorkoutDayState({required this.addWorkoutDayResponse});
}

class AddExerciseLongVideoState extends WeekBlocState {
  AddExerciseLongVideoResponse addExerciseLongVideoResponse;
  AddExerciseLongVideoState({required this.addExerciseLongVideoResponse});
}

class AddExerciseSingleWorkoutTState extends WeekBlocState {
  AddExerciseSingleWorkoutTResponse addExerciseSingleWorkoutTResponse;
  AddExerciseSingleWorkoutTState(
      {required this.addExerciseSingleWorkoutTResponse});
}

class GetWorkoutProgramsState extends WeekBlocState {
  GetWorkoutPlansResponse getWorkoutPlansResponse;
  GetWorkoutProgramsState({required this.getWorkoutPlansResponse});
}

class GetWorkoutWeeksState extends WeekBlocState {
  GetWorkoutAllWeeksResponse getWorkoutAllWeeksResponse;
  GetWorkoutWeeksState({required this.getWorkoutAllWeeksResponse});
}

class GetWorkoutWeeksAllDaysState extends WeekBlocState {
  GetWeekAllDaysWorkoutsResponse getWeekAllDaysWorkoutsResponse;
  GetWorkoutWeeksAllDaysState({required this.getWeekAllDaysWorkoutsResponse});
}

class GetWorkoutExerciseState extends WeekBlocState {
  GetAllExerciseResponse getAllExerciseResponse;
  GetWorkoutExerciseState({required this.getAllExerciseResponse});
}

class LoadingState extends WeekBlocState {}

class SetStateState extends WeekBlocState {}

class ErrorState extends WeekBlocState {
  final String error;
  ErrorState({required this.error});
}

class InternetErrorState extends WeekBlocState {
  final String error;
  InternetErrorState({required this.error});
}
