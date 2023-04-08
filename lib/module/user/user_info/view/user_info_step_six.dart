import 'package:app/module/user/user_info/view/user_info_step_seven.dart';
import 'package:app/module/user/user_info/widgets/user_info_selecition_tile.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/nav_router.dart';
import '../../../influencer/widgets/saluk_gradient_button.dart';
import '../cubit/user_info_cubit.dart';
import '../widgets/step_widget.dart';
import 'review_screen.dart';

class UserInfoStepSix extends StatefulWidget {
  const UserInfoStepSix(
      {Key? key, this.isEditableMode = false, this.selectedGoal})
      : super(key: key);
  final bool isEditableMode;
  final String? selectedGoal;

  @override
  State<UserInfoStepSix> createState() => _UserInfoStepSixState();
}

class _UserInfoStepSixState extends State<UserInfoStepSix> {
  List<String> goalsList = ['Lose Weight', 'Maintain Weight', 'Gain Weight'];
  int selectedGoalIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.selectedGoal != null) {
      int index =
          goalsList.indexWhere((element) => widget.selectedGoal == element);
      selectedGoalIndex = index;
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
          bgColor: Colors.white,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StepWidget(
                stepName: 'Your Goals',
                stepNumber: '6',
              ),
            ),
            SizedBox(height: 30),
            SvgPicture.asset('assets/svgs/ic_userinfo_weight.svg'),
            SizedBox(height: 25),
            TextView('Let us know your\ngoals.',
                fontWeight: FontWeight.w500, fontSize: 20),
            SizedBox(height: 14),
            SingleChildScrollView(
              child: Column(
                  children: List.generate(
                goalsList.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGoalIndex = index;
                    });
                  },
                  child: UserInfoSelectionTile(
                      title: goalsList[index],
                      isSelected: index == selectedGoalIndex),
                ),
              )),
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
              context.read<UserInfoCubit>().goals =
                  goalsList[selectedGoalIndex];
              //
              widget.isEditableMode
                  ? NavRouter.pushReplacement(context, ReviewScreen())
                  : NavRouter.push(context, UserInfoStepSeven());
            },
          ),
        ),
      ),
    );
  }
}
