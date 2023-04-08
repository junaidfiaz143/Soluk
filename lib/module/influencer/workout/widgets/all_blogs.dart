import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:app/module/influencer/workout/bloc/blog_bloc.dart';
import 'package:app/module/influencer/workout/widgets/add_blog.dart';
import 'package:app/module/influencer/workout/widgets/blog_detail.dart';
import 'package:app/module/influencer/workout/widgets/components/cardView.dart';
import 'package:app/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBlogs extends StatefulWidget {
  const AllBlogs({Key? key}) : super(key: key);

  @override
  State<AllBlogs> createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  
  @override
  Widget build(BuildContext context) {
    final _blogBloc = BlocProvider.of<BlogBloc>(context);
    return Scaffold(
      body: AppBody(
        title: "Add Blog",
        body:ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return PlanTile(image: WORKOUT_COVER2,title: 'helelele',callback: (){
          //     Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) =>const  BlogDetail(title: 'helelele'),
          //   ),
          // );
            },);
          },
        )
      ),
        floatingActionButton: FAB(
        callback: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddBlog(),
            ),
          );
        },
      ),
    );
  }
}
