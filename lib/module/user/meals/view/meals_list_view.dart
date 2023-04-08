import 'package:app/module/user/meals/widgets/meals_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../animations/slide_up_transparent_animation.dart';
import '../../../../res/constants.dart';
import '../../../../res/globals.dart';
import '../../../../services/localisation.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/nav_router.dart';
import '../../../influencer/more/widget/custom_alert_dialog.dart';
import '../../../influencer/widgets/reward_popup.dart';
import '../../../influencer/widgets/saluk_gradient_button.dart';
import '../../models/meals/dashboard_meals_model.dart';
import '../../widgets/text_view.dart';
import '../../widgets/top_appbar_row.dart';
import '../bloc/dashboard_meals_bloc.dart';
import '../bloc/meal_cubit.dart';
import '../widgets/meal_card.dart';
import 'customize_meal/customize_meal_view.dart';
import 'meals_details_view.dart';

class MealsListView extends StatefulWidget {
  const MealsListView(
      {Key? key, required this.mealPerDay, required this.mealType})
      : super(key: key);
  final List<Meal?>? mealPerDay;
  final String? mealType;

  @override
  State<MealsListView> createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView> {
  @override
  void initState() {
    BlocProvider.of<DashboardMealsBloc>(context).selectedMealType =
        widget.mealType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            TopAppbarRow(
              title:
                  '${(widget.mealType == MealType.MainMeal.name) ? "Main" : widget.mealType} Meals',
              actionWidget: MealsEditWidget(onTap: () {
                openCustomizeMealScreen(widget.mealType);
              }),
            ),
            GestureDetector(
              onTap: () {
                openCustomizeMealScreen(widget.mealType);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child:
                      TextView('Customize\nMeal', textAlign: TextAlign.center),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: (widget.mealPerDay?.isEmpty ?? true) == false
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: widget.mealPerDay?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              NavRouter.push(
                                  context,
                                  MealDetailsView(
                                    mealItem:
                                        widget.mealPerDay?.elementAt(index),
                                    mealType: widget.mealType,
                                    isForCounting: false,
                                  ));
                            },
                            child: MealCard(
                              isDeleteEnabled: true,
                              meal: widget.mealPerDay?.elementAt(index),
                              onDelete: (ctx, meal) {
                                navigatorKey.currentState?.push(
                                  SlideUpTransparentRoute(
                                    enterWidget: CustomAlertDialog(
                                      sigmaX: 0,
                                      sigmaY: 0,
                                      contentWidget: RewardPopUp(
                                        iconPath:
                                            'assets/images/ic_dialog_delete.png',
                                        title: AppLocalisation.getTranslated(
                                            context, LKDelete),
                                        content:
                                            'Do you want to delete this meal?',
                                        actionButtons: Row(
                                          children: [
                                            SizedBox(
                                              width:
                                                  defaultSize.screenWidth * .37,
                                              child: SalukGradientButton(
                                                title: AppLocalisation
                                                    .getTranslated(
                                                        context, LKYes),
                                                onPressed: () async {
                                                  MealCubit mealCubit =
                                                      BlocProvider.of(context);

                                                  await mealCubit.deletionOfMeal(
                                                      meals: meal,
                                                      mealType: BlocProvider.of<
                                                                  DashboardMealsBloc>(
                                                              context)
                                                          .selectedMealType);

                                                  widget.mealPerDay
                                                      ?.removeAt(index);
                                                  setState(() {});
                                                  mealCubit.getMealInfo(
                                                      mealCubit.currentDay);
                                                  Navigator.pop(context);
                                                },
                                                buttonHeight: HEIGHT_3,
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width:
                                                  defaultSize.screenWidth * .37,
                                              child: SalukGradientButton(
                                                title: AppLocalisation
                                                    .getTranslated(
                                                        context, LKNo),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                buttonHeight: HEIGHT_3,
                                                linearGradient:
                                                    const LinearGradient(
                                                  colors: [
                                                    Colors.black,
                                                    Colors.black,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    routeName: CustomAlertDialog.id,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('No meals found',
                                style: subTitleTextStyle(context)),
                            const SizedBox(height: 14),
                            GestureDetector(
                                onTap: () {
                                  openCustomizeMealScreen(widget.mealType);
                                },
                                child: SvgPicture.asset(PLUS_ICON)),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ))
          ],
        ));
  }

  openCustomizeMealScreen(String? mealType) {
    List<int>? mealIds = widget.mealPerDay?.map((e) => e?.id ?? 0).toList();
    NavRouter.push(
        context,
        CustomizeMealView(
          mealType: widget.mealType,
          mealIds: mealIds,
        ));
  }
}
