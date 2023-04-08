import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/user/user_info/cubit/user_info_cubit.dart';
import 'package:app/module/user/user_info/view/user_info_step_three.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/user_appbar.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/step_widget.dart';
import 'review_screen.dart';

class UserInfoStepTwo extends StatefulWidget {
  const UserInfoStepTwo({
    Key? key,
    this.isEditableMode = false,
    this.gender,
  }) : super(key: key);
  final bool isEditableMode;
  final String? gender;

  @override
  State<UserInfoStepTwo> createState() => _UserInfoStepTwoState();
}

class _UserInfoStepTwoState extends State<UserInfoStepTwo> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.gender != null) {
      if (widget.gender == 'Male') {
        selectedIndex = 0;
      } else {
        selectedIndex = 1;
      }
      setState(() {});
    }
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
            bgColor: Colors.white),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              StepWidget(
                stepName: 'Gender',
                stepNumber: '2',
              ),
              SizedBox(height: 30),
              SvgPicture.asset('assets/svgs/ic_userinfo_profile.svg'),
              SizedBox(height: 25),
              TextView('Which one are you?',
                  fontWeight: FontWeight.w500, fontSize: 20),
              SizedBox(height: 10),
              TextView(
                'To give a customize experience we need to know \nyour gender.',
                fontSize: 14,
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0; // male
                      });
                    },
                    child: SvgPicture.asset(
                        'assets/svgs/img_male_${selectedIndex == 0 ? 'active' : 'inactive'}.svg'),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1; // male
                      });
                    },
                    child: SvgPicture.asset(
                        'assets/svgs/img_female_${selectedIndex == 1 ? 'active' : 'inactive'}.svg'),
                  ),
                ],
              )
            ],
          ),
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
            onPressed: () async {
              context.read<UserInfoCubit>().gender =
                  selectedIndex == 0 ? 'Male' : 'Female';
              //
              widget.isEditableMode
                  ? NavRouter.pushReplacement(context, ReviewScreen())
                  : NavRouter.push(context, UserInfoStepThree());
            },
          ),
        ),
      ),
    );
  }
}
