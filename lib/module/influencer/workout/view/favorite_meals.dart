import 'package:app/module/common/commonbloc.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/empty_screen.dart';
import 'package:app/module/influencer/workout/bloc/favorite_meal_bloc/favoritemealbloc_cubit.dart';
import 'package:app/module/influencer/workout/widgets/add_favorite_meal.dart';
import 'package:app/module/influencer/workout/widgets/components/favorite_meal_card.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/influencer/workout/widgets/favorite_detail.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user/models/meals/dashboard_meals_model.dart';

class FavoriteMeals extends StatelessWidget {
  String? selectedInfluencerId = null;

  FavoriteMeals({Key? key, this.selectedInfluencerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonBloc commonBloc = BlocProvider.of(context);
    final _favMealbloc =
        BlocProvider.of<FavoritemealblocCubit>(context, listen: false);
    _favMealbloc.getfavoriteMeal(selectedInfluencerId: selectedInfluencerId);
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        bgColor: backgroundColor,
        title: "Favorite Meals",
        body: BlocBuilder<FavoritemealblocCubit, FavoritemealblocState>(
            builder: (context, state) {
          if (state is FavoritemealLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }
          if (state is FavoritemealEmpty) {
            return commonBloc.userType == INFLUENCER
                ? EmptyScreen(
                    title: "Add Favorite Meals",
                    hideAddButton: true,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddFavoriteMeal(),
                        ),
                      );
                    },
                  )
                : EmptyScreen(
                    title: "No Favorite Meals Found",
                    callback: () {},
                    hideAddButton: true,
                  );
          } else if (state is FavoritemealData) {
            return RefreshWidget(
              refreshController: _favMealbloc.refreshController,
              onLoadMore: () => _favMealbloc.onLoadMore(),
              onRefresh: () => _favMealbloc.onRefresh(),
              child: ListView.builder(
                itemCount: state.favMeal?.responseDetails?.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Meal item = state.favMeal!.responseDetails!.data![index];

                  return FavoriteMealCard(
                    favItem: item,
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FavoriteDetail(favItem: item)));
                    },
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
      floatingActionButton:
          BlocBuilder<FavoritemealblocCubit, FavoritemealblocState>(
        builder: (context, state) {
          return commonBloc.userType == INFLUENCER
              ? (state.favMeal?.responseDetails?.data ?? []).isNotEmpty
                  ? FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AddFavoriteMeal()));
                      },
                      child: Icon(
                        Icons.add,
                        size: WIDTH_4,
                      ),
                      backgroundColor: PRIMARY_COLOR,
                    )
                  : Container()
              : Container();
        },
      ),
    );
  }
}
