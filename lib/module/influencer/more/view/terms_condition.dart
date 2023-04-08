import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/back_button.dart';

class TermsCondition extends StatelessWidget {
  static const String id = "/more_terms_conditions";

  const TermsCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Stack(
              children: [
                SolukBackButton(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      SvgPicture.asset('assets/svgs/terms_condition.svg'),
                      SizedBox(height: 10),
                      Text(
                          AppLocalisation.getTranslated(
                              context, LKTermsCondition),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16))
                    ],
                  ),
                ),
              ],
            ),
            SB_1H,
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Bibendum venenatis, adipiscing consectetur in integer iaculis gravida dictumst. Viverra at turpis est odio lacinia suspendisse neque. Egestas sem pellentesque sed viverra elit dapibus ullamcorper sit. Nisl convallis mauris malesuada sit in sit nisl, lectus. Urna pellentesque orci nulla massa enim sed tristique. Sodales et in aliquet mauris netus ultricies. Etiam suscipit vel arcu vestibulum sit amet, sed. Sodales quis sapien dignissim ullamcorper. At turpis est in sed est, velit, amet, mollis. Porttitor augue mi amet, risus, malesuada porta. Semper sed ac amet, diam eleifend sed. Mauris donec dignissim adipiscing scelerisque urna amet enim sed. Volutpat auctor egestas ornare mattis consectetur mauris, cursus id. Venenatis tortor leo nam tincidunt vestibulum vel.",
              style: labelTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}
