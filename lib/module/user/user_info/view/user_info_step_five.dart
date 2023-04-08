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
import 'user_info_step_six.dart';

class UserInfoStepFive extends StatefulWidget {
  const UserInfoStepFive(
      {Key? key, this.isEditableMode = false, this.weightValue})
      : super(key: key);
  final bool isEditableMode;
  final String? weightValue;

  @override
  State<UserInfoStepFive> createState() => _UserInfoStepFiveState();
}

class _UserInfoStepFiveState extends State<UserInfoStepFive> {
  late FixedExtentScrollController fixedExtentScrollController;
  int sliderLength = 160;
  late int selectedWeightValue;

  @override
  void initState() {
    super.initState();
    if (widget.weightValue != null) {
      selectedWeightValue = int.parse(widget.weightValue!);
      fixedExtentScrollController =
          FixedExtentScrollController(initialItem: selectedWeightValue);
      return;
    }
    selectedWeightValue = sliderLength ~/ 2;
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
                stepName: 'Your Weight',
                stepNumber: '5',
              ),
            ),
            SizedBox(height: 30),
            SvgPicture.asset('assets/svgs/ic_userinfo_weight.svg'),
            SizedBox(height: 25),
            TextView('What is your weight?',
                fontWeight: FontWeight.w500, fontSize: 20),
            SizedBox(height: 25),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/svgs/custom_bubble_shape.svg'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextView(
                    '${selectedWeightValue}kg',
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
                  selectedWeightValue = index;
                });
              },
            )
          ],
        ),
        bottomNavigationBar: Container(
          margin:
              EdgeInsets.only(bottom: 40) + EdgeInsets.symmetric(horizontal: 20),
          height: 54,
          child: SalukGradientButton(
            title: 'CONTINUE',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16),
            buttonHeight: 54,
            onPressed: () {
              context.read<UserInfoCubit>().weight =
                  selectedWeightValue.toString();
              //
              widget.isEditableMode
                  ? NavRouter.pushReplacement(context, ReviewScreen())
                  : NavRouter.push(context, UserInfoStepSix());
            },
          ),
        ),
      ),
    );
  }
}
