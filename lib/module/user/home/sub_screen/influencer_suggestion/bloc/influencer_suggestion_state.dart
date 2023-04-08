abstract class InfluencerSuggestionState {
  final myResponse;

  InfluencerSuggestionState({this.myResponse=null});
}

class InfluencerSuggestionLoadingState extends InfluencerSuggestionState {
  InfluencerSuggestionLoadingState() : super();
}

class InfluencerSuggestionInitialStateState extends InfluencerSuggestionState {
  InfluencerSuggestionInitialStateState() : super();
}

class InfluencerSuggestionEmptyState extends InfluencerSuggestionState {
  InfluencerSuggestionEmptyState() : super();
}

class InfluencerSuggestionDataLoaded extends InfluencerSuggestionState {
  InfluencerSuggestionDataLoaded(dynamic myBadgesModelResponse)
      : super(myResponse: dynamic);
}
