import 'package:app/module/user/user_info/view/review_screen.dart';
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
import 'userinfo_step_nine.dart';

class UserInfoStepEight extends StatefulWidget {
  const UserInfoStepEight(
      {Key? key, this.isEditableMode = false, this.selectedDiet})
      : super(key: key);
  final bool isEditableMode;
  final String? selectedDiet;

  @override
  State<UserInfoStepEight> createState() => _UserInfoStepEightState();
}

class _UserInfoStepEightState extends State<UserInfoStepEight> {
  int selectedDietIndex = 0;
  List<String> dietList = ['Standard', 'Vegan'];

  @override
  void initState() {
    super.initState();
    if (widget.selectedDiet != null) {
      int index =
          dietList.indexWhere((element) => widget.selectedDiet == element);
      selectedDietIndex = index;
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
                stepName: 'Your Diet',
                stepNumber: '8',
              ),
            ),
            SizedBox(height: 30),
            SvgPicture.asset('assets/svgs/ic_userinfo_weight.svg'),
            SizedBox(height: 25),
            TextView('Choose Your Diet.',
                fontWeight: FontWeight.w500, fontSize: 20),
            SizedBox(height: 14),
            SingleChildScrollView(
              child: Column(
                  children: List.generate(
                dietList.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDietIndex = index;
                    });
                  },
                  child: UserInfoSelectionTile(
                      title: dietList[index],
                      isSelected: index == selectedDietIndex),
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
              context.read<UserInfoCubit>().diet =
                  dietList[selectedDietIndex];
              NavRouter.push(
                context,
                widget.isEditableMode ? ReviewScreen() : UserInfoStepNine(),
              );
            },
          ),
        ),
      ),
    );
  }
}
