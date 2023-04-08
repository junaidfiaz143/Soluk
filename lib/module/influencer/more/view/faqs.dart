import 'package:app/module/influencer/more/model/faq_model.dart';
import 'package:app/module/influencer/more/widget/faq_expansion_tile.dart';
import 'package:app/module/influencer/views_analytics/data/views_dummy_data.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FAQs extends StatefulWidget {
  static const String id = "/more_faqs";

  const FAQs({Key? key}) : super(key: key);

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getViewsExpansionSummary();

    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKFAQ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: defaultSize.screenHeight * .03,
              ),
              Text(
                AppLocalisation.getTranslated(context, LKQuestions),
                style: subTitleTextStyle(context),
              ),
              SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: faqList.length,
                itemBuilder: (BuildContext context, int index) {
                  return faqExpansionTileWidget(context, faqList[index].title,
                      faqList[index].description);
                },
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(top: defaultSize.screenHeight * .06,),
              //       child: Text(
              //         AppLocalisation.getTranslated(context, LKHowCanHelp),
              //         style: subTitleTextStyle(context),
              //       ),
              //     ),
              //     SizedBox(
              //       height: defaultSize.screenHeight * .02,
              //     ),
              //     SalukTextField(
              //       textEditingController: _controller,
              //       hintText: AppLocalisation.getTranslated(context, LKQuestions),
              //       labelText: "",
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(top: 2.h),
              //       child: SalukGradientButton(
              //         title: 'Submit',
              //         dim: false,
              //         onPressed: () {
              //
              //         },
              //         buttonHeight: HEIGHT_4,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
