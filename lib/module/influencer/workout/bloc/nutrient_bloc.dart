import 'package:app/utils/enums.dart';
import 'package:app/module/influencer/workout/model/nutrients.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NutrientEvent {
  NutrientModel? model;
  int? i;
  Actions? action;
  NutrientEvent.add(NutrientModel model);
  NutrientEvent.remove(int ind);
}

class Remove extends NutrientEvent {
  Remove.remove(int index) : super.remove(index) {
    action = Actions.REMOVE;
    i = index;
  }
}

class Add extends NutrientEvent {
  Add.add(NutrientModel data) : super.add(data) {
    model = data;
    action = Actions.ADD;
  }
}

class NutrientBloc extends Bloc<NutrientEvent, List<NutrientModel>> {
  NutrientBloc(List<NutrientModel> initialState) : super(initialState) {
    on<Add>(_add);
    on<Remove>(_delete);
  }

  _add(Add event, Emitter<List<NutrientModel>> emit) {
    if (event.model != null) {
      List<NutrientModel> newLinks = List.from(state);
      newLinks.add(event.model!);
      emit(newLinks);
    }
  }

  _delete(NutrientEvent event, Emitter<List<NutrientModel>> emit) {
    if (event.model != null) {
      List<NutrientModel> newLinks = List.from(state);
      newLinks.removeAt(event.i!);
      emit(newLinks);
    }
  }
}
