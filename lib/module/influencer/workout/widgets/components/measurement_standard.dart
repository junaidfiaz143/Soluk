import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class MeasurementStandard extends StatefulWidget {
  final Function(String) onChange;
  final String? selected;
  const MeasurementStandard({Key? key, required this.onChange, this.selected})
      : super(key: key);

  @override
  State<MeasurementStandard> createState() => _MeasurementStandardState();
}

class _MeasurementStandardState extends State<MeasurementStandard> {
  List<String> measureStand = [
    "Teaspoon (tsp)",
    "TableSpoon (tbs)",
    "fluid ounce (fl)",
    "Gill (1/2 cup)",
    "Cup (c)",
    "Pint (pt)",
    "Quart (qt)",
    "Gallon (gt)",
    "Milliliter (ml)",
    "Liter (l)",
    "Deciliter (dl)",
    "Milligram (mg)",
    "Gram (g)",
    "Kilogram (kg)"
  ];
  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      value = widget.selected;
    }
  }

  String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: defaultSize.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: defaultSize.screenWidth * .003,
          color: Colors.grey[500]!,
        ),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: defaultSize.screenWidth * .03,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: DropdownButton<String>(
        underline: const SizedBox(),
        style: labelTextStyle(context)?.copyWith(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            defaultSize.screenWidth * .02,
          ),
        ),
        hint: const Text('Measurement Standard'),
        dropdownColor: DROPDOWN_BACKGROUND_COLOR,
        isExpanded: true,
        value: value,
        items: measureStand.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value),
              ],
            ),
            onTap: () {},
          );
        }).toList(),
        onChanged: (_) {
          if (_ != null && _.isNotEmpty) {
            widget.onChange(_);
            setState(() {
              value = _;
            });
          }
        },
      ),
    );
  }
}
