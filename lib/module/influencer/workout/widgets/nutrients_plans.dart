// import 'package:app/module/influencer/widgets/app_body.dart';
// import 'package:app/module/influencer/widgets/fab.dart';
// import 'package:app/module/influencer/workout/widgets/add_nutrient.dart';
// import 'package:app/module/influencer/workout/widgets/components/cardView.dart';
// import 'package:app/res/constants.dart';
// import 'package:flutter/material.dart';

// class NutrientsPlans extends StatefulWidget {
//   const NutrientsPlans({Key? key}) : super(key: key);

//   @override
//   State<NutrientsPlans> createState() => _NutrientsPlansState();
// }

// class _NutrientsPlansState extends State<NutrientsPlans> {
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AppBody(
//         title: "Nutrients Plans",
//         body:ListView.builder(
//           itemCount: 10,
//           itemBuilder: (BuildContext context, int index) {
//             return PlanTile(image: WORKOUT_COVER2,title: 'helelele',callback: (){
//           //         Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (_) =>const  NutrientsDetail(title: 'helelele'),
//           //   ),
//           // );
//             },);
//           },
//         )
//       ),
//         floatingActionButton: FAB(
//         callback: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const AddNutrients(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
