import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

part 'full_screen_bloc_state.dart';

class FullScreenBloc extends Cubit<FullScreenBlocState> {
  List<StoryItem> storyItems = [];
  late StoryController storyController;

  FullScreenBloc() : super(FullScreenBlocInitial());

  loadingStoryItems() {
    emit(FullScreenLoadingState());
  }

  initController() {
    storyController = new StoryController();
  }

  disposeController() {
    storyController.dispose();
  }

  loadStoryItemVideo({required String url, required Duration duration}) {
    if (duration.compareTo(Duration.zero) <= 0) {
      duration = Duration(seconds: 2);
    }
    storyItems.add(
      StoryItem.pageVideo(
        url,
        imageFit: BoxFit.cover,
        controller: storyController,
        duration: duration,
      ),
    );
  }

  loadStoryItemImage({required String url}) {
    storyItems.add(
      StoryItem.inlineImage(
        url: url,
        imageFit: BoxFit.scaleDown,
        controller: storyController,
        duration: Duration(seconds: 10),
      ),
    );
  }

  showStory() {
    emit(FullScreenStoryItemLoadedState(storyItems));
  }

  updateCheckBox() {
    emit(UpdateCheckState());
  }
}
