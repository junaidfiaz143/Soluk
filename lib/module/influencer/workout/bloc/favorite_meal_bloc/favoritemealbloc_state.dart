part of 'favoritemealbloc_cubit.dart';

@immutable
abstract class FavoritemealblocState {
  final FavMealsModal? favMeal;
  const FavoritemealblocState({this.favMeal});
}

class FavoritemealblocInitial extends FavoritemealblocState {}

class FavoritemealLoading extends FavoritemealblocState {
  const FavoritemealLoading() : super();
}

class FavoritemealEmpty extends FavoritemealblocState {
  const FavoritemealEmpty() : super();
}

class FavoritemealData extends FavoritemealblocState {
  const FavoritemealData({FavMealsModal? favMeals}) : super(favMeal: favMeals);
}
