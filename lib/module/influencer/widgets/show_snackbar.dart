import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

showSnackBar(
  BuildContext context,
  String message, {
  Color? textColor,
  Color? backgroundColor,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: labelTextStyle(context)?.copyWith(
          color: textColor ?? Colors.white,
        ),
      ),
      backgroundColor: backgroundColor ?? Colors.red,
    ),
  );
}

invalidDataSnackBar(BuildContext context, String responseCode) {
  switch (responseCode) {
    case INVALID_PARAMETER:
      return showSnackBar(context, "Invalid parameter entered.");
    case DATA_NOT_EXIST:
      return showSnackBar(context, "Data doesn't exist.");
    case ACCOUNT_NOT_VERIFIED:
      return showSnackBar(context, "Please verify your account.");
    case SERVER_ERROR:
      return showSnackBar(context, "Internal Server Error.");
    case ALREADY_EXIST:
      return showSnackBar(context, "Entity already exist.");
    default:
      return showSnackBar(context, "Query performed successfully");
  }
}
