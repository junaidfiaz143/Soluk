part of 'full_screen_bloc.dart';

@immutable
abstract class FullScreenBlocState {
  // const FullScreenBlocState({this.storyItems});
}

class FullScreenBlocInitial extends FullScreenBlocState {}

class FullScreenLoadingState extends FullScreenBlocState {
  FullScreenLoadingState() : super();
}

class UpdateCheckState extends FullScreenBlocState {
  UpdateCheckState() : super();
}

class FullScreenStoryItemLoadedState extends FullScreenBlocState {
  FullScreenStoryItemLoadedState(List<StoryItem> storyItems) : super();
}
