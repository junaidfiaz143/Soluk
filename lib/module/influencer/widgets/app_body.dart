import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBody extends StatelessWidget {
  final String title;
  final bool isWithLogo;
  final Widget body;
  final String? logo;
  final VoidCallback? callback;
  final bool showBackButton;
  final double titleHeight;
  final bool applyPaddingH;
  final bool? result;
  final Color bgColor;

  const AppBody({Key? key,
    required this.title,
    required this.body,
    this.isWithLogo = false,
    this.logo,
    this.callback,
    this.showBackButton = true,
    this.titleHeight = 20,
    this.result,
    this.applyPaddingH = true,
    this.bgColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: SafeArea(
        child: Container(
          color: bgColor,
          padding: applyPaddingH
              ? EdgeInsets.symmetric(
            horizontal: HORIZONTAL_PADDING,
          ) +
              EdgeInsets.only(
                top: defaultSize.screenHeight * .04,
              )
              : EdgeInsets.only(top: defaultSize.scaleHeight * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title == AppLocalisation.getTranslated(context, LKSignUp))
                const SizedBox()
              else
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: applyPaddingH ? 0 : HORIZONTAL_PADDING),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Visibility(
                        visible: showBackButton,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: SolukBackButton(
                          callback: () {
                            if (callback != null) {
                              callback?.call();
                            }
                          },
                          result:result,
                        ),
                      ),
                      if (!isWithLogo)
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            // style: headingTextStyle(context),
                            style: subTitleTextStyle(context),
                          ),
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (logo != null && logo!.contains("svg"))
                              SvgPicture.asset(logo!)
                            else
                              SizedBox(
                                height: defaultSize.screenHeight * .1,
                                width: defaultSize.screenHeight * .1,
                                child: Image.asset(
                                  logo!,
                                ),
                              ),
                            Text(
                              title,
                              style: subTitleTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenHeight * .02,
                              ),
                            )
                          ],
                        ),
                      // const Spacer(
                      //   flex: 5,
                      // ),
                    ],
                  ),
                ),
              if (title.isNotEmpty) SizedBox(height: titleHeight),
              Expanded(
                child: body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
