import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';

class Onboarding extends StatefulWidget {
  final String svgImage;
  const Onboarding({
    Key? key,
    required this.svgImage,
  }) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, ONBOARDING_IMAGE),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, ONBOARDING_IMAGE2),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, ONBOARDING_IMAGE3),
        null,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SB_3H,
        SvgPicture.asset(
          widget.svgImage,
        ),
        SB_3H,
        Center(
          child: Text(
            "Lorem ipsum ",
            style: headingTextStyle(context)?.copyWith(),
          ),
        ),
        SB_1H,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: HORIZONTAL_PADDING + 5,
          ),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vitae et sed duis fermentum turpis sit. A, nibh volutpat suspendisse pellentesque in sed.",
            textAlign: TextAlign.center,
            style: labelTextStyle(context),
          ),
        ),
      ],
    );
  }
}
