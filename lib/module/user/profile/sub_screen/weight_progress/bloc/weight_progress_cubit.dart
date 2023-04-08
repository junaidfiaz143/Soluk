import 'dart:async';

import 'package:app/module/user/profile/sub_screen/weight_progress/bloc/weight_progress_state.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../data/weight_progress_repository.dart';

class WeightProgressCubit extends Cubit<WeightProgressState> {
  WeightProgressCubit(WeightProgressState initialState) : super(initialState);
  final RefreshController _refreshController = RefreshController();
  var repository = WeightProgressRepository();

  RefreshController get refreshController => _refreshController;
  final StreamController<ProgressFile> progressCont =
      StreamController<ProgressFile>.broadcast();

  Stream<ProgressFile> get progressStream => progressCont.stream;

  StreamSink<ProgressFile> get _progressSink => progressCont.sink;
  int pageNumber = 1;

  getWeightProgressList({bool initial = true}) async {
    // if(initial)
    emit(WeightProgressLoadingState());

    var weightProgressResponse = await repository.getWeightProgress();
    if (weightProgressResponse != null) {
      emit(WeightProgressDataLoaded(weightProgressResponse));
    } else {
      emit(WeightProgressEmptyState());
    }
  }

  deleteWeightProgressItem(String id) async {
    SolukToast.showLoading();
    var result = await repository.deleteWeightProgress(id);
    SolukToast.closeAllLoading();
    return result;

  }

  onLoadMore() async {
    pageNumber++;
    await getWeightProgressList(initial: false);
    _refreshController.loadComplete();
  }

  Future<bool> addWeightProgress(
      Map<String, String> body, List<String> fields, List<String> paths) async {
    ApiResponse apiResponse =
        await sl.get<WebServiceImp>().postdioVideosPictures(
            onUploadProgress: (p) {
              if (p.done == p.total) {
                _progressSink.add(ProgressFile(done: 0, total: 0));
              } else {
                _progressSink.add(p);
              }
            },
            endPoint: 'api/user-weight',
            body: body,
            fileKeyword: fields,
            files: paths);
    SolukToast.closeAllLoading();
    print(apiResponse.data);
    print(apiResponse.status);
    print('');
    if (apiResponse.status == APIStatus.success) {
      pageNumber = 1;
      getWeightProgressList();
      return true;
    } else {
      return false;
    }
  }
}
