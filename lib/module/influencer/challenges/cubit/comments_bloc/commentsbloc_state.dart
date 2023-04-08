part of 'commentsbloc_cubit.dart';

@immutable
abstract class CommentsblocState {
  final CommentsModal? commentsData;
  const CommentsblocState({this.commentsData});
}

class CommentsblocInitial extends CommentsblocState {}
class CommentsLoading extends CommentsblocState{
  const CommentsLoading():super();
}
class CommentsEmpty extends CommentsblocState{
  const CommentsEmpty():super();
}
class CommentsLoaded extends CommentsblocState{
  const CommentsLoaded({CommentsModal? commentsData}):super(commentsData: commentsData);
}