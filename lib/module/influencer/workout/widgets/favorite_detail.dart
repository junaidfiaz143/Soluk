import 'package:app/module/common/commonbloc.dart';
import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/workout/widgets/add_favorite_meal.dart';
import 'package:app/module/user/models/meal/meal_dashboard.dart' as fav;
import 'package:app/module/user/models/meals/dashboard_meals_model.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../res/color.dart';
import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../../../../utils/day_selection_dropdown.dart';
import '../../../user/meals/bloc/meal_cubit.dart';
import '../../widgets/bottom_button.dart';

class FavoriteDetail extends StatefulWidget {
  static const id = 'ProgramDetail';
  final Meal favItem;

  const FavoriteDetail({Key? key, required this.favItem}) : super(key: key);

  @override
  State<FavoriteDetail> createState() => _FavoriteDetailState();
}

class _FavoriteDetailState extends State<FavoriteDetail> {
  // bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    CommonBloc commonBloc = BlocProvider.of(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: HEIGHT_5 * 3.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.favItem.imageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SolukBackButton(
                          callback: () {},
                        ),
                        Text(
                          'Favorite Meals',
                          style: subTitleTextStyle(context)?.copyWith(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        SB_5W,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: HEIGHT_5 * 1.3,
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
                                      widget.favItem.title ?? '',
                                      maxLines: 1,
                                      style: hintTextStyle(context)?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                commonBloc.userType == INFLUENCER
                                    ? InkWell(
                                        onTap: () {
                                          var route = MaterialPageRoute(
                                            builder: (context) =>
                                                AddFavoriteMeal(
                                              favItem: widget.favItem,
                                            ),
                                          );
                                          Navigator.push(context, route);
                                        },
                                        child: Container(
                                          height: defaultSize.screenWidth * .09,
                                          width: defaultSize.screenWidth * .09,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(30.0),
                                              topLeft: Radius.circular(30.0),
                                              bottomLeft: Radius.circular(30.0),
                                              bottomRight:
                                                  Radius.circular(30.0),
                                            ),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                              size:
                                                  defaultSize.screenWidth * .05,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            SB_1H,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                item(context, '${widget.favItem.calories}',
                                    'Calories'),
                                item(context, '${widget.favItem.proteins}',
                                    'Proteins'),
                                item(context, '${widget.favItem.fats}', 'Fats'),
                                item(context, '${widget.favItem.carbs}',
                                    'Carbs'),
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
                                    TextView(widget.favItem.mealType.toString(),
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
                                        widget.favItem.mealLevel.toString(),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                                commonBloc.userType == NORMAL_USER
                                    ? GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (_) {
                                                String? dayClassi;

                                                return Scaffold(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  body: Center(
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.34,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    3.5.h),
                                                        color: Colors.white,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 6.w,
                                                                right: 6.w,
                                                                bottom: 1.2.h,
                                                                top: 3.h),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            DaySelectionDropDown(
                                                                onValueChanged:
                                                                    (value) =>
                                                                        dayClassi =
                                                                            value,
                                                                mealClassi:
                                                                    dayClassi),
                                                            SB_1H,
                                                            SalukBottomButton(
                                                                title: AppLocalisation
                                                                    .getTranslated(
                                                                        context,
                                                                        'LKSubmit'),
                                                                callback:
                                                                    () async {
                                                                  if (dayClassi ==
                                                                      null) {
                                                                    SolukToast
                                                                        .showToast(
                                                                            "please select Day to proceeds");
                                                                    return;
                                                                  }

                                                                  MealCubit
                                                                      mealCubit =
                                                                      BlocProvider.of<
                                                                              MealCubit>(
                                                                          context);

                                                                  await mealCubit.customizationOfMeal(
                                                                      meals: [
                                                                        widget
                                                                            .favItem
                                                                      ],
                                                                      mealType: widget
                                                                          .favItem
                                                                          .mealType,
                                                                      day: dayClassi!
                                                                          .split(
                                                                              ' ')[1]);

                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                isButtonDisabled:
                                                                    false // _titleController.text.isEmpty,
                                                                ),
                                                            SB_1H,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                                            TextView(
                                              'Add to\nMeal',
                                              color: PRIMARY_COLOR,
                                              fontSize: 12,
                                            )
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            SB_1H,
                            Text(
                              'Ingredients',
                              maxLines: 1,
                              style: hintTextStyle(context)?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Color(0xffF9F9F9),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  widget.favItem.ingredients!.length,
                                  (index) => MealsDetailsIngredientsTile(
                                    ingredient:
                                        widget.favItem.ingredients![index],
                                  ),
                                ),
                              ),
                            ),
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
                              '${widget.favItem.method}',
                              style: hintTextStyle(context)?.copyWith(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                            SB_1H,
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }

  item(BuildContext context, String title, String subTitle,
      {VerticalDirection verticalDirection = VerticalDirection.down}) {
    return Column(
      verticalDirection: verticalDirection,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: subTitleTextStyle(context)?.copyWith(
              color: Colors.black,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold),
        ),
        Text(
          subTitle,
          style: subTitleTextStyle(context)?.copyWith(
              color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class MealsDetailsIngredientsTile extends StatelessWidget {
  const MealsDetailsIngredientsTile({
    Key? key,
    required this.ingredient,
  }) : super(key: key);
  final fav.Ingredients ingredient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          ingredient.name!,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 2),
        TextView('Qty - ${ingredient.quantity?.toInt()} ${ingredient.type}',
            color: Colors.grey),
        SizedBox(height: 14),
        Row(
          children: [
            Column(
              children: [
                TextView('${ingredient.calories}',
                    fontWeight: FontWeight.w500, fontSize: 14),
                TextView('Calories', color: Colors.grey),
              ],
            ),
            SizedBox(width: 16),
            Column(
              children: [
                TextView('${ingredient.proteins}',
                    fontWeight: FontWeight.w500, fontSize: 14),
                TextView('Proteins', color: Colors.grey),
              ],
            ),
            SizedBox(width: 16),
            Column(children: [
              TextView('${ingredient.fats}',
                  fontWeight: FontWeight.w500, fontSize: 14),
              TextView('Fats', color: Colors.grey)
            ]),
            SizedBox(width: 16),
            Column(
              children: [
                TextView('${ingredient.carbs}',
                    fontWeight: FontWeight.w500, fontSize: 14),
                TextView('Carbs', color: Colors.grey),
              ],
            ),
          ],
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
