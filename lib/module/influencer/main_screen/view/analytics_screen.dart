import 'package:app/module/influencer/income_analytics/view/income_screen.dart';
import 'package:app/module/influencer/views_analytics/view/views_screen.dart';
import 'package:app/module/influencer/widgets/analytics_widget.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/res/constants.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBody(
      title: AppLocalisation.getTranslated(context, LKAnalytics),
      showBackButton: false,
      body: Column(
        children: [
          analyticsWidget(
              context: context,
              onPress: () {
                NavRouter.push(context, const IncomeScreen());
              }),
          // analyticsWidget(
          //     context: context,
          //     isViews: true,
          //     onPress: () {
          //       NavRouter.push(context, const ViewsScreen());
          //     }),
        ],
      ),
    );
  }
}
