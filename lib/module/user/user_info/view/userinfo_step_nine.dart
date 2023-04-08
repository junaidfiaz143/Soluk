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

class UserInfoStepNine extends StatefulWidget {
  const UserInfoStepNine(
      {Key? key, this.isEditableMode = false, this.selectedMeal})
      : super(key: key);
  final bool isEditableMode;
  final String? selectedMeal;

  @override
  State<UserInfoStepNine> createState() => _UserInfoStepNineState();
}

class _UserInfoStepNineState extends State<UserInfoStepNine> {
  int selectedMealIndex = 0;
  List<String> mealsList = [
    '3 Meals & 2 Snacks',
    '4 Meals & 2 Snacks ',
    '5 Meals & 1 Snack'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.selectedMeal != null) {
      int index =
          mealsList.indexWhere((element) => widget.selectedMeal == element);
      selectedMealIndex = index;
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
                stepName: 'Meal Per day',
                stepNumber: '9',
              ),
            ),
            SizedBox(height: 30),
            SvgPicture.asset('assets/svgs/ic_userinfo_weight.svg'),
            SizedBox(height: 25),
            TextView('Choose your meal per day.',
                fontWeight: FontWeight.w500, fontSize: 20),
            SizedBox(height: 14),
            SingleChildScrollView(
              child: Column(
                  children: List.generate(
                mealsList.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMealIndex = index;
                    });
                  },
                  child: UserInfoSelectionTile(
                      title: mealsList[index],
                      isSelected: index == selectedMealIndex),
                ),
              )),
            )
          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 40) +
              EdgeInsets.symmetric(horizontal: 20),
          height: 54,
          child: SalukGradientButton(
            title: 'CONTINUE',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16),
            buttonHeight: 54,
            onPressed: () {
              context.read<UserInfoCubit>().mealPerDay =
                  mealsList[selectedMealIndex];
              NavRouter.push(context, ReviewScreen());
            },
          ),
        ),
      ),
    );
  }
}
