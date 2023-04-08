import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/empty_screen.dart';
import 'package:app/module/influencer/workout/bloc/social_links_bloc/sociallinksbloc_cubit.dart';
import 'package:app/module/influencer/workout/widgets/add_link.dart';
import 'package:app/module/influencer/workout/widgets/social_links.dart';
import 'package:app/res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Links extends StatelessWidget {
  const Links({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SociallinksblocCubit>(context).getSocialLinks();
    return BlocBuilder<SociallinksblocCubit, SociallinksblocState>(
        builder: (_, state) {
      if (state is SocialLinksLoading) {
        return const Scaffold(
          backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
          body: AppBody(
            title: "Links",
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ),
          ),
        );
      }
      if (state is SociallinksLoaded) {
        return SocialLinks(
          facebook: state.socialLinks?.responseDetails?.facebook ?? '',
          instagram: state.socialLinks?.responseDetails?.instagram ?? '',
          youtube: state.socialLinks?.responseDetails?.youtube ?? '',
          snapchat: state.socialLinks?.responseDetails?.snapchat ?? '',
        );
      }
      if (state is SocialLinksEmpty) {
        return Scaffold(
          backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
          body: AppBody(
              title: "Links",
              body:
                  // if (state is SocialLinksEmpty) {
                  // return
                  EmptyScreen(
                    title: "Add Links",
                hideAddButton: true,
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddLinks(),
                    ),
                  );
                },
              )
              // ;

              ),
        );
        // floatingActionButton: BlocBuilder<LinkBloc, List<LinkModel>>(
        //   builder: (context, snapshot) {
        //     return snapshot.isNotEmpty
        //         ? FloatingActionButton(
        //             onPressed: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (_) => const AddLinks(),
        //                 ),
        //               );
        //             },
        //             child: Icon(
        //               Icons.add,
        //               size: WIDTH_4,
        //             ),
        //             backgroundColor: PRIMARY_COLOR,
        //           )
        //         : Container();
        //   },
        // ),

// }
      }
      return Container();
    });
  }
}
