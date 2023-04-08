import 'package:flutter/material.dart';

import '../../influencer/widgets/back_button.dart';
import '../../influencer/widgets/empty_widget.dart';

class TopAppbarRow extends StatelessWidget {
  final double topHeight;
  final double horizontalPadding;
  final String title;
  final Widget? actionWidget;

  const TopAppbarRow({
    Key? key,
    this.horizontalPadding = 20,
    required this.title,
    this.actionWidget,
    this.topHeight = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding) +
          EdgeInsets.only(top: topHeight),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SolukBackButton(),
              actionWidget ?? EmptyWidget(),
            ],
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 19),
          ),
        ],
      ),
    );
  }
}
