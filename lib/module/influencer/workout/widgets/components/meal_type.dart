import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';

class MealTypeDropDown extends StatefulWidget {
  const MealTypeDropDown(
      {Key? key, required this.onValueChanged, this.mealType})
      : super(key: key);
  final Function(String) onValueChanged;
  final String? mealType;

  @override
  State<MealTypeDropDown> createState() => _MealTypeDropDownState();
}

class _MealTypeDropDownState extends State<MealTypeDropDown> {
  List<String> badges = ["Breakfast", "Snack", "Main Meal"];

  String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalisation.getTranslated(context, 'LKMealType'),
          style: subTitleTextStyle(context)?.copyWith(fontSize: 15),
        ),
        SB_Half,
        Container(
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
            hint: const Text('Select'),
            dropdownColor: DROPDOWN_BACKGROUND_COLOR,
            isExpanded: true,
            value: value ?? widget.mealType,
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
                widget.onValueChanged(value!);
              }
            },
          ),
        ),
      ],
    );
  }
}
