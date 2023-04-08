import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:bloc/bloc.dart';

import 'influencer_screen_bloc_state.dart';
import 'infuencer_screen_repo.dart';

class InfluencerScreenCubit extends Cubit<InfluencerblocState> {
  InfluencerScreenCubit() : super(InfluencerblocInitial());

  String userId = "";
  InfluencerScreenRepo getInfluencerRepo = InfluencerScreenRepo();

  getInfluencerData(String toUser) async {
    GetInfluencerModel? _influencerModel =
        await getInfluencerRepo.getInfluencerInfo(toUser);
    emit(InfluencerDataLoaded(influencerModel: _influencerModel));
  }

  Future<bool> rateInfluencerRating(int influencerId, double inflRating,
      int workId, double workRating) async {
    return getInfluencerRepo.rateInfluencerWorkout(
        influencerId, inflRating, workId, workRating);
  }
}
