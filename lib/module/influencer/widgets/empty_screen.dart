import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  final bool? hideAddButton;
  final VoidCallback callback;

  const EmptyScreen({
    Key? key,
    required this.title,
    required this.callback,
    this.hideAddButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hideAddButton == true
        ? GestureDetector(
            onTap: () {
              callback();
            },
            child: getViewWithAddButton(context),
          )
        : getViewWithoutAddButton(context);
  }

  Widget getViewWithAddButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_circle,
          size: 33,
          color: PRIMARY_COLOR,
        ),
        SizedBox(
          height: defaultSize.screenHeight * .01,
        ),
        Text(
          title,
          style: subTitleTextStyle(context),
        ),
        SB_1H,
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
          textAlign: TextAlign.center,
          style: hintTextStyle(context),
        ),
      ],
    );
  }

  Widget getViewWithoutAddButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: subTitleTextStyle(context),
        ),
        SB_1H,
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
          textAlign: TextAlign.center,
          style: hintTextStyle(context),
        ),
      ],
    );
  }
}
