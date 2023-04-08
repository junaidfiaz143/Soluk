import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/user/user_info/view/user_info_step_two.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/user_appbar.dart';
import 'package:app/utils/nav_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../res/globals.dart';
import '../../../influencer/widgets/saluk_textfield.dart';
import '../cubit/user_info_cubit.dart';
import '../widgets/step_widget.dart';
import 'review_screen.dart';

class UserInfoStepOne extends StatefulWidget {
  const UserInfoStepOne({Key? key, this.isEditableMode = false})
      : super(key: key);
  final bool isEditableMode;

  @override
  State<UserInfoStepOne> createState() => _UserInfoStepOneState();
}

class _UserInfoStepOneState extends State<UserInfoStepOne> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String date = '';

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
              hasBackButton: false, title: '', bgColor: Colors.white),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                StepWidget(
                  stepName: 'Basic Info',
                  stepNumber: '1',
                ),
                SizedBox(height: 30),
                SvgPicture.asset('assets/svgs/ic_userinfo_profile.svg'),
                SizedBox(height: 25),
                TextView('What is your Name',
                    fontWeight: FontWeight.w500, fontSize: 14),
                SizedBox(height: 10),
                TextView('User Name',
                    fontWeight: FontWeight.w500, fontSize: 14),
                SizedBox(height: 10),
                SalukTextField(
                    textEditingController: userNameController,
                    hintText: '',
                    onValidator: (value) {
                      if (value!.isEmpty) return 'Username is required';
                      return null;
                    },
                    onChange: (value) {
                      // setState(() {});
                    },
                    isFormField: true,
                    labelText: 'User name'),
                SizedBox(height: 25),
                TextView('What is DOB',
                    fontWeight: FontWeight.w500, fontSize: 14),
                SizedBox(height: 10),
                SalukTextField(
                    textEditingController: dobController,
                    hintText: '',
                    onTap: () {
                      _showDatePicker(context, true);
                    },
                    isReadable: true,
                    enable: false,
                    onValidator: (value) {
                      return null;
                    },
                    onChange: (value) {
                      // setState(() {});
                    },
                    isFormField: true,
                    labelText: 'DOB'),
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
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16),
              buttonHeight: 54,
              onPressed: () {
                if (userNameController.text.trim().isEmpty) {
                  showSnackBar(context, 'Username is required');
                  return;
                } else if (dobController.text.isEmpty) {
                  showSnackBar(context, 'Please choose the date of birth');
                  return;
                }
                context.read<UserInfoCubit>().username =
                    userNameController.text;
                context.read<UserInfoCubit>().dob =
                    '${dobController.text} 00:00:00';
                //
                widget.isEditableMode
                    ? NavRouter.pushReplacement(context, ReviewScreen())
                    : NavRouter.push(context, UserInfoStepTwo());
              },
            ),
          )),
    );
  }

  void _showDatePicker(BuildContext context, bool isDate) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Material(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        // Spacer(),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            print('date is :: $date');
                            Navigator.pop(context);
                            if (isDate) {
                              dobController.text = date;
                              setState(() {});
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueAccent),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: HEIGHT_5 + HEIGHT_5,
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      mode: isDate
                          ? CupertinoDatePickerMode.date
                          : CupertinoDatePickerMode.time,
                      onDateTimeChanged: (value) {
                        if (isDate) {
                          date = value.year.toString() +
                              "-" +
                              value.month.toString() +
                              "-" +
                              value.day.toString();
                          // widget.onDateChange(date??'');
                        }
                      },
                      initialDateTime: DateTime.now(),
                      maximumYear: DateTime.now().year,
                      dateOrder: DatePickerDateOrder.dmy,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
