import 'package:app/module/influencer/more/model/suggestion_model.dart';
import 'package:app/module/influencer/more/view/suggestion_details.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/color.dart';

class SuggestionTile extends StatelessWidget {
  final Data suggestion;

  const SuggestionTile({Key? key, required this.suggestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SuggestionDetails(suggestion: suggestion)));
        // navigatorKey.currentState?.pushNamed(SuggestionDetails.id);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  spreadRadius: 1.0,
                  blurRadius: 10.0,
                ),
              ],
              borderRadius: BORDER_CIRCULAR_RADIUS,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: defaultSize.screenWidth * .03,
              vertical: defaultSize.screenHeight * .01,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${suggestion.feedback}',
                        // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam ut eget sed amet non. Dictumst mauris . . . ",
                        style: labelTextStyle(context)?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: defaultSize.screenWidth * .032,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: defaultSize.screenHeight * .01,
                      ),
                      Row(
                        children: [
                          Container(
                            width: HEIGHT_3,
                            height: HEIGHT_3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60.0),
                              child: (suggestion.userFeedbackModel == null ||
                                      suggestion.userFeedbackModel?.imageUrl ==
                                          null ||
                                      suggestion.userFeedbackModel!.imageUrl!
                                          .contains("www"))
                                  ? SvgPicture.asset(
                                      'assets/svgs/placeholder.svg',
                                      width: 50,
                                      height: 50,
                                    )
                                  : CachedNetworkImage(
                                      width: 50,
                                      height: 50,
                                      imageUrl:
                                          '${suggestion.userFeedbackModel?.imageUrl}',
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            color: PRIMARY_COLOR,
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                            ),
                          ),
                          SB_1W,
                          Text(
                            suggestion.userFeedbackModel?.fullname ?? "N/A",
                            style: labelTextStyle(context)?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: defaultSize.screenWidth * .032,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: defaultSize.screenHeight * .01,
                      ),
                    ],
                  ),
                ),
                SB_1W,
                Icon(
                  Icons.arrow_forward_ios,
                  size: defaultSize.screenHeight * .02,
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultSize.screenHeight * .02,
          ),
        ],
      ),
    );
  }
}
