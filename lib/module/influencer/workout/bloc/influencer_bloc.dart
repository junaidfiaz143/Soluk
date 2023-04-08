import 'package:app/module/influencer/workout/model/influencer_info.dart';
import 'package:bloc/bloc.dart';

abstract class UpdateInfluencer {
  InfluencerInfo? influencerInfo;
  UpdateInfluencer.newInfluencer(this.influencerInfo);
  UpdateInfluencer.oldInfluencer(this.influencerInfo);
}

class NewInfluencer extends UpdateInfluencer {
  NewInfluencer.newInfluencer(InfluencerInfo? influencerInfo)
      : super.newInfluencer(influencerInfo);
}

class OldInfluencer extends UpdateInfluencer {
  OldInfluencer.oldInfluencer(InfluencerInfo? influencerInfo)
      : super.oldInfluencer(influencerInfo);
}

class InfluencerBloc extends Bloc<UpdateInfluencer, InfluencerInfo> {
  InfluencerBloc(InfluencerInfo initialState) : super(initialState) {
    on<OldInfluencer>(_oldInfluencer);
    on<NewInfluencer>(_newInfluencer);
  }

  _oldInfluencer(OldInfluencer event, Emitter<InfluencerInfo> emit) {
    emit(event.influencerInfo!);
  }

  _newInfluencer(NewInfluencer event, Emitter<InfluencerInfo> emit) {
    emit(event.influencerInfo!);
  }
}
