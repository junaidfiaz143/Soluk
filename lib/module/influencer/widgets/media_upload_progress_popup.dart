import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repo/repository/web_service.dart';

class MediaUploadProgressPopup extends StatelessWidget {
  final AsyncSnapshot<ProgressFile> snapshot;

  const MediaUploadProgressPopup({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          defaultSize.screenHeight * .03,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: defaultSize.screenHeight * .01,
          ),
          CircularProgressIndicator(color: PRIMARY_COLOR),
          SB_1H,
          ((snapshot.data?.done ?? 0) != 0)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Uploading Media ',
                      style: labelTextStyle(context)?.copyWith(
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      '${(((snapshot.data?.done ?? 1) / (snapshot.data?.total ?? 1)) * 100).toInt()} % ',
                      style: labelTextStyle(context)?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              : Text(
                  "Please wait...",
                  style: labelTextStyle(context)?.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
                ),
        ],
      ),
    );
  }
}
