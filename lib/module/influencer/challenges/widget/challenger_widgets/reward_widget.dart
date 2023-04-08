import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../res/constants.dart';
import '../../../../../res/globals.dart';
import '../../../../../services/localisation.dart';
import '../../challenge_const.dart/challenge_const.dart';

class RewardWidget extends StatelessWidget {
  String badgeType;

  RewardWidget(
    this.badgeType, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalisation.getTranslated(context, LKReward),
          style: labelTextStyle(context)?.copyWith(
              fontSize: defaultSize.screenWidth * .034,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        SvgPicture.asset('${ChallengeConst.badges["${badgeType}"]}',
            height: 30, width: 30),
        const SizedBox(height: 6),
        Text(
          '${ChallengeConst.title["${badgeType}"]}',
          style: hintTextStyle(context)?.copyWith(
              fontSize: defaultSize.screenWidth * .038,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
