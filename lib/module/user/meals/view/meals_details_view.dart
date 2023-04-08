import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/user/models/meal/meal_dashboard.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/color.dart';
import '../../../../utils/nav_router.dart';
import '../../../influencer/widgets/info_dialog_box.dart';
import '../../../influencer/workout/widgets/add_favorite_meal.dart';
import '../../models/meals/dashboard_meals_model.dart';
import '../../profile/local_storage/grocery_local.dart';
import '../../profile/local_storage/grocery_local.dart';
import '../bloc/dashboard_meals_bloc.dart';
import '../widgets/meal_info_card.dart';

class MealDetailsView extends StatefulWidget {
  static const id = 'ProgramDetail';

  const MealDetailsView(
      {Key? key, this.mealItem, this.mealType, required this.isForCounting})
      : super(key: key);
  final Meal? mealItem;
  final String? mealType;
  final bool isForCounting;

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  // bool _switchValue = true;

  List<IngredientInitialValue> initValues = [];
  int numberOfRounds = 1;

  @override
  void initState() {
    widget.mealItem?.carbs = 0;
    widget.mealItem?.proteins = 0;
    widget.mealItem?.calories = 0;
    widget.mealItem?.fats = 0;
    widget.mealItem?.ingredients?.forEach((element) {
      widget.mealItem?.carbs = widget.mealItem!.carbs! + element.carbs!;
      widget.mealItem?.proteins =
          widget.mealItem!.proteins! + element.proteins!;
      widget.mealItem?.calories =
          widget.mealItem!.calories! + element.calories!;
      widget.mealItem?.fats = widget.mealItem!.fats! + element.fats!;
    });
    if (widget.isForCounting) if ((widget.mealItem?.ingredients?.length ?? 0) >
        0) {
      widget.mealItem?.ingredients?.forEach((element) {
        initValues.add(new IngredientInitialValue(
            element.fats,
            element.calories,
            element.carbs,
            element.proteins,
            element.quantity));
      });
    }
    super.initState();
  }

