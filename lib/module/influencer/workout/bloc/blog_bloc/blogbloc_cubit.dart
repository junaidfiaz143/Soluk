import 'dart:async';
import 'dart:convert';

import 'package:app/module/influencer/workout/model/blog_modal.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'blogbloc_state.dart';

class BlogblocCubit extends Cubit<BlogblocState> {
  BlogblocCubit() : super(BlogblocInitial());
  final RefreshController _refreshController = RefreshController();
  RefreshController get refreshController => _refreshController;
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();
  Stream<ProgressFile> get progressStream => progressCont.stream;
  StreamSink<ProgressFile> get _progressSink => progressCont.sink;
  int pageNumber = 1;

  String? selectedInfluencerId;

  onLoadMore() async {
    print('loaddddddddd');
    pageNumber++;
    await getBlogs(initial: false);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    pageNumber = 1;
    await getBlogs(initial: false);
    _refreshController.refreshCompleted();
  }

  Future<bool> addBlog(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    // BotToast.showLoading();
    ApiResponse apiResponse =
        await sl.get<WebServiceImp>().postdioVideosPictures(
            onUploadProgress: (p) {
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            // .postVideosPictures(
            endPoint: 'api/user/add-user-blog',
            body: body,
            fileKeyword: fields,
            files: paths);
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('::::::::::::::::::::::');
    if (apiResponse.status == APIStatus.success) {
      getBlogs();
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> updateBlog(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    // SolukToast.showLoading();
    ApiResponse apiResponse = await sl.get<WebServiceImp>().postdioVideosPictures(
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
      getBlogs();
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
      getBlogs();
      return true;
    } else {
      return false;
    }
  }

  getBlogs({bool initial = true}) async {
    // String userId = await LocalStore.getData(PREFS_USERID);

    if (initial) {
      pageNumber = 1;
      emit(const BlogblocLoading());
    }

    ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint: 'api/user/get-user-blog', //?limit=10&pageNumber=1&userId=8',
        params: {
          'limit': '20',
          'pageNumber': '$pageNumber',
          'userId': selectedInfluencerId,
          'isNutritionBlog': "0"
        });
    var response = jsonDecode(apiResponse.data);
    print(apiResponse.statusCode);
    print(apiResponse.data);
    print(apiResponse.status);

    solukLog(logMsg: selectedInfluencerId, logDetail: "userId");
    solukLog(logMsg: response);
    BlogsModal _blogData = BlogsModal.fromJson(response);
    solukLog(logMsg: _blogData.responseDetails!.data!.length);
    if (initial) {
      if (_blogData.responseDetails!.data!.isEmpty) {
        emit(const BlogblocEmpty());
      } else {
        emit(BlogblocLoaded(blogData: _blogData));
      }
    } else {
      //  FavMealsModal fav= FavMealsModal();
      state.blogData?.responseDetails!.currentPage = pageNumber;

      state.blogData?.responseDetails?.data = [
        ...state.blogData?.responseDetails?.data ?? [],
        ..._blogData.responseDetails?.data ?? []
      ];
      emit(BlogblocLoaded(blogData: state.blogData));
    }
  }

/*
  https://soluk.app/api/user/update-user-blog


  Form-data params:
  key: blog_id
  value: blogId
  */

  addBlogView({String? blogId}) async {
    var headers = {
      'Authorization': 'Bearer ${sl.get<AccessDataMembers>().token}',
      'Content-Type': 'application/json'
    };
    var request = Request('POST', Uri.parse("https://soluk.app/api/view"));
    request.body = json.encode({
      "againstType": "blog",
      "againstId": blogId,
    });
    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  // updateBlogViewCount(String blogId) async {
  //   ApiResponse apiResponse = await sl.get<WebServiceImp>().callPostAPI(
  //     endPoint: "api/user/update-user-blog",
  //     body: {"blog_id": blogId},
  //   );
  // }
}
