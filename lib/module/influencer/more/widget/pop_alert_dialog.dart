import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/pickers.dart';

Future<dynamic> popUpAlertDialog(
    BuildContext context, String title, String subTitle,
    {Function()? onGalleryTap,
    Function(CameraMediaType)? onCameraTap,
    CameraMediaType mediaType = CameraMediaType.BOTH,
    bool isProfile = false}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.41,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.5.h),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 7.w, right: 7.w, bottom: 1.2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                                radius: 13,
                                backgroundColor: const Color(0xFFe7e7e7),
                                child: Image(
                                  height: 2.h,
                                  image: const AssetImage(CLOSE),
                                )),
                          ),
                        ),
                        Text(
                          title,
                          style: headingTextStyle(context)!.copyWith(
                            fontSize: isProfile
                                ? defaultSize.screenWidth * .055
                                : defaultSize.screenWidth * .05,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          subTitle,
                          style: labelTextStyle(context)!.copyWith(
                            fontSize: defaultSize.screenWidth * .038,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            onGalleryTap!();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: const Color(0xFF498aee),
                                child: Image(
                                  height: 4.h,
                                  image: const AssetImage(
                                      'assets/images/gallery.png'),
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text(
                                'Choose from\nGallery',
                                style: labelTextStyle(context)!.copyWith(
                                  fontSize: defaultSize.screenWidth * .035,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (mediaType == CameraMediaType.BOTH) {
                              mediaTypeDialog(context, onButtonTap: (type) {
                                Navigator.pop(context);
                                onCameraTap!(type);
                              });
                            } else if (mediaType == CameraMediaType.IMAGE) {
                              Navigator.pop(context);
                              onCameraTap!(mediaType);
                            } else {
                              Navigator.pop(context);
                              onCameraTap!(mediaType);
                            }
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: const Color(0xFF498aee),
                                child: Image(
                                  height: 4.h,
                                  image: const AssetImage(
                                      'assets/images/camera.png'),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                'Open Camera',
                                style: labelTextStyle(context)!.copyWith(
                                  fontSize: defaultSize.screenWidth * .035,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

Future<dynamic> mediaTypeDialog(
  BuildContext context, {
  Function(CameraMediaType)? onButtonTap,
}) {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                            radius: 13,
                            backgroundColor: const Color(0xFFe7e7e7),
                            child: Image(
                              height: 2.h,
                              image: const AssetImage(CLOSE),
                            )),
                      ),
                    ),
                    Text(
                      'Do you want to capture?',
                      style: labelTextStyle(context)!.copyWith(
                        fontSize: defaultSize.screenWidth * .035,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onButtonTap?.call(CameraMediaType.VIDEO);
                          },
                          child: Text(
                            'Video',
                            style: labelTextStyle(context)!.copyWith(
                                fontSize: defaultSize.screenWidth * .035,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onButtonTap?.call(CameraMediaType.IMAGE);
                          },
                          child: Text(
                            'Image',
                            style: labelTextStyle(context)!.copyWith(
                                fontSize: defaultSize.screenWidth * .035,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
