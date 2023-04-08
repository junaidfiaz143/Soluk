import 'package:app/module/user/meals/bloc/meal_cubit.dart';
import 'package:app/module/user/meals/view/meals_list_view.dart';
import 'package:app/module/user/meals/widgets/meals_day_selection_widget.dart';
import 'package:app/module/user/meals/widgets/meals_edit_widget.dart';
import 'package:app/module/user/models/meal/meal_dashboard.dart';
import 'package:app/module/user/user_info/view/review_screen.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/res/color.dart';
import 'package:app/utils/nav_router.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../res/constants.dart';
import '../../../../res/globals.dart';
import '../../../../utils/enums.dart';
import '../../../influencer/workout/widgets/insight_tile.dart';
import '../../user_info/cubit/user_info_cubit.dart';
import '../widgets/meal_info_card.dart';

class MealsView extends StatefulWidget {
  const MealsView({Key? key}) : super(key: key);

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  String? calorieRange;
  String? calorieAlertMessage = 'Your Calorie Range!';
  int? selectedDay;
  int? currentDay;
  bool? isOneDayMeal;

  /// 0->grey
  /// 1->red
  /// 2->yellow
  int calorieIsInRange = 0;
  MealPerDay? currentMeal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCalorieRange();
    getCurrentDayMeal();
    checkOneDayMeal();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {});
    });
  }

  getCurrentDayMeal() async {
    MealCubit mealCubit = BlocProvider.of(context);
    selectedDay = await mealCubit.isNeedToUpdateMealInfo();
    currentDay = selectedDay;
    mealCubit.getMealInfo(selectedDay ?? 0);
    setState(() {});
  }

  Future<void> checkOneDayMeal() async {
    isOneDayMeal = await LocalStore.getData(MEAL_DAYS_COUNT);
  }

  getCalorieRange() async {
    calorieRange = await LocalStore.getData(USER_CALORIE_RANGE);
    if (calorieRange == null) {
      await fetchUserInfoAPI();
    }
    setState(() {});
  }

  Future fetchUserInfoAPI() async {
    String userId = await LocalStore.getData(PREFS_USERID);
    await context.read<UserInfoCubit>().fetchUserInfo(userId);
    print('user id is :: $userId');
    calorieRange = await LocalStore.getData(USER_CALORIE_RANGE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Meals',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MealsDaySelectionWidget(
              selectedIndex: selectedDay == 0 ? 0 : ((selectedDay ?? 1) - 1),
              currentDay: currentDay == 0 ? 0 : ((currentDay ?? 1) - 1),
              dayChangeCallback: (day) {
                if (isOneDayMeal == true) {
                  SolukToast.showToast('Day $day is locked');
                } else {
                  BlocProvider.of<MealCubit>(context).currentDay = day;
                  setState(() {
                    selectedDay = day;
                  });
                  BlocProvider.of<MealCubit>(context)
                      .getMealInfo(selectedDay ?? 0);
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          calorieRange != null
                              ? TextView('${calorieRange}',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: PRIMARY_COLOR)
                              : SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      BlocBuilder<MealCubit, MealState>(
                        builder: (context, state) {
                          if (state is MealInfoLoaded) {
                            int cal = 0, pro = 0, fats = 0, carbs = 0;
                            currentMeal = state.mealDashboard;

                            state.mealDashboard.breakfast?.forEach((element) {
                              cal = cal + (element.calories ?? 0);
                              pro = pro + (element.proteins ?? 0);
                              fats = fats + (element.fats ?? 0);
                              carbs = carbs + (element.carbs ?? 0);
                            });
                            state.mealDashboard.mainMeal?.forEach((element) {
                              cal = cal + (element.calories ?? 0);
                              pro = pro + (element.proteins ?? 0);
                              fats = fats + (element.fats ?? 0);
                              carbs = carbs + (element.carbs ?? 0);
                            });
                            // state.mealDashboard.lunch?.forEach((element) {
                            //   cal = cal + (element.calories ?? 0);
                            //   pro = pro + (element.proteins ?? 0);
                            //   fats = fats + (element.fats ?? 0);
                            //   carbs = carbs + (element.carbs ?? 0);
                            // });
                            state.mealDashboard.snack?.forEach((element) {
                              cal = cal + (element.calories ?? 0);
                              pro = pro + (element.proteins ?? 0);
                              fats = fats + (element.fats ?? 0);
                              carbs = carbs + (element.carbs ?? 0);
                            });
                            // state.mealDashboard.dinner?.forEach((element) {
                            //   cal = cal + (element.calories ?? 0);
                            //   pro = pro + (element.proteins ?? 0);
                            //   fats = fats + (element.fats ?? 0);
                            //   carbs = carbs + (element.carbs ?? 0);
                            // });
                            if (calorieRange?.contains('-') == true) {
                              int calorieLowerLimit =
                                  int.parse(calorieRange?.split('-')[0] ?? '0');
                              int calorieUpperLimit =
                                  int.parse(calorieRange?.split('-')[1] ?? '0');
                              if (cal < calorieLowerLimit) {
                                calorieAlertMessage =
                                    "Your day Calorie intake is lower\n than above range";
                                calorieIsInRange = 1;
                              } else if (cal > calorieUpperLimit) {
                                calorieAlertMessage =
                                    "Your day Calorie intake is higher\n than above range";
                                calorieIsInRange = 2;
                              } else {
                                calorieAlertMessage = 'Your Calorie Range!';
                                calorieIsInRange = 0;
                              }
                            }

                            return Column(
                              children: [
                                TextView(
                                  '$calorieAlertMessage',
                                  color: calorieIsInRange == 0
                                      ? Colors.grey
                                      : (calorieIsInRange == 1
                                          ? Colors.red
                                          : Colors.orangeAccent),
                                ),
                                SB_1H,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MealInfoCard(
                                      title: '${cal}g',
                                      subTitle: 'Calories',
                                    ),
                                    MealInfoCard(
                                      title: '${pro}g',
                                      subTitle: 'Proteins',
                                    ),
                                    MealInfoCard(
                                      title: '${fats}g',
                                      subTitle: 'Fats',
                                    ),
                                    MealInfoCard(
                                      title: '${carbs}g',
                                      subTitle: 'Carbs',
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                  MealsEditWidget(
                    onTap: () {
                      NavRouter.push(
                          context, ReviewScreen(isOpenedFromMeal: true));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  InsightTile(
                    height: 108,
                    title: 'Breakfast',
                    image: 'assets/images/ic_breakfast.jpg',
                    callback: () async {
                      await NavRouter.push(
                          context,
                          MealsListView(
                            mealPerDay: currentMeal?.breakfast,
                            mealType: MealType.Breakfast.name,
                          ));
                      setState(() {});
                    },
                  ),
                  // InsightTile(
                  //   height: 108,
                  //   title: 'Lunch',
                  //   image: 'assets/images/ic_lunch.jpg',
                  //   callback: () async {
                  //     await NavRouter.push(
                  //         context,
                  //         MealsListView(
                  //           mealPerDay: currentMeal?.lunch,
                  //           mealType: MealType.Lunch.name,
                  //         ));
                  //     setState(() {});
                  //   },
                  // ),
                  InsightTile(
                    height: 108,
                    title: 'Snack',
                    image: 'assets/images/ic_snack.jpg',
                    callback: () async {
                      await NavRouter.push(
                          context,
                          MealsListView(
                            mealPerDay: currentMeal?.snack,
                            mealType: MealType.Snack.name,
                          ));
                      setState(() {});
                    },
                  ),
                  // InsightTile(
                  //   height: 108,
                  //   title: 'Dinner',
                  //   image: 'assets/images/ic_dinner.jpg',
                  //   callback: () async {
                  //     await NavRouter.push(
                  //         context,
                  //         MealsListView(
                  //           mealPerDay: currentMeal?.dinner,
                  //           mealType: MealType.Dinner.name,
                  //         ));
                  //     setState(() {});
                  //   },
                  // ),
                  InsightTile(
                    height: 108,
                    title: 'Main Meal',
                    image: 'assets/images/ic_dinner.jpg',
                    callback: () async {
                      await NavRouter.push(
                          context,
                          MealsListView(
                            mealPerDay: currentMeal?.mainMeal,
                            mealType: MealType.MainMeal.name,
                          ));
                      setState(() {});
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
