import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StoryScreenState();
}

class StoryScreenState extends State<StoryScreen> {
  getProgress(int length) {
    List<Widget> s = [];

    s.add(SizedBox(
      width: 5,
    ));
    for (int i = 0; i < length; i++) {
      s.add(Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: 0.1,
            minHeight: 2,
          ),
        ),
      ));
      s.add(SizedBox(
        width: 5,
      ));
    }
    return Row(
      children: s,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          children: [Text("jhjh"), getProgress(1)],
        ),
      ),
    );
  }
}
