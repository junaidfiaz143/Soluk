import 'package:app/module/influencer/workout/bloc/favorite_meal_bloc/favoritemealbloc_cubit.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../influencer/widgets/app_body.dart';
import 'widgets/workout_programs_tile.dart';

class WorkoutPrograms extends StatelessWidget {
  const WorkoutPrograms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _favMealbloc =
        BlocProvider.of<FavoritemealblocCubit>(context, listen: false);
    _favMealbloc.getfavoriteMeal();
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        bgColor: backgroundColor,
        title: "Workout Programs",
        body: Container(
          padding: EdgeInsets.only(top: 2.h),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return WorkoutProgramTile(
                title: "CHEST & TRICEPS TRAINING",
                description: "1 Weeks",
                image:
                    "https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Z3ltfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                mediaType: "Image",
                callback: () {
                  // NavRouter.push(
                  //   context,
                  //   WorkoutProgramPreview(),
                  // );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
