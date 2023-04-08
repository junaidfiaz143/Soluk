// import 'package:app/module/influencer/workout/widgets/components/ingredients.dart';
import 'package:app/module/user/models/meal/meal_dashboard.dart' as fav;
import 'package:app/utils/pickers.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../widgets/add_favorite_meal.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(TestInitial());

  addIngredients(fav.Ingredients ingre) {
    emit(FavoriteIngredients([...state.ingredients, ingre]));
  }

  addUpdateIngredients(List<fav.Ingredients> ingredients) {
    emit(FavoriteIngredients(ingredients));
  }

  clearIngredients() {
    emit(const FavoriteIngredients([]));
  }

  updateIngredients(fav.Ingredients item, fav.Ingredients ingre) {
    List ingredients = state.ingredients;
    int index = ingredients.indexOf(item);
    ingredients[index] = ingre;
    emit(FavoriteIngredients([...ingredients]));
  }

  updateIngredientsCount(
      int count, bool isAdd, List<IngredientInitialValue> ingredientsquan) {
    List<fav.Ingredients> ingredients = state.ingredients;
    for (int a = 0; a < (ingredients.length); a++) {
      if (isAdd) {
        ingredients.elementAt(a).carbs =
            ingredients.elementAt(a).carbs! + ingredientsquan[a].initCarbs!;
        ingredients.elementAt(a).fats =
            ingredients.elementAt(a).fats! + ingredientsquan[a].initFats!;
        ingredients.elementAt(a).proteins =
            ingredients.elementAt(a).proteins! + ingredientsquan[a].initPro!;
        ingredients.elementAt(a).calories =
            ingredients.elementAt(a).calories! + ingredientsquan[a].initCal!;
        ingredients.elementAt(a).quantity =
            ingredients.elementAt(a).quantity! + ingredientsquan[a].initQua!;
      } else {
        ingredients.elementAt(a).carbs =
            ingredients.elementAt(a).carbs! - ingredientsquan[a].initCarbs!;
        ingredients.elementAt(a).fats =
            ingredients.elementAt(a).fats! - ingredientsquan[a].initFats!;
        ingredients.elementAt(a).proteins =
            ingredients.elementAt(a).proteins! - ingredientsquan[a].initPro!;
        ingredients.elementAt(a).calories =
            ingredients.elementAt(a).calories! - ingredientsquan[a].initCal!;
        ingredients.elementAt(a).quantity =
            ingredients.elementAt(a).quantity! - ingredientsquan[a].initQua!;
      }
    }
    // ingredientsquan.forEach((element) {
    //   ingredients.forEach((e) {
    //
    //     }
    //   });
    // });

    emit(FavoriteIngredients([...ingredients]));
  }

  removeImage() {
    emit(const FavoriteImage(null));
  }

  deleteIngre(fav.Ingredients item) {
    List ingredients = state.ingredients;
    ingredients.remove(item);
    emit(FavoriteIngredients([...ingredients]));
  }

  pickImage(String source) async {
    String? path =
        await Pickers.instance.pickImage(source: source, quality: 50);
    if (path != null) {
      emit(FavoriteImage(path));
    }
  }
}
