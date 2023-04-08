import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/workout/model/meals_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'mealbloc_state.dart';

class MealblocCubit extends Cubit<MealblocState> {
  MealblocCubit() : super(MealblocInitial());
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();
  Stream<ProgressFile> get progressStream => progressCont.stream;
  StreamSink<ProgressFile> get _progressSink => progressCont.sink;
  int pageNumber = 1;
  onLoadMore(String ingredientId) async {
    pageNumber++;
    await getMeals(ingredientId, initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    // await getfavoriteMeal(initial: false);
    _refreshController.refreshCompleted();
  }

  Future<bool> addMealBlog(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .
        // postVideosPictures(
        postdioVideosPictures(
            onUploadProgress: (p) {
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            endPoint: 'api/user/add-user-blog',
            body: body,
            fileKeyword: fields,
            files: paths);
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      pageNumber = 1;
      getMeals('${body['nutritionId']}');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateMealBlog(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .
        // postVideosPictures(
        postdioVideosPictures(
            onUploadProgress: (p) {
              print(((p.done / p.total) * 100).toInt());
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            endPoint: 'api/user/update-user-blog',
            body: body,
            fileKeyword: fields,
            files: paths);
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      pageNumber = 1;
      getMeals('${body['nutritionId']}');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(String id) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .delete(endPoint: 'api/user/delete-user-blog/$id');
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      pageNumber = 1;
      getMeals('${state.blogData!.responseDetails!.id}');
      return true;
    } else {
      return false;
    }
  }

  getMeals(
    String nutrientId, {
    bool initial = true,
  }) async {
    if (initial) {
      pageNumber = 1;
      emit(const MealsLoading());
    }

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint:
            'api/user/get-nutrition-details', //?limit=10&pageNumber=1&userId=8',
        params: {
          'limit': '20',
          'pageNumber': '$pageNumber',
          'nutrition_id': nutrientId
        });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    MealsModal _blogData = MealsModal.fromJson(response);
    if (initial) {
      emit(MealsLoaded(blogData: _blogData));
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.blogData?.responseDetails!.meals?.currentPage = pageNumber;
      state.blogData?.responseDetails?.meals?.data = [
        ...state.blogData?.responseDetails?.meals?.data ?? [],
        ..._blogData.responseDetails?.meals?.data ?? []
      ];
      emit(MealsLoaded(blogData: state.blogData));
    }
  }
}
