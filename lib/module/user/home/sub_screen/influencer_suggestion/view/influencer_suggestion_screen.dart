import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/user/home/sub_screen/influencer_suggestion/bloc/influencer_suggestion_cubit.dart';
import 'package:app/module/user/widgets/dialog_utils.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../services/localisation.dart';

class InfluencerSuggestionScreen extends StatefulWidget {
  GetInfluencerModel? influencerInfo;

  InfluencerSuggestionScreen({Key? key, this.influencerInfo}) : super(key: key);

  @override
  State<InfluencerSuggestionScreen> createState() =>
      _InfluencerSuggestionScreenState();
}

class _InfluencerSuggestionScreenState
    extends State<InfluencerSuggestionScreen> {
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(defaultSize.screenHeight * .11),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: defaultSize.screenHeight * .04,
                    ),
                    child: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Center(
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 7,
                              bottom: 0,
                              child: Text(
                                widget.influencerInfo?.responseDetails?.userInfo?.fullname??"",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                // style: headingTextStyle(context),
                                style: subTitleTextStyle(context),
                              ),
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SolukBackButton(
                                  callback: () {},
                                ),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: HORIZONTAL_PADDING,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: ClipOval(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CachedNetworkImage(
                      imageUrl:
                          widget.influencerInfo?.responseDetails?.imageUrl ??
                              "",
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            color: PRIMARY_COLOR,
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SB_1H,
                SalukTextField(
                  maxLines: 13,
                  textEditingController: _descriptionController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
                  ],
                  hintText: 'What would you like to see?',
                  labelText: "Suggestions",
                  onChange: (_) {
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: SalukBottomButton(
            isButtonDisabled:
                _descriptionController.text.isEmpty ? true : false,
            title: "Submit",
            callback: () async {
              bool status = await BlocProvider.of<InfluencerSuggestionCubit>(
                      context,
                      listen: false)
                  .postSuggestion(
                      widget.influencerInfo?.responseDetails?.userInfo?.id
                              .toString() ??
                          "",
                      _descriptionController.text);

              if (status) {
                DialogUtils().showSuccessMessageDialog(context,
                    title:
                        AppLocalisation.getTranslated(context, LKSuccessfully),
                    description: "You suggestions has been sent successfully.",
                    onDismiss: () {
                  navigatorKey.currentState?.pop();
                });
              } else {}
            },
          ),
        ),
      ),
    );
  }
}
