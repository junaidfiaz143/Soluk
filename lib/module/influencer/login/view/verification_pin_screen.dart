import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPinScreen extends StatefulWidget {
  static const String id = "/verification_screen";

  const VerificationPinScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VerificationPinScreen> createState() => _VerificationPinScreenState();
}

class _VerificationPinScreenState extends State<VerificationPinScreen> {
  final _formKey = GlobalKey<FormState>();

  String pin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _onDataLoaded(),
      ),
    );
  }

  _onDataLoaded() {
    Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return AppBody(
      title: '',
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: defaultSize.screenHeight * .2,
                  width: defaultSize.screenHeight * .2,
                  child: Image.asset(
                    APP_LOGO,
                    scale: defaultSize.scaleWidth,
                  ),
                ),
              ),
              SB_3H,
              Text(
                AppLocalisation.getTranslated(context, LKVerificationEmail),
                style: headingTextStyle(context),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: AppLocalisation.getTranslated(
                            context, LKEnterCodeEmail),
                        style: labelTextStyle(context)),
                    TextSpan(
                      text: data['email'],
                      style: labelTextStyle(context)
                          ?.copyWith(color: PRIMARY_COLOR),
                    ),
                  ],
                ),
              ),
              SB_5H,
              PinCodeTextField(
                appContext: context,
                length: 6,
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                onChanged: (value) {
                  setState(() {
                    pin = value;
                  });
                },
                onCompleted: (value) {
                  LoginRepository.verifyOTP(context, pin);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please fill the fields.";
                  } else if (value.length < 6) {
                    return "Please enter your pin.";
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BORDER_CIRCULAR_RADIUS,
                  selectedColor: PRIMARY_COLOR,
                  activeFillColor: PIN_FIELD_COLOR,
                  inactiveFillColor: PIN_FIELD_COLOR,
                  activeColor: PIN_FIELD_COLOR,
                  disabledColor: PIN_FIELD_COLOR,
                  inactiveColor: PIN_FIELD_COLOR,
                  selectedFillColor: PIN_FIELD_COLOR,
                  fieldHeight: defaultSize.screenHeight * .06,
                  fieldWidth: defaultSize.screenHeight * .06,
                ),
                cursorColor: PRIMARY_COLOR,
                keyboardType: TextInputType.number,
              ),
              SB_1H,
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                              AppLocalisation.getTranslated(context, LKOTPReq),
                          style: labelTextStyle(context)),
                      TextSpan(
                        text: " " +
                            AppLocalisation.getTranslated(context, LKResend),
                        style: labelTextStyle(context)
                            ?.copyWith(color: PRIMARY_COLOR),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Map<String, dynamic> data = ModalRoute.of(context)
                                ?.settings
                                .arguments as Map<String, dynamic>;
                            if (data['password'] != null) {
                              LoginRepository.resendOTP(context);
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SB_5H,
              SalukGradientButton(
                title: AppLocalisation.getTranslated(context, LKVerify),
                onPressed: () {
                  LoginRepository.verifyOTP(context, pin,/*data['password']*/);
                },
                buttonHeight: HEIGHT_4,
                dim: pin.isNotEmpty ? false : true,
              ),
              SB_3H,
            ],
          ),
        ),
      ),
    );
  }
}
