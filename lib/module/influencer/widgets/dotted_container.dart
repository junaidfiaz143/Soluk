import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../res/constants.dart';
import '../../../services/localisation.dart';

class MediaTypeSelectionCard extends StatelessWidget {
  final Widget? child;
  final VoidCallback? callback;
  final String textTag;

  const MediaTypeSelectionCard({
    Key? key,
    this.child,
    this.callback,
    this.textTag = LKUploadPreviewImVd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback?.call();
      },
      child: DottedBorder(
        radius: const Radius.circular(14),
        dashPattern: const [5, 5],
        color: PRIMARY_COLOR,
        borderType: BorderType.RRect,
        child: Container(
          height: HEIGHT_5 * 2,
          width: double.maxFinite,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: child ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle,
                    size: WIDTH_5,
                    color: PRIMARY_COLOR,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalisation.getTranslated(context, textTag),
                    textAlign: TextAlign.center,
                    style: labelTextStyle(context)
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
