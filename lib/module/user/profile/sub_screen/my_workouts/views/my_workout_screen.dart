import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/user/profile/sub_screen/my_workouts/bloc/my_workout_cubit.dart';
import 'package:app/module/user/profile/sub_screen/my_workouts/bloc/my_workout_state.dart';
import 'package:app/module/user/profile/widgets/my_workout_widget.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MyWorkoutScreen extends StatefulWidget {
  static const String id = "/challenges";
  final MyWorkoutCubit myWorkoutCubit =
  MyWorkoutCubit(MyWorkoutLoadingState());
  MyWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<MyWorkoutScreen> createState() => _MyWorkoutScreenState();
}

class _MyWorkoutScreenState extends State<MyWorkoutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    widget.myWorkoutCubit.getMyWorkoutPlans();
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: AppBody(
          bgColor: backgroundColor,
          title: "My Workouts",
          body: BlocBuilder<MyWorkoutCubit, MyWorkoutState>(
            bloc: widget.myWorkoutCubit,
            builder: (context, state) {
              if (state is MyWorkoutLoadingState) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: PRIMARY_COLOR,
                ));
              } else if(state is MyWorkoutEmptyState){
                return Center(
                  child: Text("No Workouts found",
                  style: subTitleTextStyle(context)?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontFamily: FONT_FAMILY),
                  ),
                );
              }else
              if (state is MyWorkoutDataLoaded) {
                return MyWorkoutWidget(myWorkoutResponse : state.myWorkoutResponse!,);
              }
              return Container();
            },
          )),
    );
  }
}
