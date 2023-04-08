// import 'package:app/module/influencer/challenges/model/challenge.dart';
// import 'package:app/module/influencer/widgets/empty_screen.dart';
// import 'package:app/module/influencer/widgets/item_details.dart';
// import 'package:app/module/influencer/widgets/item_tile.dart';
// import 'package:app/module/influencer/widgets/searchfield_with_prefixicon.dart';
// import 'package:app/res/globals.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:app/repo/data_source/remote_data_source.dart';

// import '../view/add_challenges.dart';
// import 'challenge_types_chip.dart';
// import 'filtered_search.dart';

// class ChallengeStates extends StatelessWidget {
//   final Widget onLoading;
//   final Widget noDataFound;
//   final Widget initialWidget;
//   const ChallengeStates({
//     Key? key,
//     required this.onLoading,
//     required this.noDataFound,
//     required this.initialWidget,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChallengesCubit, ApiResponseStateX>(
//       listener: (_, s) {
//         if (s is ApiErrorState) {
//           throw "Network Error";
//         }
//       },
//       builder: (ctx, state) {
//         if (state is ApiInitialState) {
//           return initialWidget;
//         } else if (state is ApiLoadingState) {
//           return onLoading;
//         } else if (state is ApiLoadedState && state.data != null) {
//           if (state.data != null) {
//             GetAllChallenges data = state.data;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const ChallengeTypeChips(),
//                 SB_1H,
//                 const SearchFieldWithPrefixIcon(),
//                 SB_1H,
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount: data.allChallenges!.length,
//                       shrinkWrap: true,
//                       itemBuilder: (ctx, i) {
//                         return Column(
//                           children: [
//                             ItemTile(
//                               callback: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => const ItemDetails(
//                                       title: "Challenge 1",
//                                       route: "challenge",
//                                       blog:
//                                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra sit lobortis sed placerat vulputate blandit sagittis, hac gravida. Condimentum enim lacinia a, sagittis, sed felis tempor nec vivamus. Neque eu facilisis tincidunt convallis orci ac quam nulla ornare. Arcu a massa donec nulla ut viverra amet, nibh gravida. Sit tellus sapien, tempor sed molestie sed lorem. Proin enim maecenas praesent at malesuada aliquam ornare sit. Scelerisque lacus nunc, pellentesque egestas tellus rhoncus. Rhoncus bibendum eu ante sed at. Convallis tellus elementum iaculis magna et. Malesuada mauris, risus, viverra congue congue nec. Pharetra orci massa curabitur nibh placerat vitae et amet malesuada.",
//                                     ),
//                                   ),
//                                 );
//                               },
//                               model: data.allChallenges![i],
//                               isChallenge: true,
//                             ),
//                             SB_1H,
//                           ],
//                         );
//                       }),
//                 ),
//               ],
//             );
//           } else {
//             return EmptyScreen(
//               callback: () {
//                 navigatorKey.currentState?.pushNamed(AddChallenges.id);
//               },
//               title: "Create Challenges",
//             );
//           }
//         } else if (state is ApiLoadedState && state.data == null) {
//           return noDataFound;
//         }
//         return noDataFound;
//       },
//     );
//   }
// }
