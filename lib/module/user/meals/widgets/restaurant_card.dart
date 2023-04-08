import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/globals.dart';
import '../../models/meals/restaurant_model.dart';
import '../../widgets/text_view.dart';

class RestaurantCard extends StatelessWidget {
  final Resturant restaurant;
  const RestaurantCard({
    Key? key,
    required this.restaurant
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
        Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: WIDTH_5 * 3.2,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(restaurant.assetUrl ?? ""),
                  ),
                ),
              ),
              SizedBox(width: 20),
              TextView(
                restaurant.title ?? "",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios,size: 16),
              SizedBox(width: 10)
            ],
          ),
        ),
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
