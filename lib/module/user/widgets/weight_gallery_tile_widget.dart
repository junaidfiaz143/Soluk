import 'package:app/res/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../res/globals.dart';

class WeightGalleryTile extends StatelessWidget {
  final String path;
  final Function onClose;
  final bool? isCloseShown;
  final bool? dottedBorders;
  final String weight;
  final String date;

  const WeightGalleryTile(
      {Key? key,
      required this.path,
      required this.onClose,
      this.isCloseShown,
      this.dottedBorders = false,
      required this.weight,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: path,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: CircularProgressIndicator(
                  color: PRIMARY_COLOR, value: downloadProgress.progress),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              children: [
                Text(weight,
                    style: labelTextStyle(context)?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Text(date,
                    style: labelTextStyle(context)?.copyWith(
                      fontSize: 8.sp,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Visibility(
              visible: isCloseShown == null || isCloseShown == true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => onClose(),
                    child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.8)),
                        child: const Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
