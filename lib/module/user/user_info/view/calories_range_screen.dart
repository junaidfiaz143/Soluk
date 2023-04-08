import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../res/color.dart';
import '../../../../res/constants.dart';
import '../../../../res/globals.dart';
import '../../../../utils/nav_router.dart';
import '../../../influencer/widgets/saluk_gradient_button.dart';
import '../../user_dashboard.dart';
import '../../widgets/user_appbar.dart';
import '../cubit/user_info_cubit.dart';

class CaloriesRangeScreen extends StatefulWidget {
  const CaloriesRangeScreen({Key? key, required this.caloriesRange})
      : super(key: key);
  final String caloriesRange;

  @override
  State<CaloriesRangeScreen> createState() => _CaloriesRangeScreenState();
}

class _CaloriesRangeScreenState extends State<CaloriesRangeScreen> {
  final int ALLOWED_STEPS = 2;
  int current_step = 0;
  int start_range = 0;
  int end_range = 0;
  bool isRangeExist = true;

  @override
  void initState() {
    if (widget.caloriesRange.contains('-')) {
      int count = widget.caloriesRange.split('-').length;
      if (count == 2) {
        start_range = int.parse(widget.caloriesRange.split('-')[0]);
        end_range = int.parse(widget.caloriesRange.split('-')[1]);
      } else {
        start_range = int.parse(widget.caloriesRange);
        isRangeExist = false;
      }
    } else if (widget.caloriesRange != '') {
      start_range = int.parse(widget.caloriesRange);
      isRangeExist = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else {
          Navigator.pop(context, true);
          return true;
        }
      },
      child: Scaffold(
        appBar: UserAppbar(
          hasBackButton: false,
          title: '',
          bgColor: backgroundColor,
          action: [
            Tooltip(
              message:
                  '" + " means to add 200 Cal\n" - " means to subtract 200 Cal',
              triggerMode: TooltipTriggerMode.tap,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BORDER_CIRCULAR_RADIUS,
              ),
              textStyle: TextStyle(color: PRIMARY_COLOR),
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.info_outline,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextView(
                'Your Calorie\nRange',
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 40),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/bg_categories_range.png'),
                  Positioned(
                      left: 20, top: 20, child: getSignButton("-", false)),
                  Positioned(
                      right: 20, top: 20, child: getSignButton("+", true)),
                  CircularPercentIndicator(
                    radius: 250.0,
                    lineWidth: 20.0,
                    percent: 0.5,
                    circularStrokeCap: CircularStrokeCap.round,
                    startAngle: 270,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                          isRangeExist
                              ? '$start_range - $end_range'
                              : '$start_range',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        ),
                        SizedBox(height: 4),
                        TextView(
                          "Calorie Range",
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ],
                    ),
                    backgroundColor: Colors.white,
                    progressColor: Color(0xff7EF6DD),
                  ),
                ],
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
            onPressed: () async {
              String userId = await LocalStore.getData(PREFS_USERID);
              bool isUpdatedSuccessfully = await context
                  .read<UserInfoCubit>()
                  .updateUserCalorieRange(
                      userId,
                      isRangeExist
                          ? "$start_range-$end_range"
                          : "$start_range");
              if (isUpdatedSuccessfully) {
                NavRouter.pushAndRemoveUntil(context, UserDashboard());
              } else {
                showSnackBar(
                    context, "Calorie Range didn't update. please try again");
              }
            },
          ),
        ),
      ),
    );
  }

  Widget getSignButton(String signText, bool isAdd) {
    return Container(
      width: WIDTH_5 * 1.1,
      height: HEIGHT_3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          if (isAdd) {
            if (current_step < ALLOWED_STEPS) {
              current_step = current_step + 1;
              start_range += 200;
              if (isRangeExist) end_range += 200;
            }
          } else {
            if (current_step > -ALLOWED_STEPS) {
              current_step = current_step - 1;
              start_range -= 200;
              if (isRangeExist) end_range -= 200;
            }
          }
          print(current_step);

          setState(() {});
        },
        child: Center(
          child: Text(
            signText,
            style: labelTextStyle(context)
                ?.copyWith(color: PRIMARY_COLOR, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
