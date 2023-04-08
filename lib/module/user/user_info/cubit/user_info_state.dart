part of 'user_info_cubit.dart';

abstract class SaveUserInfoState {
  const SaveUserInfoState();
}

class SaveInfoInitial extends SaveUserInfoState {}

class UserInfoSaving extends SaveUserInfoState {}

class UserInfoSaved extends SaveUserInfoState {
  final String caloriesRange;
  UserInfoSaved(this.caloriesRange);
}

class UserInfoSaveError extends SaveUserInfoState {
  final String error;

  UserInfoSaveError(this.error);
}

//
class UserInfoFetching extends SaveUserInfoState {}

class UserInfoFetched extends SaveUserInfoState {}

class UserInfoFetchError extends SaveUserInfoState {
  final String error;

  UserInfoFetchError(this.error);
}
