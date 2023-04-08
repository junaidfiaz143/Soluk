part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {
  final String? image;
  // final List ingredients;
  final List<fav.Ingredients> ingredients;
  const FavoriteState({this.image, this.ingredients = const []});
}

class TestInitial extends FavoriteState {}

class FavoriteImage extends FavoriteState {
  const FavoriteImage(String? _image) : super(image: _image);
}

class FavoriteIngredients extends FavoriteState {
  const FavoriteIngredients(List<fav.Ingredients> ingredients) : super(ingredients: ingredients);
}
