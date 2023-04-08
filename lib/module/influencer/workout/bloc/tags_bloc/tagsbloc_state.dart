part of 'tagsbloc_cubit.dart';

@immutable
abstract class TagsblocState {
  final TagsModel? tagsModel;
  const TagsblocState({this.tagsModel});
}

class TagsblocInitial extends TagsblocState {}

class TagsLoaded extends TagsblocState {
  const TagsLoaded({TagsModel? tagsModel}) : super(tagsModel: tagsModel);
}
