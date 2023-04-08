import 'dart:io';

import 'package:app/module/influencer/bloc/bottom_nav_bloc.dart';
import 'package:app/module/influencer/widgets/bottom_nav_icon.dart';
import 'package:app/res/constants.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/enums.dart' as enums;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bottomNavBloc = BlocProvider.of<BottomNavBloc>(context);
    return BlocBuilder<BottomNavBloc, enums.Action>(
      builder: (BuildContext context, state) {
        return Container(
          padding: EdgeInsets.only(bottom: Platform.isIOS ? 16 : 0),
          height: Platform.isIOS ? 75: 62,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
          ),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BottomNavIcon(
                callback: () {
                  _bottomNavBloc.add(Dashboard());
                },
                asset: 'assets/svgs/ic_inf_dashboard.svg',
                matched: state == enums.Action.DASHBOARD,
                title: AppLocalisation.getTranslated(context, LKDashboard),
              ),
              BottomNavIcon(
                callback: () {
                  _bottomNavBloc.add(WorkPlan());
                },
                asset: 'assets/svgs/ic_inf_workout_plan.svg',
                matched: state == enums.Action.WORKPLAN,
                title: AppLocalisation.getTranslated(context, LKWorkOutPlan),
              ),
              BottomNavIcon(
                callback: () {
                  _bottomNavBloc.add(Analytics());
                },
                asset: 'assets/svgs/ic_inf_analytics.svg',
                matched: state == enums.Action.ANALYTICS,
                title: AppLocalisation.getTranslated(context, LKAnalytics),
              ),
              BottomNavIcon(
                callback: () {
                  _bottomNavBloc.add(More());
                },
                asset: 'assets/svgs/ic_inf_more.svg',
                matched: state == enums.Action.MORE,
                title: AppLocalisation.getTranslated(context, LKMore),
              ),
            ],
          ),
        );
      },
    );
  }
}
