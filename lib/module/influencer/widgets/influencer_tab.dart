import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class InfluencerTabView extends StatelessWidget {
  final TextEditingController instagramTextEditingController;
  final TextEditingController youtubeTextEditingController;
  final TextEditingController countryTextEditingController;
  final TextEditingController introTextEditingController;
  final TextEditingController contentTypeTextEditingController;
  final ValueChanged<String> onChange;
  final ValueChanged<String> onChange1;

  const InfluencerTabView({
    Key? key,
    required this.instagramTextEditingController,
    required this.youtubeTextEditingController,
    required this.countryTextEditingController,
    required this.introTextEditingController,
    required this.contentTypeTextEditingController,
    required this.onChange,
    required this.onChange1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 5,
          color: TOGGLE_BACKGROUND_COLOR,
          height: 2,
        ),
        SB_1H,
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: false,
              // optional. Shows phone code before the country name.
              onSelect: (Country country) {
                countryTextEditingController.text = country.name;
              },
            );
          },
          child: SalukTextField(
            textEditingController: countryTextEditingController,
            hintText: '',
            enable: false,
            onTap: () {},
            onChange: (value) {
              onChange1(value);
            },
            // isFormField: true,
            labelText: "Country",
          ),
        ),
        SB_1H,
        SalukTextField(
          textEditingController: introTextEditingController,
          hintText: '',
          maxLines: 4,
          // onValidator: (value) {
          //   return StringManipulator.getValidUsername(value);
          // },
          onChange: (value) {
            onChange1(value);
          },
          // isFormField: true,
          labelText: "Talk about yourself and your credentials",
        ),
        SB_1H,
        SalukTextField(
          textEditingController: contentTypeTextEditingController,
          hintText: '',
          maxLines: 4,
          // onValidator: (value) {
          //   return StringManipulator.getValidUsername(value);
          // },
          onChange: (value) {
            onChange1(value);
          },
          // isFormField: true,
          labelText: "Which type of content are interested to\npost?",
        ),
        SB_1H,
        Text(AppLocalisation.getTranslated(context, LKInstagram),
            style: labelTextStyle(context)),
        SB_1H,
        SalukTextField(
          textEditingController: instagramTextEditingController,
          hintText: '',
          // onValidator: (value) {
          //   return StringManipulator.getValidUsername(value);
          // },
          onChange: (value) {
            onChange(value);
          },
          // isFormField: true,
          labelText: AppLocalisation.getTranslated(context, LKYourAccount),
        ),
        SB_1H,
        Row(
          children: [
            Text(AppLocalisation.getTranslated(context, LKYouTube),
                style: labelTextStyle(context)),
            Text("(${AppLocalisation.getTranslated(context, LKOptional)})",
                style: hintTextStyle(context)),
          ],
        ),
        SB_1H,
        SalukTextField(
          textEditingController: youtubeTextEditingController,
          hintText: '',
          // onValidator: (value) {
          //   return StringManipulator.getValidUsername(value);
          // },
          onChange: (value) {
            onChange1(value);
          },
          // isFormField: true,
          labelText: AppLocalisation.getTranslated(context, LKYourAccount),
        ),
      ],
    );
  }
}
