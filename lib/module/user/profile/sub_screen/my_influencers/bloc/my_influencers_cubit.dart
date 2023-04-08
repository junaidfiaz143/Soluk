import 'package:app/module/user/models/my_influencers/my_influencers_response.dart';
import 'package:app/module/user/profile/sub_screen/my_influencers/data/my_influencers_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'my_influencers_state.dart';

class MyInfluencersCubit extends Cubit<MyInfluencersState> {
  MyInfluencersCubit(MyInfluencersState initialState) : super(initialState);
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;

  getInfluencersList({bool initial = true}) async {
    emit(MyInfluencersLoadingState());

    Future.delayed(Duration(milliseconds: 500), () async {
      var repository = MyInfluencerRepository();

      MyInfluencersResponse? response = await repository.getMyInfluencerList();
      if (response != null &&
          response.responseDetails?.data != null &&
          response.responseDetails?.data?.isNotEmpty == true) {
        emit(MyInfluencersDataLoaded(response));
      } else {
        emit(MyInfluencersEmptyState());
      }
    });
  }

  onLoadMore() async {
    pageNumber++;
    await getInfluencersList(initial: false);
    _refreshController.loadComplete();
  }
}
