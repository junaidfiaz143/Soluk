import 'dart:io';

import 'package:app/module/influencer/challenges/model/challenges_model.dart';
import 'package:app/module/influencer/challenges/view/challenges_detail_screen.dart';
import 'package:app/utils/nav_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/thumbnail.dart';
import '../../../../../res/color.dart';
import '../../../../../res/globals.dart';

class ChallengesCard extends StatefulWidget {
  const ChallengesCard(
      {Key? key, required this.challengesModel, required this.isApproved})
      : super(key: key);
  final ChallengesModel challengesModel;
  final bool isApproved;

  @override
  State<ChallengesCard> createState() => _ChallengesCardState();
}

class _ChallengesCardState extends State<ChallengesCard> {
  Color getColor(String status) {
    if (status.toLowerCase() == 'closed') {
      return const Color(0xff7EEE49);
    } else if (status.toLowerCase() == 'rejected') {
      return const Color(0xffF85656);
    }
    return const Color(0xff498AEE);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavRouter.push(
            context,
            ChallengeDetailScreen(
              challengeId: widget.challengesModel.id,
              isApproved: widget.isApproved,
            ));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            height: HEIGHT_4 + HEIGHT_4,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children: [
                (widget.challengesModel.mediaType == "Image")
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          height: HEIGHT_5 + HEIGHT_4,
                          width: WIDTH_5 * 3.2,
                          imageUrl: widget.challengesModel.imageUrl,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                color: PRIMARY_COLOR,
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          NavRouter.push(
                              context,
                              ChallengeDetailScreen(
                                challengeId: widget.challengesModel.id,
                                isApproved: widget.isApproved,
                              ));
                        },
                        child: FutureBuilder<String?>(
                            future:
                                getThumbnail(widget.challengesModel.imageUrl),
                            builder: (context, snapshot) {
                              print(snapshot.data ?? '');
                              return Container(
                                height: HEIGHT_5 + HEIGHT_4,
                                width: WIDTH_5 * 3.2,
                                decoration: (snapshot.data ?? null) == null
                                    ? BoxDecoration(
                                        borderRadius: BORDER_CIRCULAR_RADIUS)
                                    : BoxDecoration(
                                        borderRadius: BORDER_CIRCULAR_RADIUS,
                                        image: DecorationImage(
                                          image:
                                              FileImage(File(snapshot.data!)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                child: Center(
                                  child: (snapshot.data ?? null) == null
                                      ? CircularProgressIndicator(
                                          color: PRIMARY_COLOR,
                                        )
                                      : Icon(
                                          Icons.play_circle_fill,
                                          color: Colors.white,
                                          size: 4.h,
                                        ),
                                ),
                              );
                            }),
                      ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(widget.challengesModel.name,
                            style: labelTextStyle(context)?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: defaultSize.screenWidth * .042)),
                      ),
                      Text(widget.challengesModel.status,
                          style: TextStyle(
                              color: getColor(widget.challengesModel.status),
                              fontSize: 15)),
                    ],
                  ),
                ),
                // const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: WIDTH_2,
                ),
                SB_1W,
              ],
            ),
          ),
          SB_1H
        ],
      ),
    );
  }
}
