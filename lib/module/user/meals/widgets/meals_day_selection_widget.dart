import 'package:flutter/material.dart';

import '../../../../res/color.dart';
import '../../widgets/text_view.dart';

class MealsDaySelectionWidget extends StatefulWidget {
  const MealsDaySelectionWidget(
      {Key? key,
      required this.selectedIndex,
      required this.currentDay,
      required this.dayChangeCallback})
      : super(key: key);
  final int selectedIndex;
  final int currentDay;
  final Function(int) dayChangeCallback;

  @override
  State<MealsDaySelectionWidget> createState() =>
      _MealsDaySelectionWidgetState();
}

class _MealsDaySelectionWidgetState extends State<MealsDaySelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        7,
            (index) => Expanded(
          child: GestureDetector(
            onTap: () {
              widget.dayChangeCallback.call(index + 1);
            },
            child: Container(
              height: 66,
              width: 43,
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: widget.selectedIndex == index
                    ? PRIMARY_COLOR
                    : widget.currentDay == index
                        ? Colors.grey.shade300
                        : Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    (index + 1).toString(),
                    color: widget.selectedIndex == index
                        ? Colors.white
                        : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  TextView(
                    'Day',
                    color: widget.selectedIndex == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
