import 'package:app/module/influencer/login/repo/login_repository.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_password_textfield.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/string_manipulator.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = "/reset_password_screen";

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController? _passwordTextEditingController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordTextEditingController = TextEditingController();
  }

  String? email, pin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _onDataLoaded(),
      ),
    );
  }

  _onDataLoaded() {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    email = arguments['email'];
    pin = arguments['pin'];
    return AppBody(
      title: '',
      body: Form(
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
                AppLocalisation.getTranslated(context, LKChangePass),
                style: headingTextStyle(context),
              ),
              SB_1H,
              Text(
                AppLocalisation.getTranslated(context, LKPassDiffer),
                style: labelTextStyle(context),
              ),
              SB_1H,
              PasswordTextField(
                passwordTextEditingController: _passwordTextEditingController,
                isFormField: true,
                onChange: (value) {
                  setState(() {});
                },
                text: AppLocalisation.getTranslated(context, LKNewPassword),
                onValidator: (value) {
                  return StringManipulator.getValidPassword(value);
                },
              ),
              SB_5H,
              SalukGradientButton(
                title: AppLocalisation.getTranslated(context, LKSubmit),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    LoginRepository.resetPassword(pin!, email!,
                        _passwordTextEditingController!.text, context);
                  }
                },
                buttonHeight: HEIGHT_4,
                dim: _passwordTextEditingController!.text.isNotEmpty
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
