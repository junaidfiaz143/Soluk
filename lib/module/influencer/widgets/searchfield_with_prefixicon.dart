import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/constants.dart';
import '../../../res/globals.dart';
import '../../../services/localisation.dart';


class SearchFieldWithPrefixIcon extends StatelessWidget {
  final Function(String) onValueChange;
  final TextEditingController controller;
  const SearchFieldWithPrefixIcon({Key? key,required this.onValueChange,required this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HEIGHT_3-3,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          defaultSize.radius(60),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: defaultSize.screenWidth * .02,
      ),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/svgs/ic_search.svg',
                height: 24,
                width: 24,
              )),
          SizedBox(
            width: defaultSize.screenWidth * .02,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) => onValueChange(value),
              decoration: InputDecoration(
                hintText: AppLocalisation.getTranslated(context, LKSearch),
                hintStyle: hintTextStyle(context),
                border: InputBorder.none,
                labelStyle: hintTextStyle(context),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultSize.screenWidth * .02,
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
