import 'dart:ui';

import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class InfoDialogBox extends StatefulWidget {
  static const String id = '/InfoDialogBox';
  // final Widget contentWidget;
  final String title;
  final String description;
  var onPressed;
  var icon;
  InfoDialogBox(
      {Key? key, required this.title, required this.description, this.onPressed, this.icon})
      : super(key: key);

  @override
  State<InfoDialogBox> createState() => _InfoDialogBoxState();
}

class _InfoDialogBoxState extends State<InfoDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(color: Colors.transparent)),
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: HORIZONTAL_PADDING + HORIZONTAL_PADDING / 2,
                        vertical: 30,
                      ),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          if (widget.icon != null)
                            Image.asset(
                              widget.icon,
                              scale: 5,
                            ),
                          Text(
                            widget.title,
                            style: subTitleTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          SB_1H,
                          Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: labelTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          SB_1H,
                          SalukGradientButton(
                            title: AppLocalisation.getTranslated(context, LKDone),
                            onPressed: widget.onPressed,
                            buttonHeight: HEIGHT_3,
                            dim: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset('assets/svgs/cross_icon.svg', height: 25, width: 25),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(color: Colors.transparent)),
            ),
          ],
        ),
      ),
    );
  }
}
