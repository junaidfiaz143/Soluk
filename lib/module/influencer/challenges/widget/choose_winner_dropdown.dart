import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';

class ChooseWinnerDropDown extends StatefulWidget {
  final Function(String) onValueChange;

  const ChooseWinnerDropDown({Key? key,required this.onValueChange}) : super(key: key);

  @override
  State<ChooseWinnerDropDown> createState() => _ChooseWinnerDropDownState();
}

class _ChooseWinnerDropDownState extends State<ChooseWinnerDropDown> {

  String? value;

  @override
  Widget build(BuildContext context) {
    List<String> badges = [AppLocalisation.getTranslated(context, LKSelfInfluencer), AppLocalisation.getTranslated(context, LKCommunity)];
    return Container(
      width: defaultSize.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(
          width: defaultSize.screenWidth * .003,
          color: Colors.blue,
        ),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: defaultSize.screenWidth * .03,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: DropdownButton<String>(
        hint: Text(AppLocalisation.getTranslated(context, LKChooseWinnerBy), style: labelTextStyle(context)),
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
        value: value,
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
            widget.onValueChange(_);
            setState(() {
              value = _;
            });
          }
        },
      ),
    );
  }
}
