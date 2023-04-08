part of 'suggestionbloc_cubit.dart';

@immutable
abstract class SuggestionblocState {
  final SuggestionsModal? suggestions;
  const SuggestionblocState({this.suggestions});
}

class SuggestionblocInitial extends SuggestionblocState {}

class SuggestionblocLoading extends SuggestionblocState {
  const SuggestionblocLoading() : super();
}

class SuggestionblocEmpty extends SuggestionblocState {
  const SuggestionblocEmpty() : super();
}

class SuggestionblocLoaded extends SuggestionblocState {
  const SuggestionblocLoaded({SuggestionsModal? suggestions})
      : super(suggestions: suggestions);
}
