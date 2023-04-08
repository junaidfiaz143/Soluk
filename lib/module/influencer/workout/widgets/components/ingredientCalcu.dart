import 'package:app/module/influencer/workout/bloc/favorite_ingre_bloc/favorite_cubit.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientCalcu extends StatelessWidget {
  const IngredientCalcu({Key? key,required this.calcuIngre}) : super(key: key);
  final Function(List<int>) calcuIngre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          int calories = 0;
          int protiens = 0;
          int fats = 0;
          int carbs = 0;
          for (var element in state.ingredients) {
            calories = calories + (element.calories ?? 0);
            protiens = protiens + (element.proteins ?? 0);
            fats = fats + (element.fats ?? 0);
            carbs = carbs + (element.carbs ?? 0);
          }
          calcuIngre([calories,protiens,fats,carbs]);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              item(
                  context,
                  AppLocalisation.getTranslated(context, 'LKCalories'),
                  '$calories'),
              item(context, AppLocalisation.getTranslated(context, 'LKFats'),
                  '$fats'),
              item(
                  context,
                  AppLocalisation.getTranslated(context, 'LKProtiens'),
                  '$protiens'),
              item(context, AppLocalisation.getTranslated(context, 'LKCarbs'),
                  '$carbs'),
            ],
          );
        },
      ),
    );
  }

  item(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: subTitleTextStyle(context)?.copyWith(fontSize: 17),
        ),
        SB_BY_4,
        Text(
          title,
          style: labelTextStyle(context)?.copyWith(fontSize: 15),
        ),
        SB_Half,
      ],
    );
  }
}
