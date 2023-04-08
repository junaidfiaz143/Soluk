part of 'get_influencer_bloc.dart';

@immutable
abstract class GetInfluencerEvent {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class LoadingEvent extends GetInfluencerEvent{}

class GetInfluencerLoadedEvent extends GetInfluencerEvent{}
