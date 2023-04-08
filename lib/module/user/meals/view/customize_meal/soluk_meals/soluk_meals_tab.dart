import 'package:app/module/user/meals/view/customize_meal/soluk_meals/soluk_resturant_meals.dart';
import 'package:app/module/user/models/meals/restaurant_model.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../res/constants.dart';
import '../../../../../../res/globals.dart';
import '../../../../../../services/localisation.dart';
import '../../../../../influencer/widgets/empty_screen.dart';
import '../../../bloc/dashboard_meals_bloc.dart';
import '../../../widgets/restaurant_card.dart';

class SolukMealsTab extends StatefulWidget {
  const SolukMealsTab({Key? key, required this.mealIds}) : super(key: key);
  final List<int> mealIds;

  @override
  State<SolukMealsTab> createState() => _SolukMealsTabState();
}

class _SolukMealsTabState extends State<SolukMealsTab> {
  late DashboardMealsBloc _dashboardMealsBloc;

  @override
  void initState() {
    super.initState();
    _dashboardMealsBloc = BlocProvider.of(context);
    _dashboardMealsBloc.getSalukResturantsList();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: TextEditingController(),
            textInputAction: TextInputAction.search,
            onSubmitted: (value){
              _dashboardMealsBloc.getSalukResturantsList(searchTitle: value);
            },
            decoration: InputDecoration(
              hintText: AppLocalisation.getTranslated(context, LKSearch),
              hintStyle: hintTextStyle(context),
              filled: true,
              fillColor: Color(0xffE3E3E3),
              border: inputBorder,
              focusedErrorBorder: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              labelStyle: hintTextStyle(context),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              isDense: true,
            ),
          ),
          SizedBox(height: 16),
          TextView('Soluk Meals', fontSize: 14, fontWeight: FontWeight.w500),
          SizedBox(height: 8),
          TextView(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            fontSize: 14,
          ),
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<RestaurantModel?>(
                stream: _dashboardMealsBloc.resturantStream,
                initialData: null,
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? ListView.builder(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                          itemCount:
                              snapshot.data?.responseDetails?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  // NavRouter.push(context, SolukMealsDetails());
                                  NavRouter.push(
                                      context,
                                      SolukRestaurantMeals(
                                          mealIds: widget.mealIds,
                                          meals: snapshot.data?.responseDetails
                                              ?.data?[index].meals));
                                },
                                child: RestaurantCard(
                                    restaurant: snapshot
                                        .data!.responseDetails!.data![index]));
                          },
                        )
                      : EmptyScreen(
                          title: "No Restaurants Found",
                          callback: () {},
                          hideAddButton: true,
                        );
                  ;
                }),
          )
        ],
      ),
    );
  }
}

OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.transparent));
