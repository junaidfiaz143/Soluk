
import 'package:app/module/user/profile/sub_screen/privacy_settings/privacy_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSwitch extends StatefulWidget {
  final bool initialValue;
  final BoolCallback callback;
  NotificationSwitch({Key? key,required this.initialValue,required this.callback}) : super(key: key);

  @override
  _NotificationSwitchState createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  bool notificationValue = false;
  @override
  void initState() {
    notificationValue=widget.initialValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
        activeColor: Colors.blue,
        value: notificationValue,
        onChanged: (_) {
          notificationValue = _;
          widget.callback(notificationValue);
          setState(() {});
        },
      ),
    );
  }
}
