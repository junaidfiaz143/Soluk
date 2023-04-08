import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class InfluencerWorkoutTile extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback callback;

  InfluencerWorkoutTile({
    Key? key,
    required this.image,
    required this.title,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        width: double.maxFinite,
        height: 126,
        decoration: BoxDecoration(
          borderRadius: BORDER_CIRCULAR_RADIUS * 2,
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: HORIZONTAL_PADDING,
            vertical: HORIZONTAL_PADDING,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
