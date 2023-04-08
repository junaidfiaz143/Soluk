import 'package:app/module/influencer/widgets/empty_screen.dart';
import 'package:app/module/influencer/workout/bloc/about_me_bloc/aboutmebloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/tags_bloc/tagsbloc_cubit.dart';
import 'package:app/module/influencer/workout/widgets/add_influencer_detail.dart';
import 'package:app/module/influencer/workout/widgets/influencer_profile.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutMe extends StatefulWidget {
  AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    AboutmeblocCubit _aboutBloc = BlocProvider.of(context, listen: false);
    TagsblocCubit _tagsBloc = BlocProvider.of(context, listen: false);
    _aboutBloc.getInfluencerData();

    _tagsBloc.getTags();
    // final _getInfluencerBloc = BlocProvider.of<GetInfluencerBloc>(context);
    // _getInfluencerBloc.add(LoadingEvent());
    return BlocBuilder<AboutmeblocCubit, AboutmeblocState>(
      buildWhen: (previous, current) =>
      previous.influencerModel != current.influencerModel,
      builder: (context, state) {
        if (state is AboutmeblocInitial) {
          return SizedBox(
            height: HEIGHT_5 * 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        if (state is InfluencerDataLoaded) {
          if (state.influencerModel == null || state.influencerModel?.responseCode! == "15") {
            return SizedBox(
              height: HEIGHT_5 * 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmptyScreen(
                    title: "About Info ",
                    hideAddButton: true,
                    callback: () async {
                      // final result = await
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddInfluencerDetail(),
                        ),
                      );

                      if (result != null) {
                        _aboutBloc.getInfluencerData();
                      }
                      // setState(() {});
                    },
                  ),
                ],
              ),
            );
          } else {
            return InfluencerProfile(
              influencerInfo: state.influencerModel,
              valueChanged: (val) {
                setState(() {});
              },
            );
          }
        }

        return Container();
      },
    );
  }

// @override
// Widget build(BuildContext context) {
//   final AboutMeInfo? _hiveInfo = MyHive.getAboutInfo();
//
//   return BlocBuilder<InfluencerBloc, InfluencerInfo>(
//     builder: (_, state) {
//       // if (state.id == null) {
//       if (_hiveInfo == null) {
//         return SizedBox(
//           height: HEIGHT_5 * 6,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               EmptyScreen(
//                 title: "About Info",
//                 callback: () async {
//                   final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddInfluencerDetail(),),);
//                   setState(() {});
//                 },
//               ),
//             ],
//           ),
//         );
//       }else {
//         return InfluencerProfile(hiveInfo: _hiveInfo, valueChanged: (val){
//           setState(() {});
//         },);
//       }
//     },
//   );
// }
}
