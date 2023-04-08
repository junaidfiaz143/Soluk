import 'package:app/module/user/user_info/view/user_info_step_eight.dart';
import 'package:app/module/user/user_info/widgets/user_info_selecition_tile.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/color.dart';
import '../../../../res/globals.dart';
import '../../../../utils/nav_router.dart';
import '../../../influencer/widgets/saluk_gradient_button.dart';
import '../cubit/user_info_cubit.dart';
import '../widgets/step_widget.dart';
import 'review_screen.dart';

class UserInfoStepSeven extends StatefulWidget {
  const UserInfoStepSeven(
      {Key? key, this.isEditableMode = false, this.selectedActiveness})
      : super(key: key);
  final bool isEditableMode;
  final String? selectedActiveness;

  @override
  State<UserInfoStepSeven> createState() => _UserInfoStepSevenState();
}

class _UserInfoStepSevenState extends State<UserInfoStepSeven> {
  int selectedActiveOption = 0;

  List<String> activeOptionsList = [
    'Sedentary',
    'Light',
    'Moderate',
    'Active',
    'Extremely Active'
  ];
  String tooltipText = """
  - Sedentary Lifestyle, Little or No Exercise, Moderate Walking, Desk Job (Away from Home)\n\n
  - Slightly Active, Exercise or Light Sports 1 to 3 Days a Week, Light Jogging or Walking 3 to 4 Days a Week\n\n
  - Moderately Active, Physical Work, Exercise, or Sports 4 to 5 Days a Week, Construction Laborer\n\n
  - Very Active, Heavy Physical Work, Exercise, or Sports 6 to 7 Days a Week, Hard Laborer\n\n
  - Extremely Active, Very Heavy Physical Work or Exercise Every Day, Professional/Olympic Athlete""";

  @override
  void initState() {
    super.initState();
    if (widget.selectedActiveness != null) {
      int index = activeOptionsList
          .indexWhere((element) => widget.selectedActiveness == element);
      selectedActiveOption = index;
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
          hasBackButton: true,
          title: '',
          bgColor: Colors.white,
          action: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Tooltip(
                message: tooltipText,
                triggerMode: TooltipTriggerMode.tap,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BORDER_CIRCULAR_RADIUS,
                ),
                textStyle: TextStyle(color: PRIMARY_COLOR),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: StepWidget(
                  stepName: 'How Active are you',
                  stepNumber: '7',
                ),
              ),
              SizedBox(height: 30),
              SvgPicture.asset('assets/svgs/ic_userinfo_weight.svg'),
              SizedBox(height: 25),
              TextView('How active are\nyou.',
                  fontWeight: FontWeight.w500, fontSize: 20),
              SizedBox(height: 14),
              SingleChildScrollView(
                child: Column(
                    children: List.generate(
                  activeOptionsList.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedActiveOption = index;
                      });
                    },
                    child: UserInfoSelectionTile(
                        title: activeOptionsList[index],
                        isSelected: index == selectedActiveOption),
                  ),
                )),
              )
            ],
          ),
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
              context.read<UserInfoCubit>().activeness =
                  activeOptionsList[selectedActiveOption];
              //
              widget.isEditableMode
                  ? NavRouter.pushReplacement(context, ReviewScreen())
                  : NavRouter.push(context, UserInfoStepEight());
            },
          ),
        ),
      ),
    );
  }
}
