import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalukTextField extends StatefulWidget {
  final bool isReadable;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? onValidator;
  final Widget? suffixIcon;
  final TextEditingController? textEditingController;
  final String? hintText;
  final bool obsecure;
  final bool isPasswordText;
  final int maxLines;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  final bool? isFormField;
  final bool? enable;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;

  const SalukTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.obsecure = false,
    this.isPasswordText = false,
    this.maxLines = 1,
    this.isReadable = false,
    this.prefixIcon,
    this.textInputType,
    this.onChange,
    this.onTap,
    this.isFormField = false,
    this.suffixIcon,
    this.onSubmitted,
    this.onValidator,
    this.enable,
    this.inputFormatters = const [],
    required this.labelText,
  }) : super(key: key);

  @override
  _SalukTextFieldState createState() => _SalukTextFieldState();
}

class _SalukTextFieldState extends State<SalukTextField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, Language>(
      builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1,
          ),
          child: !widget.isFormField!
              ? TextField(
                  controller: widget.textEditingController,
                  inputFormatters: widget.inputFormatters,
                  maxLines: widget.maxLines,
                  enabled: widget.enable,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintStyle: hintTextStyle(context),
                    hintText: widget.hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    alignLabelWithHint: true,
                    labelStyle: hintTextStyle(context),
                    labelText:
                        widget.labelText!.isEmpty ? null : widget.labelText,
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: defaultSize.screenWidth * .05,
                      maxWidth: defaultSize.screenWidth * .05,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: defaultSize.screenWidth * .08,
                      maxWidth: defaultSize.screenWidth * .08,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: defaultSize.screenHeight * .02,
                      horizontal: defaultSize.screenWidth * .02,
                    ),
                    isDense: true,
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: widget.prefixIcon == null
                              ? defaultSize.screenWidth * .05
                              : defaultSize.screenWidth * .03,
                        ),
                        child: widget.prefixIcon ?? const SizedBox()),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(
                        right: state == Language.ENGLISH
                            ? widget.suffixIcon == null
                                ? defaultSize.screenWidth * .05
                                : defaultSize.screenWidth * .03
                            : 0,
                        left: state == Language.ARABIC
                            ? widget.suffixIcon == null
                                ? defaultSize.screenWidth * .05
                                : defaultSize.screenWidth * .03
                            : 0,
                      ),
                      child: widget.suffixIcon ?? const SizedBox(),
                    ),
                  ),
                  onSubmitted: (_) {
                    if (widget.onSubmitted != null) {
                      widget.onSubmitted!(_);
                    }
                  },
                  onTap: () {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    }
                  },
                  keyboardType: widget.textInputType ?? TextInputType.text,
                  readOnly: widget.isReadable,
                  onChanged: (_) {
                    setState(() {});
                    if (widget.onChange != null) {
                      widget.onChange!(_);
                    }
                  },
                  obscureText: widget.obsecure ? widget.obsecure : false,
                  style: labelTextStyle(context),
                )
              : TextFormField(
                  controller: widget.textEditingController,
                  maxLines: widget.maxLines,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintStyle: hintTextStyle(context),
                    hintText: widget.hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    alignLabelWithHint: true,
                    labelStyle: hintTextStyle(context),
                    labelText: widget.labelText,
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: defaultSize.screenWidth * .08,
                      maxWidth: defaultSize.screenWidth * .25,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: defaultSize.screenWidth * .08,
                      maxWidth: defaultSize.screenWidth * .08,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: defaultSize.screenHeight * .02,
                      horizontal: defaultSize.screenWidth * .02,
                    ),
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          left: widget.prefixIcon == null
                              ? defaultSize.screenWidth * .03
                              : defaultSize.screenWidth * .03,
                        ),
                        child: widget.prefixIcon ?? const SizedBox()),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(
                        right: state == Language.ENGLISH
                            ? widget.suffixIcon == null
                                ? defaultSize.screenWidth * .05
                                : defaultSize.screenWidth * .03
                            : 0,
                        left: state == Language.ARABIC
                            ? widget.suffixIcon == null
                                ? defaultSize.screenWidth * .05
                                : defaultSize.screenWidth * .03
                            : 0,
                      ),
                      child: widget.suffixIcon ?? const SizedBox(),
                    ),
                  ),
                  validator: widget.onValidator,
                  onTap: () {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    }
                  },
                  keyboardType: widget.textInputType ?? TextInputType.text,
                  readOnly: widget.isReadable,
                  onChanged: (_) {
                    setState(() {});
                    if (widget.onChange != null) {
                      widget.onChange!(_);
                    }
                  },
                  obscureText: widget.obsecure ? widget.obsecure : false,
                  style: labelTextStyle(context),
                ),
        );
      },
    );
  }
}
