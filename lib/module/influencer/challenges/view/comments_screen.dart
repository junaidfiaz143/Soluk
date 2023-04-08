import 'package:app/module/influencer/challenges/cubit/comments_bloc/commentsbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/comments_modal.dart';
import 'package:app/module/influencer/challenges/widget/comment_textfield_widget.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../../widgets/app_body.dart';
import '../widget/cards_tiles/comment_tile.dart';

class CommentsScreen extends StatefulWidget {
  final String challengeId;
  final String? userId;

  const CommentsScreen({Key? key, required this.challengeId, this.userId})
      : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    BlocProvider.of<CommentsblocCubit>(context)
        .getComments(widget.challengeId); //widget.challengeId
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commentbloc = BlocProvider.of<CommentsblocCubit>(context);
    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKAllComments),
        titleHeight: 16,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 0.6),
            Expanded(
              child: BlocBuilder<CommentsblocCubit, CommentsblocState>(
                builder: (context, state) {
                  if (state is CommentsLoading) {
                    return Center(
                        child: CircularProgressIndicator(color: Colors.grey));
                  } else if (state is CommentsEmpty) {
                    return Center(
                        child: Text(
                      'No challenge comments found',
                      style: subTitleTextStyle(context)?.copyWith(
                          fontSize: defaultSize.screenHeight * .02,
                          fontWeight: FontWeight.normal),
                    ));
                  } else if (state is CommentsLoaded) {
                    return RefreshWidget(
                      refreshController: commentbloc.refreshController,
                      onLoadMore: () =>
                          commentbloc.onLoadMore(widget.challengeId),
                      onRefresh: () =>
                          commentbloc.onRefresh(widget.challengeId),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 20),
                        itemCount:
                            state.commentsData?.responseDetails?.data?.length ??
                                0,
                        itemBuilder: (context, index) {
                          Data item =
                              state.commentsData!.responseDetails!.data![index];
                          return CommentTile(item: item, userId: widget.userId);
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            CommentTextFieldWidget(challengeId: widget.challengeId)
          ],
        ),
      ),
    );
  }
}
