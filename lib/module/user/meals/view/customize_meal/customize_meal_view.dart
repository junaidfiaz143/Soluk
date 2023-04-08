import 'package:flutter/material.dart';

import '../../../../../res/constants.dart';
import '../../../../influencer/widgets/choice_chip_widget.dart';
import '../../../widgets/top_appbar_row.dart';
import 'custom_meal/custom_meals_tab.dart';
import 'influencer_meals/influencer_meals_tab.dart';
import 'soluk_meals/soluk_meals_tab.dart';

class CustomizeMealView extends StatefulWidget {
  const CustomizeMealView({Key? key, this.mealType, this.mealIds})
      : super(key: key);
  final String? mealType;
  final List<int>? mealIds;

  @override
  State<CustomizeMealView> createState() => _CustomizeMealViewState();
}

class _CustomizeMealViewState extends State<CustomizeMealView> {
  // 0 represents influencer meal(since we are using list of chips)
  int selectedTypeIndex = 0;

  List<String> mealTypesList = [
    'Influencer Meals',
    'Restaurants',
    'Custom Meal'
  ];

  final PageController _pageController = PageController();

  void swipePage(int index) {
    setState(() {
      selectedTypeIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            TopAppbarRow(
              title: 'Customize Meal',
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    mealTypesList.length,
                    (index) => choiceChipWidget(
                          context,
                          title: mealTypesList[index],
                          isIncomeSelected: index == selectedTypeIndex,
                          onSelected: (val) {
                            setState(() {
                              selectedTypeIndex = index;
                            });
                            _pageController.jumpToPage(selectedTypeIndex);
                          },
                        )),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  swipePage(page);
                },
                children: [
                  InfluencerMealsTab(
                    mealIds: widget.mealIds ?? [],
                  ),
                  SolukMealsTab(
                    mealIds: widget.mealIds ?? [],
                  ),
                  CustomMealsTab(
                    mealIds: widget.mealIds ?? [],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
