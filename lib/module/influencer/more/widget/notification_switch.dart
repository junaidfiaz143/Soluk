import 'package:app/module/influencer/more/repo/more_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({Key? key}) : super(key: key);

  @override
  _NotificationSwitchState createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  bool notificationValue = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    MoreRepository.getNotificationStatus(context).then((value) {
      setState(() {
        notificationValue = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircularProgressIndicator(),
            )
          : CupertinoSwitch(
              activeColor: const Color(0xff498AEE),
              value: notificationValue,
              onChanged: (_) {
                notificationValue = _;
                setState(() {});
                MoreRepository.setNotificationStatus(
                    context, notificationValue);
              },
            ),
    );
  }
}
