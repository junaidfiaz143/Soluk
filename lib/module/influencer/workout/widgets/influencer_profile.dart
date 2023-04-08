import 'dart:io';

import 'package:app/core/thumbnail.dart';
import 'package:app/module/influencer/workout/bloc/tags_bloc/tagsbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/influencer/workout/view/video_play_screen.dart';
import 'package:app/module/influencer/workout/widgets/add_influencer_detail.dart';
import 'package:app/module/influencer/workout/widgets/add_tags_dialog.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/workout/widgets/tag.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../widgets/workout_tile_video_thumbnail.dart';

class InfluencerProfile extends StatefulWidget {
  final ValueChanged<String> valueChanged;
  final GetInfluencerModel? influencerInfo;
  const InfluencerProfile(
      {Key? key, required this.influencerInfo, required this.valueChanged})
      : super(key: key);

  @override
  State<InfluencerProfile> createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends State<InfluencerProfile> {
  List<String> titles = [
    "A Brief Intro",
    "Goals",
    "Credentials",
    "Requirements",
  ];

  List<int> _selectedTags = [];
  @override
  Widget build(BuildContext context) {
    TagsblocCubit _tagsBloc = BlocProvider.of(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Center(
            child: widget.influencerInfo?.responseDetails?.imageUrl == null
                ? Container(
                    height: HEIGHT_5,
                    width: HEIGHT_5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: Icon(
                      Icons.person,
                      size: HEIGHT_3,
                      color: Colors.grey[400],
                    ))
                // : CircleAvatar(
                //     radius: 45,
                //     backgroundImage: NetworkImage(
                //         widget.influencerInfo?.responseDetails?.imageUrl ?? ''),
                //     // backgroundImage: FileImage(File(widget.hiveInfo.profileImage!)),
                //   ),
                : Container(
                    width: 25.w,
                    height: 25.w,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        imageUrl:
                            widget.influencerInfo!.responseDetails!.imageUrl ??
                                "",
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              color: PRIMARY_COLOR,
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
          ),
          // child: Center(
          //   child: Container(
          //       height: HEIGHT_5,
          //       width: HEIGHT_5,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.grey[300],
          //       ),
          //       child: Icon(
          //         Icons.person,
          //         size: HEIGHT_3,
          //         color: Colors.grey[400],
          //       )
          //   ),
          // ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ((widget.influencerInfo?.responseDetails?.introUrl) != null)
                ? InkWell(
                    onTap: () {
                      if ((widget.influencerInfo?.responseDetails?.introUrl) !=
                          null) {
                        print(widget.influencerInfo?.responseDetails?.introUrl);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => VideoPlayScreen(
                        //             videoPath: widget.influencerInfo!
                        //                 .responseDetails!.introUrl!)));

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return VideoPlayScreen(
                                asDialog: true,
                                videoPath: widget
                                    .influencerInfo!.responseDetails!.introUrl!,
                              );
                            });
                      }
                    },
                    // child: FutureBuilder<String?>(
                    //     future: getThumbnail(
                    //         widget.influencerInfo?.responseDetails?.introUrl ??
                    //             ''),
                    //     builder: (context, snapshot) {
                    //       print(snapshot.data ?? '');
                    //       return Container(
                    //         height: HEIGHT_5 * 1,
                    //         width: HEIGHT_5 * 1.2,
                    //         decoration: (snapshot.data ?? null) == null
                    //             ? BoxDecoration(
                    //                 borderRadius: BORDER_CIRCULAR_RADIUS)
                    //             : BoxDecoration(
                    //                 borderRadius: BORDER_CIRCULAR_RADIUS,
                    //                 image: DecorationImage(
                    //                   image: FileImage(File(snapshot.data!)),
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               ),
                    //         child: Center(
                    //           child: Icon(
                    //             Icons.play_circle_fill,
                    //             color: Colors.white,
                    //             size: 4.h,
                    //           ),
                    //         ),
                    //       );
                    //     }),

                    child: Container(
                      height: HEIGHT_5 * 1,
                      width: HEIGHT_5 * 1.2,
                      child: WorkoutTileVideoThumbnail(
                          decorated: true,
                          playBack: false,
                          url: widget
                                  .influencerInfo?.responseDetails?.introUrl ??
                              ''),
                    ),
                  )
                : Container(
                    height: HEIGHT_5 * 1,
                    width: HEIGHT_5 * 1.2,
                  ),
            SB_1W,
            Expanded(
              child: Text(
                widget.influencerInfo?.responseDetails?.workTitle ?? '',
                // widget.hiveInfo.workoutTitle!,
                style: subTitleTextStyle(context)!.copyWith(
                  fontSize: defaultSize.screenWidth * .05,
                ),
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddInfluencerDetail(
                            influencerInfo: widget.influencerInfo),
                      ),
                    );
                    widget.valueChanged('');
                  },
                  splashColor: Colors.black26,
                  child: Container(
                    width: WIDTH_5,
                    height: WIDTH_5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.edit,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: defaultSize.screenHeight * .01),
                Text(
                  "Edit",
                  style: labelTextStyle(context)?.copyWith(
                    fontSize: WIDTH_1,
                    color: PRIMARY_COLOR,
                  ),
                )
              ],
            ),
          ],
        ),
        SB_1H,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tags",
              style: headingTextStyle(context)!.copyWith(fontSize: 18.sp),
            ),
            SB_1H,
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children:
                  // _selectedTags.isNotEmpty?
// List.generate(_selectedTags.length, (index) => Tag(text: text, callback: callback))
                  // :
                  List.generate(
                widget.influencerInfo?.responseDetails?.tags?.length ?? 0,
                (index) {
                  return Tag(
                      text: widget.influencerInfo?.responseDetails?.tags![index]
                              .name ??
                          '',
                      callback: () {
                        // addTagsDialog(context, _tagsBloc.state.tagsModel,
                        //     selectedTags: (val) {
                        //   setState(() {
                        //     _selectedTags = val;
                        //   });
                        // });
                      });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: defaultSize.screenHeight * .01,
        ),
        const Divider(
          thickness: 1,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: titles.length,
          itemBuilder: (_, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SB_1H,
                Text(
                  titles[index],
                  style: headingTextStyle(context)!.copyWith(fontSize: 18.sp),
                ),
                SizedBox(
                  height: defaultSize.screenHeight * .01,
                ),
                Text(
                  index == 0
                      ? widget.influencerInfo?.responseDetails?.intro ?? ''
                      : index == 1
                          ? widget.influencerInfo?.responseDetails?.goals ?? ''
                          : index == 2
                              ? widget.influencerInfo?.responseDetails
                                      ?.credentials ??
                                  ''
                              : widget.influencerInfo?.responseDetails
                                      ?.requirements ??
                                  '',
                  // index == 0 ? widget.hiveInfo.intro! : index == 1 ? widget.hiveInfo.goals! : index == 2 ? widget.hiveInfo.credential! : widget.hiveInfo.requirements!,
                  style: labelTextStyle(context)!.copyWith(
                    fontSize: 10.5.sp,
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            );
          },
        ),
        SB_1H,
      ],
    );
  }
}
