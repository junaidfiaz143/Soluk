import 'package:app/module/influencer/widgets/empty_widget.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/user/user_info/cubit/user_info_cubit.dart';
import 'package:app/module/user/user_info/view/user_info_step_eight.dart';
import 'package:app/module/user/user_info/view/user_info_step_five.dart';
import 'package:app/module/user/user_info/view/user_info_step_four.dart';
import 'package:app/module/user/user_info/view/user_info_step_seven.dart';
import 'package:app/module/user/user_info/view/user_info_step_six.dart';
import 'package:app/module/user/user_info/view/user_info_step_two.dart';
import 'package:app/module/user/user_info/view/userinfo_step_nine.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/module/user/widgets/top_appbar_row.dart';
import 'package:app/res/constants.dart';
import 'package:app/utils/nav_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../res/globals.dart';
import '../../../influencer/widgets/saluk_gradient_button.dart';
import '../../widgets/userinfo_review_card.dart';
import 'calories_range_screen.dart';
import 'user_info_step_three.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    Key? key,
    this.isOpenedFromMeal = false,
  }) : super(key: key);
  final bool isOpenedFromMeal;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String userName = 'User';
  String userId = '';
  bool isUpdated = false;

  @override
  void initState() {
    super.initState();

    fetchUserInfo();
  }

  void fetchUserInfo() async {
    userId = await LocalStore.getData(PREFS_USERID);
    if (widget.isOpenedFromMeal) {
      context.read<UserInfoCubit>().fetchUserInfo(userId);
    }
    print('user id is :: $userId');
    userName = await LocalStore.getData(PREFS_USERNAME);
    setState(() {});
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
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TopAppbarRow(title: '', horizontalPadding: 0),
              SvgPicture.asset('assets/svgs/ic_userinfo_profile.svg'),
              SizedBox(height: 15),
              TextView(userName, fontWeight: FontWeight.w500, fontSize: 20),
              SizedBox(height: 24),
              if (widget.isOpenedFromMeal)
                Expanded(
                  child: BlocBuilder<UserInfoCubit, SaveUserInfoState>(
                    builder: (context, state) {
                      if (state is UserInfoFetching) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is UserInfoFetched) {
                        return SelectedItemsList();
                      } else if (state is UserInfoFetchError) {
                        return Center(
                          child: TextView(state.error),
                        );
                      }
                      return SelectedItemsList();
                    },
                  ),
                ),
              if (widget.isOpenedFromMeal == false)
                Expanded(child: SelectedItemsList()),
              SizedBox(height: 20)
            ],
          ),
        ),
        bottomNavigationBar: BlocConsumer<UserInfoCubit, SaveUserInfoState>(
          listener: (context, state) async {
            if (state is UserInfoSaving) {
              BotToast.showLoading();
            } else if (state is UserInfoSaved) {
              BotToast.closeAllLoading();
              bool? value = await NavRouter.push(context,
                  CaloriesRangeScreen(caloriesRange: state.caloriesRange));
              isDietUpdated = true;
            } else if (state is UserInfoSaveError) {
              BotToast.closeAllLoading();
              showSnackBar(context, state.error.toString());
            }
          },
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(bottom: 40) +
                  EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              child: state is UserInfoFetching
                  ? EmptyWidget()
                  : SalukGradientButton(
                      title: 'CALCULATE',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),
                      buttonHeight: 54,
                      onPressed: () {
                        if (isDietUpdated || widget.isOpenedFromMeal) {
                          print("isUpdated");
                          context
                              .read<UserInfoCubit>()
                              .updateUserCalorieRange(userId, '');
                        } else {
                          print(" not isUpdated");
                          context.read<UserInfoCubit>().saveUserInfo(userId);
                        }
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}

class SelectedItemsList extends StatelessWidget {
  const SelectedItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfoCubit = context.watch<UserInfoCubit>();
    print('review screen called');
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 14,
          spacing: 14,
          alignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            UserInfoReviewCard(
              value: userInfoCubit.gender,
              name: 'Gender',
              onTap: () {
                NavRouter.pushReplacement(
                  context,
                  UserInfoStepTwo(
                    isEditableMode: true,
                    gender: userInfoCubit.gender,
                  ),
                );
              },
            ),
            UserInfoReviewCard(
              value:
                  userInfoCubit.fat == '-2' ? "-" : '${userInfoCubit.fat} %bf',
              name: 'Body Fat',
              onTap: () {
                NavRouter.pushReplacement(
                  context,
                  UserInfoStepFour(
                    isEditableMode: true,
                    fatValue: userInfoCubit.fat,
                  ),
                );
              },
            ),
            UserInfoReviewCard(
              value: '${userInfoCubit.height} cm',
              name: 'Height',
              onTap: () {
                NavRouter.pushReplacement(
                  context,
                  UserInfoStepThree(
                    isEditableMode: true,
                    heightValue: userInfoCubit.height,
                  ),
                );
              },
            ),
            UserInfoReviewCard(
              value: '${userInfoCubit.weight} kg',
              name: 'Weight',
              onTap: () {
                NavRouter.pushReplacement(
                  context,
                  UserInfoStepFive(
                    isEditableMode: true,
                    weightValue: userInfoCubit.weight,
                  ),
                );
              },
            ),
            UserInfoReviewCard(
              value: '${userInfoCubit.goals}',
              name: 'Goals',
              onTap: () {
                NavRouter.pushReplacement(
                  context,
                  UserInfoStepSix(
                    isEditableMode: true,
                    selectedGoal: userInfoCubit.goals,
                  ),
                );
              },
            ),
            UserInfoReviewCard(
              value: '${userInfoCubit.activeness}',
              name: 'Active',
              onTap: () {
                NavRouter.pushReplacement(
                  context,
                  UserInfoStepSeven(
                    isEditableMode: true,
                    selectedActiveness: userInfoCubit.activeness,
                  ),
                );
              },
            ),
            UserInfoReviewCard(
              value: '${userInfoCubit.diet}',
              name: 'Your Diet',
              onTap: () {
                NavRouter.pushReplacement(
                  context,
                  UserInfoStepEight(
                    isEditableMode: true,
                    selectedDiet: userInfoCubit.diet,
                  ),
                );
              },
            ),
            UserInfoReviewCard(
              value: '${userInfoCubit.mealPerDay}',
              name: 'Meals per day',
              onTap: () {
                NavRouter.pushReplacement(
                  context,
                  UserInfoStepNine(
                    isEditableMode: true,
                    selectedMeal: userInfoCubit.mealPerDay,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
