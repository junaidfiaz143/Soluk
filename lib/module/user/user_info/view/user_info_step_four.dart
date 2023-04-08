import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/nav_router.dart';
import '../../../influencer/widgets/saluk_gradient_button.dart';
import '../cubit/user_info_cubit.dart';
import '../widgets/horizontal_picker_slider.dart';
import '../widgets/step_widget.dart';
import 'review_screen.dart';
import 'user_info_step_five.dart';

class UserInfoStepFour extends StatefulWidget {
  const UserInfoStepFour({Key? key, this.isEditableMode = false, this.fatValue})
      : super(key: key);
  final bool isEditableMode;
  final String? fatValue;

  @override
  State<UserInfoStepFour> createState() => _UserInfoStepFourState();
}

class _UserInfoStepFourState extends State<UserInfoStepFour> {
  late FixedExtentScrollController fixedExtentScrollController;
  int sliderLength = 101;
  late int selectedFatValue;

  @override
  void initState() {
    super.initState();
    if (widget.fatValue != null) {
      selectedFatValue = int.parse(widget.fatValue!);
      fixedExtentScrollController =
          FixedExtentScrollController(initialItem: selectedFatValue);
      return;
    }
    selectedFatValue = sliderLength ~/ 2;
    fixedExtentScrollController =
        FixedExtentScrollController(initialItem: sliderLength ~/ 2);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: UserAppbar(
          hasBackButton: widget.isEditableMode == false ? true : false,
          title: '',
          bgColor: Colors.white,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StepWidget(
                stepName: 'Your Body Fats',
                stepNumber: '4',
              ),
            ),
            SizedBox(height: 30),
            SvgPicture.asset('assets/svgs/ic_userinfo_bodyfat.svg'),
            SizedBox(height: 25),
            TextView('What is your Body Fat\nPercentage?',
                fontWeight: FontWeight.w500, fontSize: 20),
            SizedBox(height: 25),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/svgs/custom_bubble_shape.svg'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextView(
                    'BF $selectedFatValue%',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            HorizontalPickerSlider(
              fixedExtentScrollController: fixedExtentScrollController,
              sliderLength: sliderLength,
              onChanged: (index) {
                setState(() {
                  selectedFatValue = index;
                });
              },
            )
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                context.read<UserInfoCubit>().fat = '-2';
                navigateToNextScreen();
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child:
                    TextView('Skip', fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40) +
                  EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              child: SalukGradientButton(
                title: 'CONTINUE',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16),
                buttonHeight: 54,
                onPressed: () {
                  context.read<UserInfoCubit>().fat =
                      selectedFatValue.toString();
                  navigateToNextScreen();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  navigateToNextScreen() {
    widget.isEditableMode
        ? NavRouter.pushReplacement(context, ReviewScreen())
        : NavRouter.push(context, UserInfoStepFive());
  }
}
