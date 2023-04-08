import 'package:app/module/user/profile/sub_screen/in_active_subscription/view/in_active_subcription_view.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/top_appbar_row.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ActiveSubscriptionScreen extends StatefulWidget {
  @override
  _ActiveSubscriptionScreenState createState() =>
      _ActiveSubscriptionScreenState();
}

class _ActiveSubscriptionScreenState extends State<ActiveSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: Column(
        children: [
          TopAppbarRow(
            title: 'Subscription',
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: defaultSize.screenHeight * 0.15,
                  child: Image.asset(APP_LOGO),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: defaultSize.screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Active Suscription",
                        style: subTitleTextStyle(context)!
                            .copyWith(fontSize: 15.sp),
                      ),
                      Spacer(),
                      Container(
                        height: 8,
                        width: 8,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.blue, shape: BoxShape.circle),
                      ),
                      Text("Monthly", style: hintTextStyle(context)),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   width: defaultSize.screenWidth * 0.9,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Your subscription is Renewing",
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   width: defaultSize.screenWidth * 0.9,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "On 18/07/2022 (30 Days)",
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: defaultSize.screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 18.0, top: 28.0, right: 18.0, bottom: 18.0),
                      //   child: Row(
                      //     children: [
                      //       TextView(
                      //         "Upgrade to Annual",
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 14,
                      //       ),
                      //       Spacer(),
                      //       Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   width: defaultSize.screenWidth,
                      //   height: 1,
                      //   color: Colors.grey[300],
                      // ),
                      Padding(
                        // padding: const EdgeInsets.only(
                        //     left: 18.0, top: 18.0, right: 18.0, bottom: 28.0),
                        padding: const EdgeInsets.all(28.0),
                        child: Row(
                          children: [
                            TextView(
                              "Need Help?",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded, size: 16),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 InActiveSubscriptionScreen()));
                //   },
                //   child: SizedBox(
                //     width: defaultSize.screenWidth * 0.7,
                //     child: Row(
                //       children: [
                //         SizedBox(
                //           height: 20,
                //           child: Text(
                //             "Cancel Subscription",
                //             style: TextStyle(color: Colors.red),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
