import 'package:app/module/influencer/widgets/saluk_transparent_button_custom_title.dart';
import 'package:flutter/material.dart';

import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';

class WorkoutTile extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback callback;
  final bool isChallenges;
  final String? firstValue;
  final String? secondValue;

  WorkoutTile({
    Key? key,
    required this.image,
    required this.title,
    required this.callback,
    this.firstValue,
    this.secondValue,
    this.isChallenges = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        width: double.maxFinite,
        height: HEIGHT_5 * 2.2,
        decoration: BoxDecoration(
          borderRadius: BORDER_CIRCULAR_RADIUS * 2,
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: HORIZONTAL_PADDING,
            vertical: HORIZONTAL_PADDING,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        SalukTransparentButtonCustomTitle(
                          title: firstValue == null
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: Colors.white,
                                  ))
                              : Text(
                                  "${firstValue ?? ' '}",
                                  style: labelTextStyle(context)?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                          subTitle: isChallenges ? ' Approved' : ' Published',
                          onPressed: () {},
                          buttonHeight: HEIGHT_2 * 1.1,
                          buttonWidth: HEIGHT_5 * 1.3,
                          borderRadius: BorderRadius.circular(
                            defaultSize.screenWidth * .02,
                          ),
                          style: labelTextStyle(context)?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                          linearGradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.5),
                            ],
                          ),
                        ),
                        SB_1W,
                        SalukTransparentButtonCustomTitle(
                          title: secondValue == null
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1, color: Colors.white))
                              : Text(
                                  "${secondValue ?? ' '}",
                                  style: labelTextStyle(context)?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                          subTitle:
                              isChallenges ? ' UnApproved' : ' UnPublished',
                          onPressed: () {},
                          buttonHeight: HEIGHT_2 * 1.1,
                          buttonWidth: HEIGHT_5 * 1.4,
                          borderRadius: BorderRadius.circular(
                            defaultSize.screenWidth * .02,
                          ),
                          style: labelTextStyle(context)?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                          linearGradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
