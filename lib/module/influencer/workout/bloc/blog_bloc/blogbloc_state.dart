part of 'blogbloc_cubit.dart';

@immutable
abstract class BlogblocState {
  final BlogsModal? blogData;
  const BlogblocState({this.blogData});
}

class BlogblocInitial extends BlogblocState {}

class BlogblocLoading extends BlogblocState {
  const BlogblocLoading() : super();
}
class BlogblocEmpty extends BlogblocState {
  const BlogblocEmpty() : super();
}
class BlogblocLoaded extends BlogblocState {
  const BlogblocLoaded({BlogsModal? blogData}) : super(blogData: blogData);
}
