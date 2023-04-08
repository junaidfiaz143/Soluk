import 'package:flutter/material.dart';

class CommunityHeaderText extends StatelessWidget {
  const CommunityHeaderText(
      this.text, {
        Key? key,
      }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
