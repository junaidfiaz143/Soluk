
import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/string_manipulator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = "/forgot_password_screen";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController? _usernameTextEditingController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _onDataLoaded()),
    );
  }

  _onDataLoaded() {
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
                AppLocalisation.getTranslated(context, LKForgotPassword),
                style: headingTextStyle(context),
              ),
              SB_1H,
              Text(
                AppLocalisation.getTranslated(context, LKReceivePinEmail),
                style: labelTextStyle(context),
              ),
              SB_1H,
              SalukTextField(
                textEditingController: _usernameTextEditingController,
                hintText: '',
                onValidator: (value) {
                  return StringManipulator.getValidEmail(value);
                },
                onChange: (value) {
                  setState(() {});
                },
                isFormField: true,
                labelText: AppLocalisation.getTranslated(context, LKEmail) +
                    "/" +
                    AppLocalisation.getTranslated(context, LKMobileNumber),
              ),
              SB_1H,
              SB_5H,
              SalukGradientButton(
                title: AppLocalisation.getTranslated(context, LKSubmit),
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                    if(_usernameTextEditingController!.text.isNotEmpty){
                      LoginRepository.forgotPassword(context, _usernameTextEditingController!.text);
                    } else {
                      showSnackBar(context, "Please fill the fields");
                    }
                  // }
                },
                buttonHeight: HEIGHT_4,
                dim: _usernameTextEditingController!.text.isNotEmpty
                    ? false
                    : true,
              ),
              SB_5H,
            ],
          ),
        ),
      ),
    );
  }
}
