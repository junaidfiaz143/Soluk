import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/color.dart';
import '../../../../res/globals.dart';
import '../../models/meals/dashboard_meals_model.dart';
import '../../widgets/text_view.dart';

class MealCard extends StatelessWidget {
  final Function(BuildContext? context, Meal? meal)? onDelete;
  final bool isDeleteEnabled;
  final bool isSelected;
  final bool isSelectionAvailable;
  final Meal? meal;

  const MealCard({
    this.onDelete,
    this.isDeleteEnabled = false,
    this.isSelected = false,
    this.isSelectionAvailable = false,
    this.meal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 110,
          margin: EdgeInsets.only(bottom: 14),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        Slidable(
          enabled: isDeleteEnabled,
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            extentRatio: 0.20,
            children: [
              SlidableAction(
                onPressed: (ctx) {
                  onDelete?.call(ctx, meal);
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.red,
                icon: Icons.delete,
              ),
            ],
          ),
          child: Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height,
                    width: WIDTH_5 * 3.2,
                    imageUrl: meal?.imageUrl ?? 'https://picsum.photos/200',
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: PRIMARY_COLOR,
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                      meal?.title ?? 'N/A',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    SizedBox(height: 2),
                    TextView('${meal?.calories ?? 0} Calories'),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        GramWidget(title: 'Fat', grams: '${meal?.fats}'),
                        GramWidget(
                            title: 'Proteins', grams: '${meal?.proteins}'),
                        GramWidget(title: 'Carbs', grams: '${meal?.carbs}'),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        if (isSelectionAvailable)
          Positioned(
            right: 16,
            top: 20,
            child: SvgPicture.asset(isSelected
                ? 'assets/svgs/ic_tick.svg'
                : 'assets/svgs/ic_tick_grey.svg'),
          )
      ],
    );
  }
}

class GramWidget extends StatelessWidget {
  const GramWidget({Key? key, required this.title, required this.grams})
      : super(key: key);
  final String title;
  final String grams;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 18.0),
      child: Column(
        children: [
          TextView('${grams}g'),
          TextView(
            title,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
