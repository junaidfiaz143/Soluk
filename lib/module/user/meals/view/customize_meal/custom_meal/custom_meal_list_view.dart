import 'dart:io';

import 'package:app/module/user/models/meals/dashboard_meals_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../../res/constants.dart';
import '../../../../../../res/globals.dart';
import '../../../../../../services/localisation.dart';
import '../../../../../influencer/more/widget/custom_alert_dialog.dart';
import '../../../../../influencer/widgets/saluk_gradient_button.dart';
import '../../../bloc/dashboard_meals_bloc.dart';
import '../../../bloc/meal_cubit.dart';
import '../../../widgets/custom_meal_counter_widget.dart';
import '../../../widgets/meal_card.dart';

class CustomMealsListView extends StatefulWidget {
  const CustomMealsListView(
      {Key? key, required this.meals, required this.mealIds})
      : super(key: key);
  final List<Meal> meals;
  final List<int> mealIds;

  @override
  State<CustomMealsListView> createState() => _CustomMealsListViewState();
}

class _CustomMealsListViewState extends State<CustomMealsListView> {
  List<int> selectedMealsList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            itemCount: widget.meals.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedMealsList.contains(index)) {
                      selectedMealsList.remove(index);
                      return;
                    }
                    selectedMealsList.add(index);
                  });
                },
                child: MealCard(
                  isDeleteEnabled: false,
                  isSelectionAvailable:
                      !widget.mealIds.contains(widget.meals[index].id),
                  isSelected: selectedMealsList.contains(index),
                  meal: widget.meals[index],
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20) +
              EdgeInsets.only(bottom: Platform.isIOS ? 12 : 0),
          color: Colors.white,
          child: SizedBox(
            height: 50,
            child: SalukGradientButton(
              dim: selectedMealsList.isEmpty,
              title: 'ADD MEAL',
              style: buttonTextStyle(context)
                  ?.copyWith(fontWeight: FontWeight.w500),
              onPressed: () async {
                List<Meal>? data = [];
                if (selectedMealsList.isEmpty) return;
                for (int element in selectedMealsList) {
                  data.add(BlocProvider.of<DashboardMealsBloc>(context)
                      .customMealModel!
                      .responseDetails!
                      .data![element]);
                }

                await Navigator.push(
                  context,
                  SlideUpTransparentRoute(
                    enterWidget: CustomAlertDialog(
                      sigmaX: 0,
                      sigmaY: 0,
                      contentWidget: CustomMealCounter(
                        meals: data,
                        actionButtons: SizedBox(
                          width: defaultSize.screenWidth * .74,
                          child: SalukGradientButton(
                            title:
                                AppLocalisation.getTranslated(context, LKDone),
                            onPressed: () async {
                              Navigator.pop(context, true);
                            },
                            buttonHeight: HEIGHT_3,
                          ),
                        ),
                        title:
                            'Add ${BlocProvider.of<DashboardMealsBloc>(context).selectedMealType} Meals',
                      ),
                    ),
                    routeName: CustomAlertDialog.id,
                  ),
                ).then((isDone) async {
                  if (isDone == true) {
                    MealCubit mealCubit = BlocProvider.of<MealCubit>(context);

                    await mealCubit.customizationOfMeal(
                        meals: data,
                        mealType: BlocProvider.of<DashboardMealsBloc>(context)
                            .selectedMealType);

                    await mealCubit.getMealInfo(mealCubit.currentDay);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                });
              },
              buttonHeight: HEIGHT_2 + 5,
            ),
          ),
        ),
      ],
    );
  }
}
