import 'package:app/module/influencer/login/widgets/pre_reg_action.dart';
import 'package:app/module/influencer/widgets/language_dropdown.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class PreRegistrationScreen extends StatefulWidget {
  static const String id = "/pre_registration_screen";
  const PreRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<PreRegistrationScreen> createState() => _PreRegistrationScreenState();
}

class _PreRegistrationScreenState extends State<PreRegistrationScreen> {
  AssetImage? background;

  @override
  void initState() {
    super.initState();
    background = const AssetImage(PRE_BACKGROUND);
  }

  @override
  void didChangeDependencies() {
    precacheImage(background!, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                PRE_BACKGROUND,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: HORIZONTAL_PADDING,
              vertical: defaultSize.screenHeight * .02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [LanguageDropDownButton(), Spacer(), PreRegAction()],
            ),
          ),
        ),
      ),
    );
  }
}
