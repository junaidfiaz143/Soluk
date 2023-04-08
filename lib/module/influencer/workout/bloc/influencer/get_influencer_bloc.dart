import 'dart:async';

import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/influencer/workout/repo/get_infuencer_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_influencer_event.dart';
part 'get_influencer_state.dart';

class GetInfluencerBloc extends Bloc<GetInfluencerEvent, GetInfluencerState> {
  GetInfluencerRepo getInfluencerRepo;

  GetInfluencerBloc({required this.getInfluencerRepo}) : super(LoadingState()) {
    on<LoadingEvent>((event, emit) async {
      emit(LoadingState());
      GetInfluencerModel? _influencerModel = await getInfluencerRepo.getInfluencerInfo();
      emit(GetInfluencerLoadedState(_influencerModel));
    });
  }
}
