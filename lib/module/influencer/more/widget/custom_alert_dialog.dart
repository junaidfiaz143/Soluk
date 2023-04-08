import 'dart:ui';

import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  static const String id = '/custom_alert_dialog';
  final Widget contentWidget;
  final double sigmaX;
  final double sigmaY;
  final bool isSmallSize;

  CustomAlertDialog({
    Key? key,
    required this.contentWidget,
    this.sigmaX = 5,
    this.sigmaY = 5,
    this.isSmallSize = false,
  }) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black.withOpacity(0.3),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: widget.sigmaX, sigmaY: widget.sigmaY),
        child: Center(
          child: (widget.isSmallSize)
              ? Container(width: 300, height: 300, child: dialogBody())
              : dialogBody(),
        ),
      ),
    );
  }

  dialogBody() {
    return Column(
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
    );
  }
}
