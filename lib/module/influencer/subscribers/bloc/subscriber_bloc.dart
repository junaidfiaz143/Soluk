import 'package:app/module/influencer/subscribers/repo/subscribers_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../user/community/model/friends_model.dart';

part 'subscriber_event.dart';

part 'subscriber_state.dart';

class SubscriberBloc extends Bloc<SubscriberEvent, SubscriberState> {
  final SubscriberRepo _subscriberRepo;

  SubscriberBloc(this._subscriberRepo) : super(SubscribersListLoadingState()) {
    on<SubscribersListLoadingEvent>(
        (event, emit) => emit(SubscribersListLoadingState()));
    on<SubscribersListLoadedEvent>((event, emit) async {
      List<Data>? _subscribersList;
      _subscribersList = await _subscriberRepo.getSubscribersList();
      emit(SubscribersListLoadedState(_subscribersList));
    });
  }

  String? userId = null;

  Data? selectedFriend = null;

  RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  int pageNumber = 1;

  onLoadMore() async {
    pageNumber++;
    await _subscriberRepo.getSubscribersList(pageNumber: pageNumber);
    _refreshController.loadComplete();
  }

  onRefresh() async {
    // pageNumber=0;
    // await getfavoriteMeal(initial: false);
    _refreshController.refreshCompleted();
  }
}
