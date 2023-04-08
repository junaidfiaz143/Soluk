import 'package:app/module/user/models/my_challenges_response.dart';
import 'package:app/module/user/profile/sub_screen/my_challenges/data/my_challenges_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'my_challenges_state.dart';

class MyChallengesCubit extends Cubit<MyChallengesState> {
  MyChallengesCubit(MyChallengesState initialState) : super(initialState);
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;
  int pageNumber = 1;

  getMyChallengesList({bool initial = true}) async {
    // if(initial)
    emit(MyChallengesLoadingState());
    var repository = MyChallengesRepository();
    MyChallengesResponse? list = await repository.getMyChallengesList();
    if (list != null && list.responseDetails?.data?.isNotEmpty == true) {
      emit(MyChallengesDataLoaded(list));
    } else {
      emit(MyChallengesEmptyState());
    }
  }

  onLoadMore() async {
    pageNumber++;
    await getMyChallengesList(initial: false);
    _refreshController.loadComplete();
  }
}
