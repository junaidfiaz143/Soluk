import 'package:app/res/constants.dart';
import 'package:app/services/localisation.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:flutter/material.dart';

import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';

class SalukBottomButton extends StatefulWidget {
  final String title;
  final VoidCallback callback;
  final bool isButtonDisabled;
  final bool isWithTextField;
  const SalukBottomButton({
    Key? key,
    required this.title,
    required this.callback,
    this.isButtonDisabled = true,
    this.isWithTextField = false,
  }) : super(key: key);

  @override
  State<SalukBottomButton> createState() => _SalukBottomButtonState();
}

class _SalukBottomButtonState extends State<SalukBottomButton> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isWithTextField
          ? HEIGHT_5 + HEIGHT_5 + HEIGHT_2
          : HEIGHT_5 + HEIGHT_2,
      width: double.maxFinite,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: HORIZONTAL_PADDING,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isWithTextField)
              SizedBox(
                height: defaultSize.screenHeight * .02,
              ),
            if (widget.isWithTextField)
              Text(
                AppLocalisation.getTranslated(context, LKHowCanHelp),
                style: subTitleTextStyle(context),
              ),
            if (widget.isWithTextField)
              SizedBox(
                height: defaultSize.screenHeight * .02,
              ),
            if (widget.isWithTextField)
              SalukTextField(
                textEditingController: _controller,
                hintText: AppLocalisation.getTranslated(context, LKAddText),
                labelText: "",
              ),
            if (widget.isWithTextField)
              SizedBox(
                height: defaultSize.screenHeight * .02,
              ),
            SalukGradientButton(
              title: widget.title,
              dim: widget.isButtonDisabled,
              onPressed: () {
                print('???????????????');
                widget.callback();
              },
              buttonHeight: HEIGHT_4,
            ),
            SizedBox(
              height: defaultSize.screenHeight * .02,
            ),
          ],
        ),
      ),
    );
  }
}
