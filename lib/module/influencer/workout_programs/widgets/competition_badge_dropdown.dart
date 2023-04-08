import 'package:app/module/influencer/workout_programs/model/workout_prerequisites_response.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class CompetitionBadgeDropDown extends StatefulWidget {
  final ValueChanged<CompletionBadge> onChanged;
  String? defaultValue, selectedValue, dropdownHint;
  List<CompletionBadge>? itemsList;
  CompetitionBadgeDropDown(
      {Key? key,
      this.itemsList,
      this.defaultValue,
      this.dropdownHint,
      required this.onChanged})
      : super(key: key);

  @override
  State<CompetitionBadgeDropDown> createState() =>
      _CompetitionBadgeDropDownState();
}

class _CompetitionBadgeDropDownState extends State<CompetitionBadgeDropDown> {
  //List<String> badges = ["Select Completion Badge", "Bronze", "Silver", "Gold"];

  //String? value = "Select Completion Badge";

  CompletionBadge? _value;

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
          color: Colors.grey[500]!,
        ),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: defaultSize.screenWidth * .03,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: DropdownButton<String>(
        hint: Text(_value != null ? _value!.title : widget.dropdownHint!),
        underline: const SizedBox(),
        style: labelTextStyle(context)?.copyWith(
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
        dropdownColor: DROPDOWN_BACKGROUND_COLOR,
        isExpanded: true,
        items: widget.itemsList!.map((value) {
          return DropdownMenuItem<String>(
            value: value.title,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value.title),
              ],
            ),
            onTap: () {
              widget.onChanged(value);
              _value = value;
              setState(() {});
            },
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            //_value = value!;
          });
          // widget.onChanged(value);
        },
        //value: _value?.title ?? widget.defaultValue,
        // hint: Text(widget.dropdownHint!),
      ),
    );
  }
}
