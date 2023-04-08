part of 'user_workout_bloc.dart';

@immutable
abstract class UserWorkoutBlocState {
  final UserWorkoutsModel? userWorkoutsModel;
  final UserWorkoutsModel? userWorkoutsDetailModel;
  const UserWorkoutBlocState({this.userWorkoutsModel,this.userWorkoutsDetailModel});
}

class UserWorkoutBlocInitial extends UserWorkoutBlocState {}

class UserWorkoutsListLoadingState extends UserWorkoutBlocState {
  const UserWorkoutsListLoadingState() : super();
}

class UserWorkoutsListEmptyState extends UserWorkoutBlocState {
  const UserWorkoutsListEmptyState() : super();
}

class UserWorkoutsListDataState extends UserWorkoutBlocState {
  const UserWorkoutsListDataState({UserWorkoutsModel? userWorkoutsModel}) : super(userWorkoutsModel: userWorkoutsModel);
}

class UserWorkoutsDetailsLoadingState extends UserWorkoutBlocState {
  const UserWorkoutsDetailsLoadingState() : super();
}

class UserWorkoutsDetailsEmptyState extends UserWorkoutBlocState {
  const UserWorkoutsDetailsEmptyState() : super();
}

class UserWorkoutsDetailsDataState extends UserWorkoutBlocState {
  const UserWorkoutsDetailsDataState({UserWorkoutsModel? userWorkoutsDetailModel}) : super(userWorkoutsDetailModel: userWorkoutsDetailModel);
}
