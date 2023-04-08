import 'package:app/animations/slide_up_transparent_animation.dart';
import 'package:app/module/influencer/more/repo/more_repository.dart';
import 'package:app/module/influencer/more/widget/custom_alert_dialog.dart';
import 'package:app/module/influencer/widgets/action_pop_up.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_password_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout/model/influencer.dart';
import 'package:app/repo/data_source/remote_data_source.dart';
import 'package:app/res/constants.dart';
import 'package:app/services/localisation.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/string_manipulator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChangePassword extends StatefulWidget {
  static const String id = "/more_change_password";

  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBody(
            title: AppLocalisation.getTranslated(context, LKChangePass),
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SB_1H,
                  Text(
                    AppLocalisation.getTranslated(context, LKCurrentPassword),
                    style: labelTextStyle(context)?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: defaultSize.screenHeight * .01,
                  ),
                  PasswordTextField(
                    passwordTextEditingController:
                        _currentPasswordTextEditingController,
                    isFormField: true,
                    onChange: (_) {
                      setState(() {});
                    },
                    onValidator: (value) {
                      return StringManipulator.getValidPassword(value);
                    },
                  ),
                  SB_1H,
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Text(
                      AppLocalisation.getTranslated(context, LKNewPassword),
                      style: labelTextStyle(context)?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultSize.screenHeight * .01,
                  ),
                  PasswordTextField(
                    passwordTextEditingController:
                        _newPasswordTextEditingController,
                    isFormField: true,
                    onChange: (_) {
                      setState(() {});
                    },
                    onValidator: (value) {
                      return StringManipulator.getValidPassword(value);
                    },
                  ),
                  SizedBox(
                    height: defaultSize.screenHeight * .01,
                  ),
                  PasswordTextField(
                    passwordTextEditingController:
                        _confirmPasswordTextEditingController,
                    isFormField: true,
                    text: AppLocalisation.getTranslated(context, LKConfirmPass),
                    onChange: (_) {
                      setState(() {});
                    },
                    onValidator: (value) {
                      return StringManipulator.getValidPassword(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
          title: AppLocalisation.getTranslated(context, LKSubmit),
          isButtonDisabled:
              _currentPasswordTextEditingController.text.isNotEmpty &&
                      _confirmPasswordTextEditingController.text.isNotEmpty &&
                      _newPasswordTextEditingController.text.isNotEmpty
                  ? false
                  : true,
          callback: () async {
            if (_formKey.currentState!.validate()) {
              if (_newPasswordTextEditingController.text ==
                  _confirmPasswordTextEditingController.text) {
                final apiResponse = await MoreRepository.changePassword(
                    _currentPasswordTextEditingController.text,
                    _newPasswordTextEditingController.text,
                    context);
              } else {
                showSnackBar(context, "Password mismatched.");
              }
            }
          },
        ),
      ),
    );
  }
}
