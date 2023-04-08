import 'dart:convert';

import 'package:app/module/influencer/more/model/suggestion_model.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'suggestionbloc_state.dart';

class SuggestionblocCubit extends Cubit<SuggestionblocState> {
  SuggestionblocCubit() : super(SuggestionblocInitial());
   final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;
   onLoadMore() async {
    pageNumber++;
    await getSuggestions(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    // await getfavoriteMeal(initial: false);
    _refreshController.refreshCompleted();
  }
   getSuggestions({bool initial = true}) async {
    if (initial) {
      pageNumber = 1;
      emit(const SuggestionblocLoading());
    }

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetBody(
        endPoint: 'api/user/user-suggestions', //?limit=10&pageNumber=1&userId=8',
        params: {
          'limit': '20',
          'pageNumber': '$pageNumber',
        },
        body:  {"suggestion": "feedback"}
        );
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    SuggestionsModal _blogData = SuggestionsModal.fromJson(response);
    if (initial) {
      if ((_blogData.responseDetails?.data ?? []).isEmpty) {
        emit(const SuggestionblocEmpty());
      } else {
        emit(SuggestionblocLoaded(suggestions: _blogData));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.suggestions?.responseDetails!.currentPage = pageNumber;
      state.suggestions?.responseDetails?.data = [
        ...state.suggestions?.responseDetails?.data ?? [],
        ..._blogData.responseDetails?.data ?? []
      ];
      emit(SuggestionblocLoaded(suggestions: state.suggestions));
    }
  }
}
