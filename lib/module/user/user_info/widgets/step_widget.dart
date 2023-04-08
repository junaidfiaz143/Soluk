import 'package:flutter/material.dart';

import '../../widgets/text_view.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    Key? key,
    required this.stepName,
    required this.stepNumber,
  }) : super(key: key);

  final String stepName;
  final String stepNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              stepName,
              color: Colors.black,
              fontSize: 13,
            ),
            RichText(
              text: TextSpan(
                text: 'Step ',
                children: [
                  TextSpan(
                    text: stepNumber,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: '/9',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffE6E6E6)),
              child: SizedBox(
                height: 10.0,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width *
                  (double.parse(stepNumber) / 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Color(0xff498AEE), Color(0xff7EF6DD)],
                    stops: [
                      0.4,
                      1.0,
                    ],
                  )),
              child: SizedBox(
                height: 10.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}
