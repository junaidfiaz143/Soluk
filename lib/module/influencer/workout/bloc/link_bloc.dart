import 'package:app/utils/enums.dart';
import 'package:app/module/influencer/workout/model/link.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LinkEvent {
  LinkModel? linkModel;
  int? linkIndex;
  Actions? linkAction;
  LinkEvent.add(LinkModel linkModel);
  LinkEvent.remove(int linkModel);
}

class DeleteLink extends LinkEvent {
  DeleteLink.remove(int index) : super.remove(index) {
    linkAction = Actions.REMOVE;
    linkIndex = index;
  }
}

class AddLink extends LinkEvent {
  AddLink.add(LinkModel link) : super.add(link) {
    linkModel = link;
    linkAction = Actions.ADD;
  }
}

class LinkBloc extends Bloc<LinkEvent, List<LinkModel>> {
  LinkBloc(List<LinkModel> initialState) : super(initialState) {
    on<AddLink>(_addLink);
    on<DeleteLink>(_deleteLink);
  }

  _addLink(AddLink linkEvent, Emitter<List<LinkModel>> emit) {
    if (linkEvent.linkModel != null) {
      List<LinkModel> newLinks = List.from(state);
      newLinks.add(linkEvent.linkModel!);
      emit(newLinks);
    }
  }

  _deleteLink(LinkEvent linkEvent, Emitter<List<LinkModel>> emit) {
    if (linkEvent.linkModel != null) {
      List<LinkModel> newLinks = List.from(state);
      newLinks.removeAt(linkEvent.linkIndex!);
      emit(newLinks);
    }
  }
}
