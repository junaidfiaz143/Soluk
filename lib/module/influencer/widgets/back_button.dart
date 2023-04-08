import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class SolukBackButton extends StatelessWidget {
  final VoidCallback? callback;
  final bool? result;

  const SolukBackButton({Key? key, this.callback,this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, result);
        callback?.call();
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: defaultSize.screenWidth * .09,
          maxWidth: defaultSize.screenWidth * .09,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
            defaultSize.screenWidth * .02,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: defaultSize.screenWidth * .05,
          ),
        ),
      ),
    );
  }
}
