import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../services/localisation.dart';

class FilteredSearch extends StatelessWidget {
  const FilteredSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: HEIGHT_3,
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
                  height: HEIGHT_1 * 1.5,
                  width: HEIGHT_1 * 1.5,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search,
                    size: defaultSize.screenWidth * .05,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: defaultSize.screenWidth * .02,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: AppLocalisation.getTranslated(context, LKSearch),
                      hintStyle: hintTextStyle(context),
                      border: InputBorder.none,
                      labelStyle: hintTextStyle(context),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: defaultSize.screenHeight * .02,
                        horizontal: defaultSize.screenWidth * .02,
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: defaultSize.screenWidth * .02,
        ),
        Container(
          height: HEIGHT_1 * 1.5,
          width: HEIGHT_1 * 1.5,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            FILTER_ICON,
          ),
        ),
      ],
    );
  }
}
