import 'package:app/module/user/models/influencer_follow_status.dart';
import 'package:bloc/bloc.dart';

import 'influencer_status_bloc_state.dart';
import 'infuencer_screen_repo.dart';

class InfluencerStatusScreenCubit extends Cubit<InfluencerStatusBlocState> {
  InfluencerStatusScreenCubit() : super(InfluencerStatusBlocInitial());

  InfluencerScreenRepo getInfluencerRepo = InfluencerScreenRepo();

  getInfluencerFollowStatus(String influencerId) async {
    emit(InfluencerStatusBlocInitial());
    InfluencerFollowStatus? _influencerStatusModel =
        await getInfluencerRepo.getInfluencerFollowStatus(influencerId);

    if (_influencerStatusModel
            ?.responseDetails?.data?.first.followd_influencer_count ==
        1)
      emit(InfluencerStatusLoaded(status: true));
    else
      emit(InfluencerStatusLoaded(status: false));
  }

  followInfluencer(String influencerId) async {
    bool _success = await getInfluencerRepo.getInfluencerFollow(influencerId);
    if (_success) {
      emit(InfluencerStatusLoaded(status: true));
    }
  }

  unfollowInfluencer(String influencerId) async {
    bool _success = await getInfluencerRepo.getInfluencerUnfollow(influencerId);
    if (_success) {
      emit(InfluencerStatusLoaded(status: false));
    }
  }
}
