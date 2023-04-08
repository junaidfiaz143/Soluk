import 'dart:io';

import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImageContainer extends StatelessWidget {
  final String path;
  final Function onClose;
  final double? height;
  final bool? isCloseShown;
  final bool? dottedBorders;

  const ImageContainer(
      {Key? key,
      required this.path,
      required this.onClose,
      this.height,
      this.isCloseShown,
      this.dottedBorders = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: path.contains("http")
              ? CachedNetworkImage(
                  height: height ?? HEIGHT_5 * 2,
                  width: double.maxFinite,
                  imageUrl: path,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        color: PRIMARY_COLOR, value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : Image(
                  height: HEIGHT_5 * 2,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  image: FileImage(File(path))),
        ),
        Visibility(
          visible: isCloseShown == null || isCloseShown == true,
          child: Positioned(
            top: 1.h,
            right: 3.w,
            child: GestureDetector(
              onTap: () => onClose(),
              child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5)),
                  child: const Icon(
                    Icons.close,
                    size: 15,
                    color: TOGGLE_BACKGROUND_COLOR,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
