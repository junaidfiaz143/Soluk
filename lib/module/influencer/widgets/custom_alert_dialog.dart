import 'dart:ui';

import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  static const String id = '/custom_alert_dialog';
  final Widget contentWidget;
  const CustomAlertDialog({
    Key? key,
    required this.contentWidget,
  }) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(color: Colors.transparent)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: HORIZONTAL_PADDING + HORIZONTAL_PADDING / 2,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: widget.contentWidget,
              ),
            ),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(color: Colors.transparent)),
            ),
          ],
        ),
      ),
    );
  }
}
