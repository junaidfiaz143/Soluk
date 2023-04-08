import 'dart:io';

import 'package:app/module/user/meals/bloc/dashboard_meals_bloc.dart';
import 'package:app/module/user/models/meals/dashboard_meals_model.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../../res/constants.dart';
import '../../../../../../res/globals.dart';
import '../../../../../../services/localisation.dart';
import '../../../../../influencer/more/widget/custom_alert_dialog.dart';
import '../../../../../influencer/widgets/empty_screen.dart';
import '../../../../../influencer/widgets/saluk_gradient_button.dart';
import '../../../bloc/meal_cubit.dart';
import '../../../widgets/custom_meal_counter_widget.dart';
import '../../../widgets/meal_card.dart';

class InfluencerMealsTab extends StatefulWidget {
  const InfluencerMealsTab({Key? key, required this.mealIds}) : super(key: key);
  final List<int> mealIds;

  @override
  State<InfluencerMealsTab> createState() => _InfluencerMealsTabState();
}

class _InfluencerMealsTabState extends State<InfluencerMealsTab> {
  List<int> selectedMealsList = [];
  late DashboardMealsBloc _dashboardMealsBloc;

  @override
  void initState() {
    super.initState();
    _dashboardMealsBloc = BlocProvider.of(context);
    _dashboardMealsBloc.getInfluencerMealsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView('Influencer Meals',
                  fontSize: 14, fontWeight: FontWeight.w500),
              SizedBox(height: 10),
              TextView(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                fontSize: 14,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<DashboardMealsModel?>(
              stream: _dashboardMealsBloc.influencerMealsStream,
              initialData: null,
              builder: (context, snapshot) {
                return snapshot.data != null
                    ? ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        itemCount:
                            snapshot.data?.responseDetails?.data?.length ?? 0,
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
                              isSelectionAvailable: !widget.mealIds.contains(
                                  snapshot
                                      .data?.responseDetails?.data?[index].id),
                              isSelected: selectedMealsList.contains(index),
                              meal:
                                  snapshot.data?.responseDetails?.data?[index],
                            ),
                          );
                        },
                      )
                    : EmptyScreen(
                        title: "No Meals Found",
                        callback: () {},
                        hideAddButton: true,
                      );
              }),
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
                      .customizedMealInfluencerTabModel!
                      .responseDetails!
                      .data![element]);
                }
                Navigator.push(
                  context,
                  SlideUpTransparentRoute(
                    enterWidget: CustomAlertDialog(
                      sigmaX: 0,
                      sigmaY: 0,
                      contentWidget: CustomMealCounter(
                        meals: data,
                        onDismiss: () {},
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
                            'Add ${_dashboardMealsBloc.selectedMealType} Meals',
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
