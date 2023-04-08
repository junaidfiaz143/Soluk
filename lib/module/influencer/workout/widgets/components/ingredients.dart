import 'package:app/module/influencer/workout/bloc/favorite_ingre_bloc/favorite_cubit.dart';
import 'package:app/module/influencer/workout/widgets/components/pop_ingredients_dialog.dart';
import 'package:app/module/user/models/meal/meal_dashboard.dart' as fav;
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../user/widgets/text_view.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({Key? key}) : super(key: key);

  // final List<IngredientInitialValue>? initValues;

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  Widget build(BuildContext context) {
    final _favoriteBloc =
        BlocProvider.of<FavoriteCubit>(context, listen: false);

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      buildWhen: (previous, current) =>
          previous.ingredients != current.ingredients,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state.ingredients.isEmpty
                ? GestureDetector(
                    onTap: () => popIngredientDialog(context,
                        AppLocalisation.getTranslated(context, 'LKIngredients'),
                        onSave: (name, protien, quan, calo, fat, carbs, stand) {
                          fav.Ingredients ing = fav.Ingredients(
                          name: name,
                          calories: int.parse(calo),
                          carbs: int.parse(carbs),
                          proteins: int.parse(protien),
                          fats: int.parse(fat),
                          quantity: int.parse(quan),
                          type: stand);
                      // widget.initValues?.add(new IngredientInitialValue(
                      //     ing.fats,
                      //     ing.calories,
                      //     ing.carbs,
                      //     ing.proteins,
                      //     ing.quantity));
                      _favoriteBloc.addIngredients(ing);
                    }),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalisation.getTranslated(
                              context, 'LKIngredients'),
                          style: subTitleTextStyle(context)
                              ?.copyWith(fontSize: 15),
                        ),
                        SB_Half,
                        addIngredientsBtn(defaultSize.screenWidth, 45),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () => popIngredientDialog(context,
                        AppLocalisation.getTranslated(context, 'LKIngredients'),
                        onSave: (name, protien, quan, calo, fat, carbs, stand) {
                          fav.Ingredients ing = fav.Ingredients(
                          name: name,
                          calories: int.parse(calo),
                          carbs: int.parse(carbs),
                          proteins: int.parse(protien),
                          fats: int.parse(fat),
                          quantity: int.parse(quan),
                          type: stand);
                      // widget.initValues?.add(new IngredientInitialValue(
                      //     ing.fats,
                      //     ing.calories,
                      //     ing.carbs,
                      //     ing.proteins,
                      //     ing.quantity));
                      _favoriteBloc.addIngredients(ing);
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalisation.getTranslated(
                              context, 'LKIngredients'),
                          style: subTitleTextStyle(context)
                              ?.copyWith(fontSize: 15),
                        ),
                        SB_Half,
                        addIngredientsBtn(180, 45),
                      ],
                    ),
                  ),
            if (state.ingredients.isNotEmpty) ...[
              SB_1H,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.ingredients.length,
                    itemBuilder: (_, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.ingredients[index].name}',
                            style: subTitleTextStyle(context)
                                ?.copyWith(fontSize: 15),
                          ),
                          TextView(
                              'Qty - ${state.ingredients[index].quantity?.toInt()} ${state.ingredients[index].type}',
                              color: Colors.grey),
                          SB_Half,
                          Row(children: [
                            item(
                                context,
                                AppLocalisation.getTranslated(
                                    context, 'LKCalories'),
                                '${state.ingredients[index].calories}'),
                            SB_1W,
                            item(
                                context,
                                AppLocalisation.getTranslated(
                                    context, 'LKProtiens'),
                                '${state.ingredients[index].proteins}'),
                            SB_1W,
                            item(
                                context,
                                AppLocalisation.getTranslated(
                                    context, 'LKFats'),
                                '${state.ingredients[index].fats}'),
                            SB_1W,
                            item(
                                context,
                                AppLocalisation.getTranslated(
                                    context, 'LKCarbs'),
                                '${state.ingredients[index].carbs}'),
                            Expanded(child: Container()),
                            IconButton(
                                onPressed: () => popIngredientDialog(
                                        context,
                                        AppLocalisation.getTranslated(
                                            context, 'LKIngredients'),
                                        item: state.ingredients[index], onSave:
                                            (name, protien, quan, calo, fat,
                                                carbs, stand) {
                                      fav.Ingredients ing = fav.Ingredients(
                                          name: name,
                                          calories: int.parse(calo),
                                          carbs: int.parse(carbs),
                                          proteins: int.parse(protien),
                                          fats: int.parse(fat),
                                          quantity: int.parse(quan),
                                          type: stand);
                                      _favoriteBloc.updateIngredients(
                                          state.ingredients[index], ing);
                                    }),
                                icon: const Icon(
                                  Icons.edit,
                                  color: PRIMARY_COLOR,
                                )),
                            IconButton(
                                onPressed: () {
                                  _favoriteBloc
                                      .deleteIngre(state.ingredients[index]);
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.red,
                                ))
                          ]),
                        ],
                      );
                    }),
              )
            ]
          ],
        );
      },
    );
  }

  item(BuildContext context, String title, String value) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: subTitleTextStyle(context)?.copyWith(fontSize: 17),
        ),
        SB_BY_4,
        Text(
          title,
          style: labelTextStyle(context)?.copyWith(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        SB_Half,
      ],
    );
  }

  addIngredientsBtn(double width, double height) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: defaultSize.screenWidth * .003,
            color: PRIMARY_COLOR,
          ),
          color: Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: defaultSize.screenWidth * .03,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                  color: PRIMARY_COLOR, shape: BoxShape.circle),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 17,
              ),
            ),
            SB_1W,
            Text(
              AppLocalisation.getTranslated(context, 'LKAddIngredients'),
              style: labelTextStyle(context)
                  ?.copyWith(color: PRIMARY_COLOR, fontSize: 15),
            ),
          ],
        ));
  }
}
