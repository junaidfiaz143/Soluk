import 'package:flutter/material.dart';

import '../../../res/color.dart';
import 'text_view.dart';

class UserInfoReviewCard extends StatelessWidget {
  const UserInfoReviewCard(
      {Key? key, required this.name, required this.value, required this.onTap})
      : super(key: key);
  final String name;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 145,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TextView(
                value,
                fontWeight: FontWeight.w600,
                fontSize: 19,
                color: PRIMARY_COLOR,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              TextView(
                name,
                color: Colors.grey,
                fontSize: 13,
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
      ),
    );
  }
}
