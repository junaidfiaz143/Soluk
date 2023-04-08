import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LanguageDropDownButton extends StatefulWidget {
  const LanguageDropDownButton({
    Key? key,
    this.isPreRegScreen = true,
  }) : super(key: key);
  final bool isPreRegScreen;

  @override
  State<LanguageDropDownButton> createState() => _LanguageDropDownButtonState();
}

class _LanguageDropDownButtonState extends State<LanguageDropDownButton> {
  List<Language> languages = [Language.ENGLISH, Language.ARABIC];
  Language? selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = languages[0];
  }

  @override
  Widget build(BuildContext context) {
    final _languageBloc = BlocProvider.of<LanguageBloc>(context);
    if (widget.isPreRegScreen) {
      return Container(
        width: defaultSize.screenWidth * .3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              defaultSize.screenWidth * .1,
            ),
          ),
          border: Border.all(
            width: defaultSize.screenWidth * .006,
            color: DROPDOWN_BORDER_COLOR,
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: defaultSize.screenWidth * .03,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BlocBuilder<LanguageBloc, Language>(
          builder: (BuildContext context, state) {
            return DropdownButton<Language>(
              underline: const SizedBox(),
              style: labelTextStyle(context)?.copyWith(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  defaultSize.screenWidth * .02,
                ),
              ),
              icon: SvgPicture.asset(
                DOWN_ICON,
                color: Colors.black,
              ),
              dropdownColor: Colors.white,
              isExpanded: true,
              value: state,
              items: languages.map((Language value) {
                return DropdownMenuItem<Language>(
                  value: value,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value == Language.ENGLISH
                            ? AppLocalisation.getTranslated(context, LKEnglish)
                            : AppLocalisation.getTranslated(context, LKArabic),
                        style: labelTextStyle(context),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (_languageBloc.state == Language.ENGLISH) {
                      _languageBloc.add(Arabic());
                      AppLocalisation.changeLanguage('ar', context);
                    } else if (_languageBloc.state == Language.ARABIC) {
                      _languageBloc.add(English());
                      AppLocalisation.changeLanguage('en', context);
                    }
                  },
                );
              }).toList(),
              onChanged: (_) {},
            );
          },
        ),
      );
    }
    return Container(
      width: defaultSize.screenWidth * .3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            defaultSize.screenWidth * .1,
          ),
        ),
        color: DROPDOWN_BACKGROUND_COLOR,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: defaultSize.screenWidth * .03,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: BlocBuilder<LanguageBloc, Language>(
        builder: (BuildContext context, state) {
          return DropdownButton<Language>(
            underline: const SizedBox(),
            style: labelTextStyle(context)?.copyWith(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                defaultSize.screenWidth * .02,
              ),
            ),
            icon: SvgPicture.asset(
              DOWN_ICON,
              color: Colors.black,
            ),
            dropdownColor: DROPDOWN_BACKGROUND_COLOR,
            isExpanded: true,
            value: state,
            items: languages.map((Language value) {
              return DropdownMenuItem<Language>(
                value: value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value == Language.ENGLISH
                          ? AppLocalisation.getTranslated(context, LKEnglish)
                          : AppLocalisation.getTranslated(context, LKArabic),
                    ),
                  ],
                ),
                onTap: () {
                  if (_languageBloc.state == Language.ENGLISH) {
                    _languageBloc.add(Arabic());
                    AppLocalisation.changeLanguage("ar", context);
                  } else if (_languageBloc.state == Language.ARABIC) {
                    _languageBloc.add(English());
                    AppLocalisation.changeLanguage("en", context);
                  }
                },
              );
            }).toList(),
            onChanged: (_) {},
          );
        },
      ),
    );
  }
}
