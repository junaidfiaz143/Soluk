import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class WorkoutTypeDropDown extends StatefulWidget {
  const WorkoutTypeDropDown({Key? key}) : super(key: key);

  @override
  State<WorkoutTypeDropDown> createState() => _WorkoutTypeDropDownState();
}

class _WorkoutTypeDropDownState extends State<WorkoutTypeDropDown> {
  List<String> badges = [
    "Select",
    "Single Workout",
    "Superset",
    "Circuit",
    "Long"
  ];

  String? value = "Select";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultSize.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(
          width: defaultSize.screenWidth * .003,
          color: PRIMARY_COLOR,
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
            20,
          ),
        ),
        dropdownColor: DROPDOWN_BACKGROUND_COLOR,
        isExpanded: true,
        value: value ?? "",
        items: badges.map((String value) {
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
            setState(() {
              value = _;
            });
          }
        },
      ),
    );
  }
}
