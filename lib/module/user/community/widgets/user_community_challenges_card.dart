import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/thumbnail.dart';
import '../../../../res/globals.dart';

class UserCommunityChallengesCard extends StatelessWidget {
  UserCommunityChallengesCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.assetType,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String assetType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: assetType == "Image"
              ? Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(imageUrl),
                  ),
                ))
              : FutureBuilder<String?>(
                  future: getThumbnail(imageUrl),
                  builder: (context, snapshot) {
                    print(snapshot.data ?? '');
                    return Container(
                      decoration: (snapshot.data ?? null) == null
                          ? BoxDecoration(borderRadius: BORDER_CIRCULAR_RADIUS)
                          : BoxDecoration(
                              borderRadius: BORDER_CIRCULAR_RADIUS,
                              image: DecorationImage(
                                image: FileImage(File(snapshot.data!)),
                                fit: BoxFit.cover,
                              ),
                            ),
                    );
                  }),

          /*decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(imageUrl),
            ),
          ),*/
        ),
        Positioned(
          bottom: 0,
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.black.withOpacity(0.3)),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 1,
          child: Container(
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
        if (assetType != "Image")
          Positioned.fill(
            child: Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: 4.h,
            ),
          ),
      ],
    );
  }
}
