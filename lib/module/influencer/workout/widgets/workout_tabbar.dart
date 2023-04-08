import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';

class WorkoutTabbar extends StatelessWidget {
  const WorkoutTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: labelTextStyle(context)?.copyWith(
        color: PRIMARY_COLOR,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: labelTextStyle(context)?.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      onTap: (i) {
        if (i == 0) {
          
        } else if (i == 1) {
          
        } else if (i == 0) {
          
        }
      },
      indicatorColor: PRIMARY_COLOR,
      labelColor: PRIMARY_COLOR,
      unselectedLabelColor: Colors.black,
      tabs:  [
        Tab(
          text: AppLocalisation.getTranslated(context, LKWorkOuts),
        ),
        Tab(
          text: AppLocalisation.getTranslated(context, LKInsights),
        ),
        Tab(
          text: AppLocalisation.getTranslated(context, LKAboutMe),
        )
      ],
    );
  }
}
