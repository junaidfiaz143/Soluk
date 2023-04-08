part of 'aboutmebloc_cubit.dart';

@immutable
abstract class AboutmeblocState {
 
  final GetInfluencerModel? influencerModel;
  const AboutmeblocState({this.influencerModel});
}

class AboutmeblocInitial extends AboutmeblocState {}


class InfluencerDataLoaded extends AboutmeblocState {
  const InfluencerDataLoaded({GetInfluencerModel? influencerModel}) : super(influencerModel: influencerModel);
}

