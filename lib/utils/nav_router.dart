import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavRouter {
  /* PUSH */
  static Future push(BuildContext context, Widget route) {
    return Navigator.push(context, CupertinoPageRoute(builder: (_) => route));
  }

  /* PUSH REPLACEMENT */
  static Future pushReplacement(BuildContext context, Widget route) {
    return Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }

  /* POP */
  static void pop(BuildContext context) {
    return Navigator.of(context).pop();
  }

  /* PUSH AND REMOVE UNTIL */
  static Future pushAndRemoveUntil(BuildContext context, Widget route) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => route,
        ),
        (Route<dynamic> route) => false);
  }
}
