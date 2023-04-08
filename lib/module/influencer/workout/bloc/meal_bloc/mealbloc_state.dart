part of 'mealbloc_cubit.dart';

@immutable
abstract class MealblocState {
  final MealsModal? blogData;
  const MealblocState({this.blogData});
}

class MealblocInitial extends MealblocState {}
class MealsLoading extends MealblocState {
  const MealsLoading() : super();
}
class MealsEmpty extends MealblocState {
  const MealsEmpty() : super();
}
class MealsLoaded extends MealblocState {
  const MealsLoaded({MealsModal? blogData}) : super(blogData: blogData);
}