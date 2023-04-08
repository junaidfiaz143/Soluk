import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/dependency_injection.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class FeedbackScreen extends StatefulWidget {
  static const String id = "/more_feedback";

  FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Stack(
              children: [
                SolukBackButton(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      SvgPicture.asset('assets/svgs/feedback.svg'),
                      SizedBox(height: 10),
                      Text(AppLocalisation.getTranslated(context, LKFeedback),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16))
                    ],
                  ),
                ),
              ],
            ),
            SB_1H,
            Text(
              AppLocalisation.getTranslated(context, LKWriteFeedback),
              style: headingTextStyle(context)!.copyWith(fontSize: 11.sp),
            ),
            SizedBox(
              height: 1.6.h,
            ),
            SalukTextField(
              textEditingController: _feedbackTextEditingController,
              hintText: AppLocalisation.getTranslated(context, LKTextHere),
              labelText: AppLocalisation.getTranslated(context, LKText),
              maxLines: 8,
              onChange: (_) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
          title: AppLocalisation.getTranslated(context, LKSubmit),
          isButtonDisabled:
              _feedbackTextEditingController.text.isNotEmpty ? false : true,
          callback: () {
            if (_feedbackTextEditingController.text.isNotEmpty) {
              sl.get<WebServiceImp>().callPostAPI(
                endPoint: "api/user/add-user-feedback",
                isAuthTokenRequired: true,
                body: {"feedback": _feedbackTextEditingController.text},
              ).then((value) {
                print(value.status);
                if (value == value.data) return;
                if (value.status == APIStatus.success) {
                  showSnackBar(context, "Feedback sent successfully",
                      backgroundColor: Colors.black);
                  _feedbackTextEditingController.clear();
                } else {
                  invalidDataSnackBar(context, value.data['responseCode']);
                }
              });
            } else {
              showSnackBar(context, "Please write some text.");
            }
          },
        ),
      ),
    );
  }
}
