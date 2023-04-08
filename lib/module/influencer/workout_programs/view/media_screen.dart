import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/workout_programs/widgets/video_player_widget.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class MediaScreen extends StatefulWidget {
  static const id = 'MediaScreen';

  final String videoUrl;
  final String title;
  bool mediaTypeisVideo = true;
  bool? mediaTypeisLocalVideo = false;
  File? file;
  MediaScreen(
      {Key? key,
      required this.videoUrl,
      required this.title,
      required this.mediaTypeisVideo,
      this.mediaTypeisLocalVideo,
      this.file})
      : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DROPDOWN_BORDER_COLOR,
      body: AppBody(
        title: '',
        bgColor: Color(0xFFC4C4C4),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              widget.title,
              style: subTitleTextStyle(context)?.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            widget.mediaTypeisVideo == true
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox(
                    height: 20,
                  ),
            widget.mediaTypeisVideo == true
                ? Container(
                    height: defaultSize.screenHeight * 0.3,
                    child: VideoPlayerWidget(
                      url: widget.videoUrl,
                      file: widget.file,
                      mediaTypeisLocalVideo: widget.mediaTypeisLocalVideo,
                    ),
                  )
                : Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          width: double.maxFinite,
                          height: defaultSize.screenHeight * 0.55,
                          imageUrl: widget.videoUrl,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                color: PRIMARY_COLOR, value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset('assets/svgs/cross_icon.svg',
                                height: 25, width: 25),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
