import 'package:app/module/user/profile/sub_screen/my_downloads/data/my_downloads_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'my_downloads_state.dart';

class MyDownloadsCubit extends Cubit<MyDownloadState> {
  MyDownloadsCubit(MyDownloadState initialState) : super(initialState);
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;

  var repository;

  getInfluencersList({bool initial = true}) async {
    emit(MyDownloadLoadingState());

    Future.delayed(Duration(milliseconds: 0), () async {
      repository = MyDownloadRepository();

      var list = await repository.getAllInfluencers();
      if (list.isNotEmpty) {
        emit(MyDownloadDataLoaded(list));
      } else {
        emit(MyDownloadEmptyState());
      }
    });
  }

  refreshData() async {
    var list = await repository.getAllInfluencers();
    if (list.isNotEmpty) {
      emit(MyDownloadDataLoaded(list));
    } else {
      emit(MyDownloadEmptyState());
    }
  }

  onLoadMore(String challengeId) async {
    pageNumber++;
    await getInfluencersList(initial: false);
    _refreshController.loadComplete();
  }
}
