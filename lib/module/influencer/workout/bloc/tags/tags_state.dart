part of 'tags_bloc.dart';

@immutable
abstract class TagsState {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState extends TagsState{}

class TagsLoadedState extends TagsState{
  TagsModel _tagsModel;
  TagsLoadedState(this._tagsModel);

  TagsModel get tagsModel => _tagsModel;
}
