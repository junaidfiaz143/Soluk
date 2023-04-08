import 'package:app/utils/enums.dart';
import 'package:app/module/influencer/workout/model/blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlogEvent {
  BlogModel? model;
  int? i;
  Actions? action;
  BlogEvent.add(BlogModel linkModel);
  BlogEvent.remove(int linkModel);
}

class Remove extends BlogEvent {
  Remove.remove(int index) : super.remove(index) {
    action = Actions.REMOVE;
    i = index;
  }
}

class Add extends BlogEvent {
  Add.add(BlogModel event) : super.add(event) {
    model = event;
    action = Actions.ADD;
  }
}

class BlogBloc extends Bloc<BlogEvent, List<BlogModel>> {
  BlogBloc(List<BlogModel> initialState) : super(initialState) {
    on<Add>(_add);
    on<Remove>(_delete);
  }

  _add(Add event, Emitter<List<BlogModel>> emit) {
    if (event.model != null) {
      List<BlogModel> newLinks = List.from(state);
      newLinks.add(event.model!);
      emit(newLinks);
    }
  }

  _delete(BlogEvent event, Emitter<List<BlogModel>> emit) {
    if (event.model != null) {
      List<BlogModel> newLinks = List.from(state);
      newLinks.removeAt(event.i!);
      emit(newLinks);
    }
  }
}
