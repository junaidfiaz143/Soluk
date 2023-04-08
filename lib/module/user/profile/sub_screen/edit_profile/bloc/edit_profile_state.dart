abstract class EditProfileState {
  final dynamic profileData;

  EditProfileState({this.profileData = null});
}

class EditProfileLoadingState extends EditProfileState {
  EditProfileLoadingState() : super();
}

class EditProfileEmptyState extends EditProfileState {
  EditProfileEmptyState() : super();
}

class EditProfileDataLoaded extends EditProfileState {
  EditProfileDataLoaded(dynamic response) : super(profileData: response);
}

class EditProfileUpdatedState extends EditProfileState {
  EditProfileUpdatedState() : super();
}
