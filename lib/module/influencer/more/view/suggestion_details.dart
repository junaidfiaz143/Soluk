import 'package:app/module/influencer/more/model/suggestion_model.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/color.dart';

class SuggestionDetails extends StatelessWidget {
  static const String id = "/suggestion_details";
  final Data? suggestion;

  const SuggestionDetails({Key? key, this.suggestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKSuggestionDetails),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SB_1H,
              Row(
                children: [
                  Container(
                    width: HEIGHT_3,
                    height: HEIGHT_3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: (suggestion?.userFeedbackModel == null ||
                              suggestion?.userFeedbackModel?.imageUrl == null ||
                              suggestion?.userFeedbackModel!.imageUrl!
                                      .contains("www") ==
                                  true)
                          ? SvgPicture.asset(
                              'assets/svgs/placeholder.svg',
                              width: 50,
                              height: 50,
                            )
                          : CachedNetworkImage(
                              width: 50,
                              height: 50,
                              imageUrl:
                                  '${suggestion?.userFeedbackModel?.imageUrl}',
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
                    ),
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.transparent,
                  //   maxRadius: defaultSize.screenWidth * .07,
                  //   child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(30),
                  //       child: (suggestion?.userFeedbackModel == null || suggestion?.userFeedbackModel?.imageUrl == null || suggestion!.userFeedbackModel!.imageUrl!.contains("www"))
                  //           ? SvgPicture.asset(PLACEHOLDER)
                  //           : Image.network('${suggestion!.userFeedbackModel?.imageUrl}')),
                  // ),
                  SB_1W,
                  Text(
                    '${suggestion?.userFeedbackModel?.fullname ?? "no name"}',
                    style: labelTextStyle(context)?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SB_1H,
              Text(
                '${suggestion?.feedback}',
                // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tincidunt non in accumsan elementum risus, amet. Suspendisse a adipiscing nunc habitant varius turpis. Nunc risus nulla amet, blandit amet ligula amet. Quam lorem lorem faucibus mauris nisl, vitae imperdiet amet. In nunc neque, ultrices at quis eget pretium cras. Blandit eget sed pellentesque justo, mauris magna sapien suscipit turpis. At blandit diam adipiscing id nec est sit.",
                style: labelTextStyle(context)?.copyWith(
                  fontSize: defaultSize.screenWidth * .038,
                ),
              ),
              SB_1H,
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '${suggestion?.createdDate}',
                  style: hintTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .038,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
