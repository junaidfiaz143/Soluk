// import 'package:app/module/influencer/more/model/suggestion_model.dart';
// import 'package:app/utils/enums.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class SuggestionEvent {
//   SuggestionModel? model;
//   int? i;
//   Actions? action;
//   SuggestionEvent.addAll(SuggestionModel linkModel);
//   SuggestionEvent.remove(int linkModel);
// }

// class AddSuggestionObject extends SuggestionEvent {
//   AddSuggestionObject.addAll(SuggestionModel event) : super.addAll(event) {
//     model = event;
//     action = Actions.ADD;
//   }
// }

// class SuggestionBloc extends Bloc<SuggestionEvent, SuggestionModel> {
//   SuggestionBloc(SuggestionModel initialState) : super(initialState) {
//     on<AddSuggestionObject>(addData);
//   }

//   addData(SuggestionEvent event, Emitter<SuggestionModel> emit) {
//     if (event.model != null) {
//       SuggestionModel newLinks = state;
//       newLinks = (event.model!);
//       emit(newLinks);
//     }
//   }
// }