  bool? revertIngredientChanges() {
    try {
      if ((widget.mealItem?.ingredients?.length ?? 0) > 0) {
        for (int a = 0; a < (widget.mealItem?.ingredients?.length ?? 0); a++) {
          widget.mealItem?.ingredients?[a].fats = initValues[a].initFats;
          widget.mealItem?.ingredients?[a].proteins = initValues[a].initPro;
          widget.mealItem?.ingredients?[a].calories = initValues[a].initCal;
          widget.mealItem?.ingredients?[a].carbs = initValues[a].initCarbs;
          widget.mealItem?.ingredients?[a].quantity = initValues[a].initQua;
        }
      }
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.isForCounting) return true;
        revertIngredientChanges();
        return true;
      },
      child: Scaffold(
          body:
              // BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
              //   listener: (context, state) {
              //     // if (state is SubscribersListLoadingState) {
              //     //   Future.delayed(const Duration(seconds: 2), () {
              //     //     _workoutProgramBloc.add(SubscribersListLoadedEvent());
              //     //   });
              //     // }
              //   },
              //   builder: (context, state) {
              //     // if (state is SubscribersListLoadingState) {
              //     //   return const Center(
              //     //     child: CircularProgressIndicator(
              //     //       color: Colors.grey,
              //     //     ),
              //     //   );
              //     // }
              //     // if (state is SubscribersListLoadedState) {
              //       return
              Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: HEIGHT_5 * 3.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.mealItem?.imageUrl ??
                        'https://picsum.photos/200'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  SB_1H,
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SolukBackButton(
                          callback: () {
                            if (!widget.isForCounting) return;
                            revertIngredientChanges();
                          },
                        ),
                        Text(
                          '${widget.mealType} Meal',
                          style: subTitleTextStyle(context)?.copyWith(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        SB_5W,
                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //     height: defaultSize.screenWidth * .09,
                        //     width: defaultSize.screenWidth * .09,
                        //     decoration:const BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.only(
                        //         topRight: Radius.circular(10.0),
                        //         topLeft: Radius.circular(10.0),
                        //         bottomLeft: Radius.circular(10.0),
                        //         bottomRight: Radius.circular(10.0),
                        //       ),
                        //     ),
                        //     child: Center(
                        //       // child: Icon(
                        //       //   Icons.delete_outline_outlined,
                        //       //   color: Colors.red,
                        //       //   size: defaultSize.screenWidth * .05,
                        //       // ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: HEIGHT_5 * 1.5,
                  ),
                  Container(
                    width: double.maxFinite,
                    height: defaultSize.screenHeight * 0.7,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(
                                      'Title',
                                      maxLines: 1,
                                      style: hintTextStyle(context)?.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      widget.mealItem?.title ?? 'N/A',
                                      maxLines: 1,
                                      style: hintTextStyle(context)?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                if (!widget.isForCounting)
                                  InkWell(
                                    onTap: () {
                                      var route = MaterialPageRoute(
                                          builder: (context) => AddFavoriteMeal(
                                                favItem: widget.mealItem,
                                              ));
                                      Navigator.push(context, route);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (_) =>
                                      //       AddWorkoutProgram(
                                      //             isEditScreen: true,
                                      //             title:
                                      //                 'Bodywieght for Uper Boday',
                                      //             description:
                                      //                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam dui nascetur vulputate vehicula odio vestibulum tellus scelerisque. Id quam sit ridiculus arcu arcu, egestas purus. Morbi fermentum sollicitudin sagittis gravida tempor, risus. Nunc dictum pellentesque feugiat sed vitae scelerisque risus, elementum.',
                                      //             completionBadge: '',
                                      //             difficultyLevel: '',
                                      //             programType: '',
                                      //           )),
                                      // );
                                    },
                                    child: Container(
                                      height: defaultSize.screenWidth * .09,
                                      width: defaultSize.screenWidth * .09,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                          size: defaultSize.screenWidth * .05,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            SB_1H,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MealInfoCard(
                                  title: '${widget.mealItem?.calories}',
                                  subTitle: 'Calories',
                                ),
                                MealInfoCard(
                                  title: '${widget.mealItem?.proteins}',
                                  subTitle: 'Proteins',
                                ),
                                MealInfoCard(
                                  title: '${widget.mealItem?.fats}',
                                  subTitle: 'Fats',
                                ),
                                MealInfoCard(
                                  title: '${widget.mealItem?.carbs}',
                                  subTitle: 'Carbs',
                                ),
                              ],
                            ),
                            SB_1H,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    TextView('Meal Type',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                    TextView(widget.mealItem?.mealType ?? 'N/A',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                                Column(
                                  children: [
                                    TextView('Meal Classification',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                    TextView(
                                        widget.mealItem?.mealLevel ?? 'N/A',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                              ],
                            ),
                            if (widget.isForCounting) ...{
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Meals for Number of person',
                                style: subTitleTextStyle(context)
                                    ?.copyWith(fontSize: 15),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: WIDTH_6 * 1.8,
                                    height: HEIGHT_3,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0)),
                                      color: SCAFFOLD_BACKGROUND_COLOR,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: WIDTH_5 * 1.1,
                                          height: HEIGHT_3,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            color: PRIMARY_COLOR,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              if (numberOfRounds > 1) {
                                                numberOfRounds =
                                                    numberOfRounds - 1;
                                                updateIngredientsCount(
                                                    numberOfRounds,
                                                    false,
                                                    initValues);

                                                setState(() {});
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                '-',
                                                style: labelTextStyle(context)
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${numberOfRounds}',
                                          style:
                                              labelTextStyle(context)?.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Container(
                                          width: WIDTH_5 * 1.1,
                                          height: HEIGHT_3,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            color: PRIMARY_COLOR,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              numberOfRounds =
                                                  numberOfRounds + 1;
                                              updateIngredientsCount(
                                                  numberOfRounds,
                                                  true,
                                                  initValues);
                                              setState(() {});
                                            },
                                            child: Center(
                                              child: Text(
                                                '+',
                                                style: labelTextStyle(context)
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            },
                            Visibility(
                              visible:
                                  !(widget.mealItem?.ingredients?.isEmpty ??
                                      true),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SB_1H,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ingredients',
                                        maxLines: 1,
                                        style: hintTextStyle(context)?.copyWith(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                      if (!widget.isForCounting)
                                        TextButton(
                                            onPressed: () {
                                              NavRouter.push(
                                                  context,
                                                  MealDetailsView(
                                                    mealItem: widget.mealItem,
                                                    mealType: widget.mealType,
                                                    isForCounting: true,
                                                  ));
                                            },
                                            child: Text("Prepare Meals"))
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF9F9F9),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        widget.mealItem?.ingredients?.length ??
                                            0,
                                        (index) => MealsDetailsIngredientsTile(
                                          ingredient: widget
                                              .mealItem?.ingredients?[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: (widget.mealItem?.method != ''),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SB_1H,
                                  Text(
                                    'Method & Instruction',
                                    maxLines: 1,
                                    style: hintTextStyle(context)?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.mealItem?.method ?? 'N/A',
                                    style: hintTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SB_1H,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // SingleChildScrollView(
              //   physics: const ScrollPhysics(),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.only(top: 2.h),
              //         child: WorkoutProgramTile(
              //           image: WORKOUT_COVER2,
              //           title: "Workout Title",
              //           description: "Body Workout Programs",
              //           callback: () {},
              //         ),
              //       ),
              //       Text(
              //         AppLocalisation.getTranslated(
              //             context, LKWorkoutWeek),
              //         style: subTitleTextStyle(context)?.copyWith(
              //           color: Colors.black,
              //           fontSize: 18.sp,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      )
          // ;
          // }
          // return Container();
          // },
          // ),
          ),
    );
  }

  updateIngredientsCount(
      int count, bool isAdd, List<IngredientInitialValue> ingredientsquan) {
    List<Ingredients> ingredients = widget.mealItem?.ingredients ?? [];
    for (int a = 0; a < (ingredients.length); a++) {
      widget.mealItem?.carbs = 0;
      widget.mealItem?.proteins = 0;
      widget.mealItem?.calories = 0;
      widget.mealItem?.fats = 0;
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
      widget.mealItem?.carbs =
          widget.mealItem!.carbs! + (ingredients.elementAt(a).carbs ?? 0);
      widget.mealItem?.proteins =
          widget.mealItem!.proteins! + (ingredients.elementAt(a).proteins ?? 0);
      ;
      widget.mealItem?.calories =
          widget.mealItem!.calories! + (ingredients.elementAt(a).calories ?? 0);
      ;
      widget.mealItem?.fats =
          widget.mealItem!.fats! + (ingredients.elementAt(a).fats ?? 0);
      ;
    }
    setState(() {});
  }
}

class MealsDetailsIngredientsTile extends StatelessWidget {
  const MealsDetailsIngredientsTile({
    Key? key,
    required this.ingredient,
  }) : super(key: key);
  final Ingredients? ingredient;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 14,
            ),
            TextView(
              ingredient?.name ?? 'N/A',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 4),
            TextView(
                'Qty - ${ingredient?.quantity?.toInt()} ${ingredient?.type}',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
            SizedBox(height: 10),
            Row(
              children: [
                Column(
                  children: [
                    TextView('${ingredient?.calories}',
                        fontWeight: FontWeight.w500, fontSize: 14),
                    TextView('Calories', color: Colors.grey),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    TextView('${ingredient?.proteins}',
                        fontWeight: FontWeight.w500, fontSize: 14),
                    TextView('Proteins', color: Colors.grey),
                  ],
                ),
                SizedBox(width: 20),
                Column(children: [
                  TextView('${ingredient?.fats}',
                      fontWeight: FontWeight.w500, fontSize: 14),
                  TextView('Fats', color: Colors.grey)
                ]),
                SizedBox(width: 20),
                Column(
                  children: [
                    TextView('${ingredient?.carbs}',
                        fontWeight: FontWeight.w500, fontSize: 14),
                    TextView('Carbs', color: Colors.grey),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
        GestureDetector(
          onTap: () {
            final GroceryLocal ins = GroceryLocal.instance;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InfoDialogBox(
                    icon: 'assets/images/tick_ss.png',
                    title: "Confirmation",
                    description:
                        "Do you want to add this Item in your Grocery List?",
                    onPressed: () async {
                      final GroceryLocal ins = GroceryLocal.instance;
                      ins.addItem({
                        'name': ingredient?.name,
                        'quantity': '${ingredient?.quantity}',
                        'type': ingredient?.type
                      });
                      Navigator.pop(context);
                    },
                  );
                });
          },
          child: Column(
            children: [
              Icon(
                Icons.add,
                color: PRIMARY_COLOR,
              ),
              SizedBox(
                height: 4,
              ),
              TextView('Add to\nGrocery List ', color: PRIMARY_COLOR),
            ],
          ),
        ),
      ],
    );
  }
}
