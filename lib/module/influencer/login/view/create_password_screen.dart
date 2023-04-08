import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/string_manipulator.dart';
import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_password_textfield.dart';
import 'package:flutter/material.dart';

class CreatePasswordScreen extends StatefulWidget {
  static const String id = "/create_password_screen";

  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  TextEditingController? _passwordTextEditingController,
      _confirmPasswordTextEditingController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _confirmPasswordTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
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
                        AppLocalisation.getTranslated(
                            context, LKCreatePassword),
                        style: headingTextStyle(context),
                      ),
                      SB_1H,
                      Text(
                        AppLocalisation.getTranslated(context, LKPassDiffer),
                        style: labelTextStyle(context),
                      ),
                      SB_1H,
                      PasswordTextField(
                        passwordTextEditingController:
                            _passwordTextEditingController,
                        isFormField: true,
                        onChange: (value) {
                          setState(() {});
                        },
                        text: AppLocalisation.getTranslated(
                            context, LKNewPassword),
                        onValidator: (value) {
                          return StringManipulator.getValidPassword(value);
                        },
                      ),
                      SB_1H,
                      PasswordTextField(
                        passwordTextEditingController:
                            _confirmPasswordTextEditingController,
                        isFormField: true,
                        text: AppLocalisation.getTranslated(
                            context, LKConfirmPass),
                        onChange: (value) {
                          setState(() {});
                        },
                        onValidator: (value) {
                          return StringManipulator.getValidPassword(value);
                        },
                      ),
                      SB_5H,
                      SalukGradientButton(
                        title: AppLocalisation.getTranslated(context, LKSave),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                          }
                        },
                        buttonHeight: HEIGHT_4,
                        dim: _passwordTextEditingController!.text.isNotEmpty &&
                                _confirmPasswordTextEditingController!
                                    .text.isNotEmpty
                            ? false
                            : true,
                      ),
                      SB_5H,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: defaultSize.screenHeight * .08,
              left: defaultSize.screenWidth * .04,
              child: const SolukBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
