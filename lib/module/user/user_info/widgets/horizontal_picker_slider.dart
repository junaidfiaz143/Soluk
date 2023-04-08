import 'package:app/module/user/user_info/widgets/vertical_line_pointer.dart';
import 'package:flutter/material.dart';

import '../../../../res/color.dart';

class HorizontalPickerSlider extends StatefulWidget {
  final FixedExtentScrollController fixedExtentScrollController;
  final int sliderLength;
  final Function(int value) onChanged;

  const HorizontalPickerSlider(
      {Key? key,
      required this.fixedExtentScrollController,
      required this.sliderLength,
      required this.onChanged})
      : super(key: key);

  @override
  State<HorizontalPickerSlider> createState() => _HorizontalPickerSliderState();
}

class _HorizontalPickerSliderState extends State<HorizontalPickerSlider> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: RotatedBox(
        quarterTurns: 3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListWheelScrollView(
              controller: widget.fixedExtentScrollController,
              useMagnifier: true,
              itemExtent: 10,
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 8.0,
              perspective: 0.007,
              children: List.generate(
                widget.sliderLength,
                (index) => Center(
                  child: VerticalLinePointer(
                    height: index % 5 == 0 ? 44 : 26,
                    width: index % 5 == 0 ? 1.2 : 1,
                  ),
                ),
              ),
              onSelectedItemChanged: (index) {
                widget.onChanged(index);
              },
            ),
            Center(
              child: VerticalLinePointer(
                width: 2.5,
                height: 70,
                color: PRIMARY_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
