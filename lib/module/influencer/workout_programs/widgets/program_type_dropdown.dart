import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class ProgramTypeDropDown extends StatefulWidget {
  final ValueChanged<String> onChanged;
  String? defaultValue, selectedValue, dropdownHint;
  List<String>? itemsList;
  ProgramTypeDropDown(
      {Key? key, this.itemsList, this.defaultValue, this.dropdownHint, required this.onChanged})
      : super(key: key);

  @override
  State<ProgramTypeDropDown> createState() => _ProgramTypeDropDownState();
}

class _ProgramTypeDropDownState extends State<ProgramTypeDropDown> {
  // List<String> badges = ["Select Type", "Free", "Paid"];

  String? _value;
  //= "Select Type";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultSize.screenWidth * 0.44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
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
        dropdownColor: DROPDOWN_BACKGROUND_COLOR,
        isExpanded: true,
        items: widget.itemsList!.map((String value) {
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
        onChanged: (value) {
          setState(() {
            _value = value!;
          });
          widget.onChanged(value!);
        },
        hint: Text(_value != null ? _value! : widget.dropdownHint!),
      ),
    );
  }
}
