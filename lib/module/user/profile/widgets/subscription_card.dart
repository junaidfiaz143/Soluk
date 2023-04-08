import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/user/profile/sub_screen/active_subscription/view/active_subcription_screen.dart';
import 'package:app/module/user/profile/sub_screen/in_active_subscription/view/in_active_subcription_view.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../../../influencer/widgets/info_dialog_box.dart';
import 'user_profile_tile.dart';

class SubscriptionCard extends StatelessWidget {
  final bool? isSubscribed;
  final Function()? call;
  const SubscriptionCard(
      {Key? key, required this.isSubscribed, required this.call})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext _context, StateSetter setState) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            UserProfileTile(
              iconPath: 'assets/images/saluk_logo.png',
              text: isSubscribed != null && isSubscribed!
                  ? 'Active, Monthly'
                  : "Not active yet",
              isSubscriptionCard: isSubscribed,
              onPressed: call,
              // onPressed: () async {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               isSubscribed != null && isSubscribed!
              //                   ? ActiveSubscriptionScreen()
              //                   : InActiveSubscriptionScreen())).then((value) {
              //     solukLog(
              //         logMsg: value, logDetail: "inside subscription_card");
              //     if (value != null && value == true) {
              //       setState(() {});
              //       LoginRepository.getUserSubsciption(context);
              //       showDialog(
              //           context: context,
              //           builder: (BuildContext context) {
              //             return InfoDialogBox(
              //               icon: 'assets/images/tick_ss.png',
              //               title: AppLocalisation.getTranslated(
              //                   context, LKCongratulations),
              //               description:
              //                   "You have successfully subscribed to Soluk",
              //               onPressed: () async {
              //                 // LoginRepository.getUserSubsciption();
              //                 Navigator.pop(context);
              //                 // Navigator.pop(context, true);
              //               },
              //             );
              //           });
              //     }
              //   });
              // },
            ),
          ],
        ),
      );
    });
  }
}
