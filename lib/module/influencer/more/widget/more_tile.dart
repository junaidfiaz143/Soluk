import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:sizer/sizer.dart';

class MoreTile extends StatelessWidget {
  final String title, asset;
  final VoidCallback callback;
  final bool? isLogout;

  MoreTile({
    Key? key,
    required this.title,
    required this.asset,
    required this.callback,
    this.isLogout = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: InkWell(
        onTap: () {
          callback();
        },
        child: SizedBox(
          height: HEIGHT_2,
          child: Row(
            children: [
              SvgPicture.asset(
                asset,
                height: defaultSize.screenHeight * .035,
                width: defaultSize.screenHeight * .035,
                color: Colors.black,
              ),
              SizedBox(
                width: WIDTH_1,
              ),
              Text(
                title,
                style: labelTextStyle(context)!.copyWith(
                  color: isLogout! ? const Color(0xFFa4a2aa) : Colors.black,)
              ),
              const Spacer(),
              isLogout!
                  ? const SizedBox()
                  :SvgPicture.asset(
                IOS_ICON_FORWARD,
                height: defaultSize.screenHeight * .04,
                width: defaultSize.screenHeight * .04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
