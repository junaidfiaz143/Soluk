import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? passwordTextEditingController;
  final bool isFormField;
  final FormFieldValidator<String>? onValidator;
  final ValueChanged<String>? onChange;
  final String? text;

  const PasswordTextField({
    Key? key,
    required this.passwordTextEditingController,
    this.isFormField = false,
    this.onValidator,
    this.onChange,
    this.text,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  ValueNotifier<PasswordVisibility>? passwordVisibility;
  @override
  void initState() {
    super.initState();
    passwordVisibility = ValueNotifier(PasswordVisibility.VISIBILITY_OFF);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PasswordVisibility>(
        valueListenable: passwordVisibility!,
        builder: (ctx, a, _) {
          return SalukTextField(
            textEditingController: widget.passwordTextEditingController,
            hintText: '',
            labelText: widget.text ?? AppLocalisation.getTranslated(context, LKPassword),
            onTap: () {},
            isFormField: widget.isFormField,
            onValidator: widget.onValidator,
            onChange: (value) {
              if (widget.onChange != null) {
                setState(() {
                  widget.onChange!(value);
                });
              }
            },
            obsecure:
                passwordVisibility?.value == PasswordVisibility.VISIBILITY_OFF
                    ? true
                    : false,
            suffixIcon: GestureDetector(
              onTap: () {
                if (passwordVisibility?.value ==
                    PasswordVisibility.VISIBILITY_OFF) {
                  passwordVisibility?.value = PasswordVisibility.VISIBILITY_ON;
                } else if (passwordVisibility?.value ==
                    PasswordVisibility.VISIBILITY_ON) {
                  passwordVisibility?.value = PasswordVisibility.VISIBILITY_OFF;
                }
                passwordVisibility?.notifyListeners();
              },
              child: Icon(
                passwordVisibility?.value == PasswordVisibility.VISIBILITY_ON
                    ? Icons.visibility_off
                    : Icons.visibility,
                size: defaultSize.screenWidth*.06,
              ),
            ),
          );
        });
  }
}

enum PasswordVisibility { VISIBILITY_ON, VISIBILITY_OFF }
