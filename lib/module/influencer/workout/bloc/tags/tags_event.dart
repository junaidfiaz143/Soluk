part of 'tags_bloc.dart';

@immutable
abstract class TagsEvent {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingEvent extends TagsEvent{}

class TagsLoadedEvent extends TagsEvent{}
