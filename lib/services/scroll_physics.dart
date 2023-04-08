import 'package:app/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';

ScrollConfiguration scrollBehavior(BuildContext context, Widget? child) {
  return ScrollConfiguration(
    behavior: const ScrollBehaviorModified(),
    child: child!,
  );
}
