import 'dart:async';

import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/influencer/workout/repo/get_tags.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  TagsRepo tagsRepo;

  TagsBloc({required this.tagsRepo}) : super(LoadingState()) {
    on<LoadingEvent>((event, emit) async {
      emit(LoadingState());

      TagsModel? _tagsModel = await tagsRepo.getAllTags();
      emit(TagsLoadedState(_tagsModel));
      
    });
  }
}
