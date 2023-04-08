part of 'get_influencer_bloc.dart';

@immutable
abstract class GetInfluencerState {}

class GetInfluencerInitial extends GetInfluencerState {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState extends GetInfluencerState{}

class GetInfluencerLoadedState extends GetInfluencerState{
  GetInfluencerModel? _getInfluencerModel;

  GetInfluencerLoadedState(this._getInfluencerModel);

  GetInfluencerModel? get influencerInfo => _getInfluencerModel;
}