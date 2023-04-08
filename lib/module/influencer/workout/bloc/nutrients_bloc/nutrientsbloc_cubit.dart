import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/workout/model/nutrients_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../repo/data_source/local_store.dart';

part 'nutrientsbloc_state.dart';

class NutrientsblocCubit extends Cubit<NutrientsblocState> {
  String? userId = null;
  NutrientsblocCubit() : super(NutrientsblocInitial());
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;

  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();
  Stream<ProgressFile> get progressStream => progressCont.stream;
  StreamSink<ProgressFile> get _progressSink => progressCont.sink;

  onLoadMore() async {
    pageNumber++;
    await getNutrientsBlogs(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    // await getfavoriteMeal(initial: false);
    _refreshController.refreshCompleted();
  }

  Future<bool> addNutrientsBlog(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    // BotToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .
        // postVideosPictures(
        postdioVideosPictures(
            endPoint: 'api/user/add-user-nutrition',
            onUploadProgress: (p) {
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            body: body,
            fileKeyword: fields,
            files: paths);
    // BotToast.closeAllLoading();
    // print(apiResponse.data);
    // print(apiResponse.status);
    // print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getNutrientsBlogs();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateNutrients(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    // BotToast.showLoading();
    ApiResponse apiResponse =
        await sl.get<WebServiceImp>().postdioVideosPictures(
            endPoint: 'api/user/update-user-nutrition',
            onUploadProgress: (p) {
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            body: body,
            fileKeyword: fields,
            files: paths);
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getNutrientsBlogs();
      return true;
    } else {
      return false;
    }
  }
//  Future<bool> addMeal(
//       Map<String, String> body, List<String> fields, List<String> paths) async {
//     SolukToast.showLoading();
//     ApiResponse apiResponse = await sl.get<WebServiceImp>().postVideosPictures(
//         endPoint: 'api/user/add-user-blog',
//         body: body,
//         fileKeyword: fields,
//         files: paths);
//     SolukToast.closeAllLoading();
//     print(apiResponse.data);
//     print(apiResponse.status);
//     print('::::::::::::::::::::::');
//     if (apiResponse.status == APIStatus.success) {
//       getNutrientsBlogs();
//       return true;
//     } else {
//       return false;
//     }
//   }

  Future<bool> deleteNutrientsBlog(String id) async {
    SolukToast.showLoading();
    ApiResponse apiResponse = await sl
        .get<WebServiceImp>()
        .delete(endPoint: 'api/user/delete-user-blog/$id');
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getNutrientsBlogs();
      return true;
    } else {
      return false;
    }
  }

  getNutrientsBlogs({bool initial = true, String? selectedInfluencerId = null}) async {
 //   String userId = await LocalStore.getData(PREFS_USERID);

    if (initial) {

      userId = selectedInfluencerId == null
          ? await LocalStore.getData(PREFS_USERID)
          : selectedInfluencerId;

      pageNumber = 1;
      emit(const NutrientsLoading());
    }

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint:
            'api/user/get-user-nutrition', //?limit=10&pageNumber=1&userId=8',
        params: {
          'limit': '20',
          'pageNumber': '$pageNumber',
          'userId': userId,
          // 'isNutritionBlog': "1"
        });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);
    NutrientsModal _blogData = NutrientsModal.fromJson(response);
    if (initial) {
      if ((_blogData.responseDetails?.data ?? []).isEmpty) {
        emit(const NutrientsblocEmpty());
      } else {
        emit(NutrientsblocLoaded(nutrientsData: _blogData));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.nutrientsData?.responseDetails!.currentPage = pageNumber;
      state.nutrientsData?.responseDetails?.data = [
        ...state.nutrientsData?.responseDetails?.data ?? [],
        ..._blogData.responseDetails?.data ?? []
      ];
      emit(NutrientsblocLoaded(nutrientsData: state.nutrientsData));
    }
  }
}
