import 'package:app/module/influencer/challenges/model/challenge.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ChallengeEvent {
  GetAllChallenges? model;
  int? i;
  Actions? action;
  ChallengeEvent.addAll(GetAllChallenges linkModel);
  ChallengeEvent.remove(int linkModel);
}

class RemoveChallengeObject extends ChallengeEvent {
  RemoveChallengeObject(index) : super.remove(index) {
    action = Actions.REMOVE;
    if (model != null &&
        model!.allChallenges != null &&
        model!.allChallenges!.isNotEmpty) {
      model!.allChallenges!.clear();
    }
  }
}

class AddChallengeObject extends ChallengeEvent {
  AddChallengeObject.addAll(GetAllChallenges event) : super.addAll(event) {
    model = event;
    action = Actions.ADD;
  }
}

class ChallengeBloc extends Bloc<ChallengeEvent, GetAllChallenges> {
  ChallengeBloc(GetAllChallenges initialState) : super(initialState) {
    on<AddChallengeObject>(addData);
    on<RemoveChallengeObject>(deleteData);
  }

  addData(AddChallengeObject event, Emitter<GetAllChallenges> emit) {
    if (event.model != null) {
      GetAllChallenges newLinks = state;
      newLinks = (event.model!);
      emit(newLinks);
    }
  }

  deleteData(ChallengeEvent event, Emitter<GetAllChallenges> emit) {
    if (event.model != null) {
      GetAllChallenges newLinks = GetAllChallenges(allChallenges: []);
      emit(newLinks);
    }
  }
}
