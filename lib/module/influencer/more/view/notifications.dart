import 'package:app/module/influencer/more/widget/notification_switch.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class Notifications extends StatelessWidget {
  static const String id = "/more_notifications";
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKNotification),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SB_1H,
            Container(
              height: HEIGHT_4,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200]!,
                    spreadRadius: 4.0,
                    blurRadius: 14.0,
                  ),
                ],
                borderRadius: BORDER_CIRCULAR_RADIUS,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: WIDTH_1,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ALERT_ICON,
                      color: PRIMARY_COLOR,
                      height: WIDTH_4,
                      width: WIDTH_4,
                    ),
                    SizedBox(width: 1.w,),
                    Text(
                      AppLocalisation.getTranslated(context, LKNotificationAlerts),
                      style: labelTextStyle(context),
                    ),
                    const Spacer(),
                    const NotificationSwitch()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
