import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/influencer/login/view/sign_up_screen.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_password_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/string_manipulator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "/login_screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _usernameTextEditingController, _passwordTextEditingController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    // _usernameTextEditingController!.text = 'anas@gmail.com';
    // _passwordTextEditingController!.text = 'Password@1234';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _onDataLoaded(),
      ),
    );
  }

  _onDataLoaded() {
    return Padding(
      padding: DEFAULT_HORIZONTAL_PADDING,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SB_3H,
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
                AppLocalisation.getTranslated(context, LKHelloAgain),
                style: headingTextStyle(context),
              ),
              Text(
                AppLocalisation.getTranslated(context, LKAccountLogin),
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
              PasswordTextField(
                passwordTextEditingController: _passwordTextEditingController,
                isFormField: true,
                onChange: (value) {
                  setState(() {});
                },
                // onValidator: (value) {
                //   return StringManipulator.getValidPassword(value);
                // },
              ),
              SB_1H,
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(ForgotPasswordScreen.id);
                  },
                  child: Text(
                    AppLocalisation.getTranslated(context, LKForgetPassword),
                    textAlign: TextAlign.end,
                    style: labelTextStyle(context),
                  ),
                ),
              ),
              SB_5H,
              SalukGradientButton(
                title: AppLocalisation.getTranslated(context, LKLogin),
                onPressed: () async {
                  if (_usernameTextEditingController!.text.isNotEmpty &&
                      _passwordTextEditingController!.text.isNotEmpty) {
                    LoginRepository.signIn(_usernameTextEditingController!.text,
                        _passwordTextEditingController!.text, context);
                  } else {
                    showSnackBar(context, "Please fill all the fields");
                  }
                },
                buttonHeight: HEIGHT_4,
                dim: _usernameTextEditingController!.text.isNotEmpty &&
                        _passwordTextEditingController!.text.isNotEmpty
                    ? false
                    : true,
              ),
              SB_1H,
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: AppLocalisation.getTranslated(context, LKAlreadyExist),
                          style: labelTextStyle(context)),
                      TextSpan(
                        text: " " + AppLocalisation.getTranslated(context, LKSignUp),
                        style: labelTextStyle(context)?.copyWith(color: PRIMARY_COLOR),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            navigatorKey.currentState?.pushNamed(SignUpScreen.id);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
