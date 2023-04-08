import 'package:app/module/influencer/more/view/suggestion_details.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class SuggestionTile extends StatelessWidget {
  const SuggestionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState?.pushNamed(SuggestionDetails.id);
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
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam ut eget sed amet non. Dictumst mauris . . . ",
                        style: labelTextStyle(context)?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: defaultSize.screenWidth * .032,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: defaultSize.screenHeight * .01,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: defaultSize.screenWidth * .05,
                            child: Icon(
                              Icons.person,
                              size: defaultSize.screenWidth * .05,
                            ),
                          ),
                          SB_1W,
                          Text(
                            "Jhon Deo",
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
