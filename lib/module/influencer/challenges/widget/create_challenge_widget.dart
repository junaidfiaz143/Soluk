import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../res/constants.dart';
import '../../../../res/globals.dart';
import '../../../../services/localisation.dart';
import '../view/add_challenges.dart';

class CreateChallengeWidget extends StatelessWidget {
  const CreateChallengeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                navigatorKey.currentState?.pushNamed(AddChallenges.id);
              },
              child: SvgPicture.asset(PLUS_ICON)),
          const SizedBox(height: 14),
          Text(
            AppLocalisation.getTranslated(context, LKCreateChallenges),
            style: subTitleTextStyle(context)
                ?.copyWith(fontSize: defaultSize.screenWidth * .050),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
              textAlign: TextAlign.center,
              style: hintTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}
