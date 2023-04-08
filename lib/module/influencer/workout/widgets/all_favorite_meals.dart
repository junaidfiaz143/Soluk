// import 'package:app/module/influencer/widgets/app_body.dart';
// import 'package:app/module/influencer/widgets/fab.dart';
// import 'package:app/module/influencer/workout/bloc/blog_bloc.dart';
// import 'package:app/module/influencer/workout/bloc/favorite_meal_bloc/user_workout_bloc.dart';
// import 'package:app/module/influencer/workout/widgets/add_blog.dart';
// import 'package:app/module/influencer/workout/widgets/add_favorite_meal.dart';
// import 'package:app/module/influencer/workout/widgets/blog_detail.dart';
// import 'package:app/module/influencer/workout/widgets/components/cardView.dart';
// import 'package:app/module/influencer/workout/widgets/components/favorite_meal_card.dart';
// import 'package:app/module/influencer/workout/widgets/favorite_detail.dart';
// import 'package:app/res/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AllFavoriteMeals extends StatefulWidget {
//   const AllFavoriteMeals({Key? key}) : super(key: key);

//   @override
//   State<AllFavoriteMeals> createState() => _AllFavoriteMealsState();
// }

// class _AllFavoriteMealsState extends State<AllFavoriteMeals> {
 
//   @override
//   Widget build(BuildContext context) {
//     final _blogBloc = BlocProvider.of<BlogBloc>(context);
//     return Scaffold(
//       body: AppBody(
//         title: "Favorite Meals",
//         body: BlocBuilder<FavoritemealblocCubit, FavoritemealblocState>(
//           builder: (context, state) {
//             return ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (BuildContext context, int index) {
//                     return FavoriteMealCard(image: WORKOUT_COVER2,title: 'Favorite Meals',callback: (){
//                       Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) =>const  FavoriteDetail(title: 'helelele'),
//                     ),
//                   );
//                     },);
//                   },
//                 );
//           },
//         )
//       ),
//         floatingActionButton: FAB(
//         callback: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const AddFavoriteMeal(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
