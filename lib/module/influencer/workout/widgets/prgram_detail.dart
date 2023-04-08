// import 'package:app/module/influencer/widgets/back_button.dart';
// // import 'package:app/module/influencer/workout_programs/bloc/workout_program_bloc.dart';
// // import 'package:app/module/influencer/workout_programs/view/add_workout_program.dart';
// // import 'package:app/module/influencer/workout_programs/widgets/workout_program_tile.dart';
// // import 'package:app/module/influencer/workout_programs/workout_program.dart';
// import 'package:app/res/constants.dart';
// import 'package:app/res/globals.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:sizer/sizer.dart';

// class ProgramDetail extends StatefulWidget {
//   static const id = 'ProgramDetail';
//   final String title;
//   const ProgramDetail({Key? key, required this.title}) : super(key: key);

//   @override
//   State<ProgramDetail> createState() => _ProgramDetailState();
// }

// class _ProgramDetailState extends State<ProgramDetail> {
//   bool _switchValue = true;
//   @override
//   Widget build(BuildContext context) {
//     // final _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
//     // _workoutProgramBloc.add(SubscribersListLoadingEvent());
//     return Scaffold(
//       body: 
//       // BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
//       //   listener: (context, state) {
//       //     // if (state is SubscribersListLoadingState) {
//       //     //   Future.delayed(const Duration(seconds: 2), () {
//       //     //     _workoutProgramBloc.add(SubscribersListLoadedEvent());
//       //     //   });
//       //     // }
//       //   },
//       //   builder: (context, state) {
//       //     // if (state is SubscribersListLoadingState) {
//       //     //   return const Center(
//       //     //     child: CircularProgressIndicator(
//       //     //       color: Colors.grey,
//       //     //     ),
//       //     //   );
//       //     // }
//       //     // if (state is SubscribersListLoadedState) {
//       //       return 
//             Column(
//               children: [
//                 SB_1H,
//                 SB_1H,
//                 Stack(
//                   children: [
//                     Container(
//                       width: double.maxFinite,
//                       height: HEIGHT_5 * 3.5,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(WORKOUT_COVER2),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SalukBackButton(
//                                 callback: () {},
//                               ),
//                               Text(
//                                 widget.title,
//                                 style: subTitleTextStyle(context)?.copyWith(
//                                   color: Colors.white,
//                                   fontSize: 16.sp,
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {},
//                                 child: Container(
//                                   height: defaultSize.screenWidth * .09,
//                                   width: defaultSize.screenWidth * .09,
//                                   decoration:const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(10.0),
//                                       topLeft: Radius.circular(10.0),
//                                       bottomLeft: Radius.circular(10.0),
//                                       bottomRight: Radius.circular(10.0),
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Icon(
//                                       Icons.delete_outline_outlined,
//                                       color: Colors.red,
//                                       size: defaultSize.screenWidth * .05,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: double.maxFinite,
//                           height: HEIGHT_5 * 1.5,
//                         ),
//                         Container(
//                           width: double.maxFinite,
//                           height: defaultSize.screenHeight * 0.7,
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(30.0),
//                               topLeft: Radius.circular(30.0),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 20, left: 15, right: 15),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             widget.title,
//                                             maxLines: 1,
//                                             style:
//                                                 hintTextStyle(context)?.copyWith(
//                                               color: Colors.grey,
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 14.sp,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           Text(
//                                             'Description',
//                                             maxLines: 1,
//                                             style:
//                                                 hintTextStyle(context)?.copyWith(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 16.sp,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           // Navigator.push(
//                                           //   context,
//                                           //   MaterialPageRoute(
//                                           //       builder: (_) => 
//                                           //       AddWorkoutProgram(
//                                           //             isEditScreen: true,
//                                           //             title:
//                                           //                 'Bodywieght for Uper Boday',
//                                           //             description:
//                                           //                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam dui nascetur vulputate vehicula odio vestibulum tellus scelerisque. Id quam sit ridiculus arcu arcu, egestas purus. Morbi fermentum sollicitudin sagittis gravida tempor, risus. Nunc dictum pellentesque feugiat sed vitae scelerisque risus, elementum.',
//                                           //             completionBadge: '',
//                                           //             difficultyLevel: '',
//                                           //             programType: '',
//                                           //           )),
//                                           // );
//                                         },
//                                         child: Container(
//                                           height: defaultSize.screenWidth * .09,
//                                           width: defaultSize.screenWidth * .09,
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             borderRadius: const BorderRadius.only(
//                                               topRight: Radius.circular(30.0),
//                                               topLeft: Radius.circular(30.0),
//                                               bottomLeft: Radius.circular(30.0),
//                                               bottomRight: Radius.circular(30.0),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Icon(
//                                               Icons.edit,
//                                               color: Colors.blue,
//                                               size: defaultSize.screenWidth * .05,
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   SB_1H,
//                                   Text(
//                                     'Description',
//                                     maxLines: 1,
//                                     style: hintTextStyle(context)?.copyWith(
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14.sp,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam dui nascetur vulputate vehicula odio vestibulum tellus scelerisque. Id quam sit ridiculus arcu arcu, egestas purus. Morbi fermentum sollicitudin sagittis gravida tempor, risus. Nunc dictum pellentesque feugiat sed vitae scelerisque risus, elementum.',
//                                     style: hintTextStyle(context)?.copyWith(
//                                       color: Colors.black,
//                                       fontSize: 12.sp,
//                                     ),
//                                   ),
//                                   SB_1H,
//                                   Container(
//                                     height: defaultSize.screenHeight * .08,
//                                     width: defaultSize.screenWidth,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.withOpacity(0.2),
//                                       borderRadius:const BorderRadius.only(
//                                         topRight: Radius.circular(10.0),
//                                         topLeft: Radius.circular(10.0),
//                                         bottomLeft: Radius.circular(10.0),
//                                         bottomRight: Radius.circular(10.0),
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical:
//                                               defaultSize.screenHeight * .02,
//                                           horizontal: 10),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                             height:
//                                                 defaultSize.screenHeight * .08,
//                                             width: defaultSize.screenWidth * 0.5,
//                                             child: Text(
//                                               'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam du',
//                                               style: hintTextStyle(context)
//                                                   ?.copyWith(
//                                                 color: Colors.black,
//                                                 fontSize: 10.sp,
//                                               ),
//                                               maxLines: 2,
//                                             ),
//                                           ),
//                                           CupertinoSwitch(
//                                             value: _switchValue,
//                                             activeColor: Colors.blue,
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 _switchValue = value;
//                                               });
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SB_1H,
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Completion  Badge',
//                                               style: hintTextStyle(context)
//                                                   ?.copyWith(
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 10.sp,
//                                               ),
//                                               maxLines: 1,
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 Icon(
//                                                   Icons.badge,
//                                                   color: Colors.amber,
//                                                 ),
//                                                 SB_1W,
//                                                 Text(
//                                                   'Gold',
//                                                   style: hintTextStyle(context)
//                                                       ?.copyWith(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 10.sp,
//                                                   ),
//                                                   maxLines: 2,
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Rating',
//                                               style: hintTextStyle(context)
//                                                   ?.copyWith(
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 10.sp,
//                                               ),
//                                               maxLines: 1,
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 RatingBar.builder(
//                                                   initialRating: 3.5,
//                                                   minRating: 1,
//                                                   //ignoreGestures: true,
//                                                   direction: Axis.horizontal,
//                                                   allowHalfRating: true,
//                                                   itemSize: 15,
//                                                   itemCount: 5,
//                                                   //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
//                                                   itemBuilder: (context, _) =>
//                                                       const Icon(
//                                                     Icons.star,
//                                                     color: Colors.amber,
//                                                   ),
//                                                   onRatingUpdate: (rating) {
//                                                     print(rating);
//                                                   },
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Text(
//                                                   '3.5',
//                                                   style: hintTextStyle(context)
//                                                       ?.copyWith(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 10.sp,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   SB_1H,
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Program Type',
//                                               style: hintTextStyle(context)
//                                                   ?.copyWith(
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 10.sp,
//                                               ),
//                                               maxLines: 1,
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Text(
//                                               'Easy',
//                                               style: hintTextStyle(context)
//                                                   ?.copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 10.sp,
//                                               ),
//                                               maxLines: 2,
//                                             )
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Difficulty Level',
//                                               style: hintTextStyle(context)
//                                                   ?.copyWith(
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 10.sp,
//                                               ),
//                                               maxLines: 1,
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Text(
//                                               'Easy',
//                                               style: hintTextStyle(context)
//                                                   ?.copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 10.sp,
//                                               ),
//                                               maxLines: 2,
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SB_1H,
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Views',
//                                               style: hintTextStyle(context)
//                                                   ?.copyWith(
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 10.sp,
//                                               ),
//                                               maxLines: 1,
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 Icon(
//                                                   Icons.remove_red_eye,
//                                                   color: Colors.blue,
//                                                 ),
//                                                 SB_1W,
//                                                 Text(
//                                                   '1000',
//                                                   style: hintTextStyle(context)
//                                                       ?.copyWith(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 10.sp,
//                                                   ),
//                                                   maxLines: 2,
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     // SingleChildScrollView(
//                     //   physics: const ScrollPhysics(),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       Padding(
//                     //         padding: EdgeInsets.only(top: 2.h),
//                     //         child: WorkoutProgramTile(
//                     //           image: WORKOUT_COVER2,
//                     //           title: "Workout Title",
//                     //           description: "Body Workout Programs",
//                     //           callback: () {},
//                     //         ),
//                     //       ),
//                     //       Text(
//                     //         AppLocalisation.getTranslated(
//                     //             context, LKWorkoutWeek),
//                     //         style: subTitleTextStyle(context)?.copyWith(
//                     //           color: Colors.black,
//                     //           fontSize: 18.sp,
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ],
//             )
//             // ;
//           // }
//           // return Container();
//         // },
//       // ),
//     );
//   }
// }
