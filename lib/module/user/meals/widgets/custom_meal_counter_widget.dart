import 'package:app/module/user/meals/widgets/add_sub_counter.dart';
import 'package:app/module/user/models/meals/dashboard_meals_model.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

import '../../../influencer/widgets/empty_screen.dart';

class CustomMealCounter extends StatelessWidget {
  final String title;
  final List<Meal>? meals;
  final Widget actionButtons;
  final Function? onDismiss;

  const CustomMealCounter({
    Key? key,
    required this.title,
    required this.meals,
    required this.actionButtons,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, false);
                  if (onDismiss != null) onDismiss!();
                },
                child: Container(
                  height: defaultSize.screenHeight * .03,
                  width: defaultSize.screenHeight * .03,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      size: defaultSize.screenHeight * .015,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              title,
              style: labelTextStyle(context)
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          SizedBox(
            height: defaultSize.screenHeight * .02,
          ),
          meals != null
              ? SizedBox(
                  height: 150,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: meals?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                meals?[index].title ?? '',
                                style: labelTextStyle(context)?.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              AddSubCounter(meal: meals?[index])
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      );
                    },
                  ),
                )
              : EmptyScreen(
                  title: "No Meals Found",
                  callback: () {},
                  hideAddButton: true,
                ),
          actionButtons,
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void calculateMeal(Meal? meal, int count) {}
}
