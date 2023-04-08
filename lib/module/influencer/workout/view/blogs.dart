import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/empty_screen.dart';
import 'package:app/module/influencer/workout/bloc/blog_bloc/blogbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/blog_modal.dart';
import 'package:app/module/influencer/workout/widgets/add_blog.dart';
import 'package:app/module/influencer/workout/widgets/blog_detail.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/module/influencer/workout_programs/widgets/plan_title.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/data_source/local_store.dart';

class Blogs extends StatelessWidget {
  final String? selectedInfluencerId;
  const Blogs({Key? key, this.selectedInfluencerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _blogBloc = BlocProvider.of<BlogblocCubit>(context);
    _blogBloc.selectedInfluencerId = selectedInfluencerId;
    _blogBloc.getBlogs();
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        bgColor: backgroundColor,
        title: "Blogs",
        body: BlocBuilder<BlogblocCubit, BlogblocState>(builder: (_, state) {
          if (state is BlogblocLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else if (state is BlogblocEmpty) {
            return EmptyScreen(
              title: "No Blogs Found",
              hideAddButton: true,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddBlog(),
                  ),
                );
              },
            );
          } else {
            return RefreshWidget(
              refreshController: _blogBloc.refreshController,
              onLoadMore: () {
                _blogBloc.onLoadMore();
              },
              onRefresh: () {
                _blogBloc.onRefresh();
              },
              enablePullDown: false,
              child: ListView.builder(
                itemCount: state.blogData?.responseDetails?.data?.length ?? 0,
                itemBuilder: (ctx, i) {
                  Data item = state.blogData!.responseDetails!.data![i];
                  return PlanTile(
                    image: item.imageUrl!,
                    title: item.title!,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlogDetail(blog: item),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        }),
      ),
      floatingActionButton: BlocBuilder<BlogblocCubit, BlogblocState>(
        builder: (context, snapshot) {
          return snapshot is! BlogblocEmpty
              ? FutureBuilder<dynamic>(
                  future: LocalStore.getData(PREFS_USERTYPE),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == INFLUENCER) {
                      return FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddBlog(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          size: WIDTH_4,
                        ),
                        backgroundColor: PRIMARY_COLOR,
                      );
                    }
                    return SizedBox.shrink();
                  })
              : SizedBox.shrink();
        },
      ),
    );
  }
}
