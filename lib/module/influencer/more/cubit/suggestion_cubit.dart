// import 'package:app/module/influencer/more/model/suggestion_model.dart';
// import 'package:app/module/influencer/more/repo/more_repository.dart';
// import 'package:app/repo/data_source/remote_data_source.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SuggestionCubit extends Cubit<ApiResponseStateX> {
//   SuggestionCubit(this._moreRepo) : super(const ApiInitialState());
//   final MoreRepository _moreRepo;

//   Future suggestionData() async {
//     emit(const ApiLoadingState());
//     SuggestionModel? suggestions =
//         await MoreRepository.allSuggestionList("api/user/user-suggestions");
//     emit(ApiLoadedState(suggestions!));
//   }
// }