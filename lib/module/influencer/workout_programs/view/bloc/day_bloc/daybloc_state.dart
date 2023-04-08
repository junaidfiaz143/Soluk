part of 'daybloc_bloc.dart';

@immutable
abstract class DayblocState {}

class DayblocInitial extends DayblocState {}

class WorkoutPrerequisitesLoadedState extends DayblocState {
  WorkoutPrerequisitesListResponse workoutPrerequisitesListResponse;

  WorkoutPrerequisitesLoadedState(
      {required this.workoutPrerequisitesListResponse});

//List<Subscribers> get subscribersList => _subscribersList;
}

class AddWeekBlocState extends DayblocState {
  AddWorkoutPlanResponse addWorkoutPlanResponse;

  AddWeekBlocState({required this.addWorkoutPlanResponse});
}

class UpdateWeekBlocState extends DayblocState {
  UpdateWorkoutProgramResponse updateWorkoutProgramResponse;

  UpdateWeekBlocState({required this.updateWorkoutProgramResponse});
}

class AddWorkoutWeekState extends DayblocState {
  AddWorkoutWeekResponse addWorkoutWeekResponse;

  AddWorkoutWeekState({required this.addWorkoutWeekResponse});
}

class AddWorkoutDayState extends DayblocState {
  AddWorkoutDayResponse addWorkoutDayResponse;

  AddWorkoutDayState({required this.addWorkoutDayResponse});
}

class AddExerciseLongVideoState extends DayblocState {
  AddExerciseLongVideoResponse addExerciseLongVideoResponse;

  AddExerciseLongVideoState({required this.addExerciseLongVideoResponse});
}

class AddExerciseSingleWorkoutTState extends DayblocState {
  AddExerciseSingleWorkoutTResponse addExerciseSingleWorkoutTResponse;

  AddExerciseSingleWorkoutTState(
      {required this.addExerciseSingleWorkoutTResponse});
}

class GetWorkoutProgramsState extends DayblocState {
  GetWorkoutPlansResponse getWorkoutPlansResponse;

  GetWorkoutProgramsState({required this.getWorkoutPlansResponse});
}

class GetWorkoutWeeksState extends DayblocState {
  GetWorkoutAllWeeksResponse getWorkoutAllWeeksResponse;

  GetWorkoutWeeksState({required this.getWorkoutAllWeeksResponse});
}

class GetWorkoutWeeksAllDaysState extends DayblocState {
  GetWeekAllDaysWorkoutsResponse getWeekAllDaysWorkoutsResponse;

  GetWorkoutWeeksAllDaysState({required this.getWeekAllDaysWorkoutsResponse});
}

class GetWorkoutExerciseState extends DayblocState {
  GetAllExerciseResponse getAllExerciseResponse;

  GetWorkoutExerciseState({required this.getAllExerciseResponse});
}

class LoadingState extends DayblocState {}

class SetStateState extends DayblocState {}

class RefreshWorkoutDayState extends DayblocState {
  int? dayId;

  RefreshWorkoutDayState(this.dayId);
}

class ErrorState extends DayblocState {
  final String error;

  ErrorState({required this.error});
}

class InternetErrorState extends DayblocState {
  final String error;

  InternetErrorState({required this.error});
}
