import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final VoidCallback callback;
  const FAB({
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        callback();
      },
      child: Icon(
        Icons.add,
        size: WIDTH_4,
      ),
      backgroundColor: PRIMARY_COLOR,
    );
  }
}
