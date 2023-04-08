import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/globals.dart';
import '../../../utils/app_Icons.dart';

class SearchEditText extends StatelessWidget {
  const SearchEditText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.silver_bg,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.searchIcon,
            height: 22,
            width: 22,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Search",
            style: hintTextStyle(context)
                ?.copyWith(fontSize: 12, color: AppColors.silver),
          ),
        ],
      ),
    );

    //   Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
    //   child: TextFormField(
    //     cursorColor: AppColors.silver,
    //     onChanged: (val) {},
    //     enabled: false,
    //     decoration: InputDecoration(
    //       isDense: true,
    //       fillColor: AppColors.silver_bg,
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //         borderSide: BorderSide(
    //           width: 0,
    //           style: BorderStyle.none,
    //         ),
    //       ),
    //       filled: true,
    //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    //       hintStyle: TextStyle(
    //           color: AppColors.silver,
    //           fontSize: 12,
    //           fontWeight: FontWeight.w400),
    //       hintText: "Search",
    //       hintMaxLines: 1,
    //       prefix: Padding(
    //         padding: const EdgeInsets.only(
    //           right: 10.0,
    //         ),
    //         child: SvgPicture.asset(
    //           Assets.searchIcon,
    //           height: 16,
    //           width: 16,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
