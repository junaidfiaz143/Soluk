import 'dart:convert';

import 'package:app/module/common/commonbloc.dart';
import 'package:app/module/influencer/widgets/back_button.dart';
import 'package:app/module/influencer/workout/bloc/blog_bloc/blogbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/blog_modal.dart';
import 'package:app/module/influencer/workout/model/meals_modal.dart'
    as mealMod;
import 'package:app/module/influencer/workout/widgets/add_blog.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as fq;
import 'package:sizer/sizer.dart';

class BlogDetail extends StatefulWidget {
  static const id = 'ProgramDetail';
  Data? blog;
  final mealMod.Data? mealBlog;
  final bool isMealBlog;

  BlogDetail({Key? key, this.blog, this.isMealBlog = false, this.mealBlog})
      : super(key: key);

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  bool _switchValue = true;
  fq.QuillController _controller = fq.QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.blog != null) {
      var myJSON = jsonDecode(widget.blog!.blogText!);
      _controller = fq.QuillController(
        document: fq.Document.fromJson(myJSON),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    if (widget.mealBlog != null) {
      var myJSON = jsonDecode(widget.mealBlog!.blogText!);
      _controller = fq.QuillController(
        document: fq.Document.fromJson(myJSON),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    // _workoutProgramBloc.add(SubscribersListLoadingEvent());
    CommonBloc commonBloc = BlocProvider.of(context);
    BlogblocCubit blogbloc = BlocProvider.of(context);

    if (commonBloc.userType == NORMAL_USER) {
      widget.isMealBlog
          ? blogbloc.addBlogView(blogId: widget.mealBlog!.id.toString())
          : blogbloc.addBlogView(blogId: widget.blog!.id.toString());
    }

    return Scaffold(
        body:
            // BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
            //   listener: (context, state) {
            //     // if (state is SubscribersListLoadingState) {
            //     //   Future.delayed(const Duration(seconds: 2), () {
            //     //     _workoutProgramBloc.add(SubscribersListLoadedEvent());
            //     //   });
            //     // }
            //   },
            //   builder: (context, state) {
            //     // if (state is SubscribersListLoadingState) {
            //     //   return const Center(
            //     //     child: CircularProgressIndicator(
            //     //       color: Colors.grey,
            //     //     ),
            //     //   );
            //     // }
            //     // if (state is SubscribersListLoadedState) {
            //       return
            Column(
      children: [
        // SB_1H,

        Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: HEIGHT_5 * 3.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      widget.mealBlog?.imageUrl ?? widget.blog?.imageUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SB_1H,
                SB_1H,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SolukBackButton(
                        callback: () {},
                      ),
                      Text(
                        'Blog',
                        // widget.blog.title!,
                        style: subTitleTextStyle(context)?.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      commonBloc.userType == INFLUENCER
                          ? InkWell(
                              onTap: () async {
                                bool res = false;
                                if (widget.isMealBlog) {
                                  /*final blogbloc =
                                      BlocProvider.of<MealblocCubit>(context);*/
                                  res = await blogbloc
                                      .delete('${widget.mealBlog!.id!}');
                                } else {
                                  res = await blogbloc
                                      .delete('${widget.blog!.id!}');
                                }

                                if (res) Navigator.pop(context);
                              },
                              child: Container(
                                height: defaultSize.screenWidth * .09,
                                width: defaultSize.screenWidth * .09,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.red,
                                    size: defaultSize.screenWidth * .05,
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: HEIGHT_5 * 1.5,
                ),
                Container(
                  width: double.maxFinite,
                  height: defaultSize.screenHeight * 0.7,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
                                    maxLines: 1,
                                    style: hintTextStyle(context)?.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.mealBlog?.title ??
                                        widget.blog?.title ??
                                        '',
                                    maxLines: 1,
                                    style: hintTextStyle(context)?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                              commonBloc.userType == INFLUENCER
                                  ? InkWell(
                                      onTap: () async {
                                        var result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => AddBlog(
                                                    nutrientId:
                                                        '${widget.mealBlog?.nutritionId}',
                                                    blog: widget.blog,
                                                    mealBlog: widget.mealBlog,
                                                    isMealBlog:
                                                        widget.isMealBlog,
                                                  )),
                                        );
                                        if (result != null) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        height: defaultSize.screenWidth * .09,
                                        width: defaultSize.screenWidth * .09,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            topLeft: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                            size: defaultSize.screenWidth * .05,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          SB_1H,
                          Text(
                            'Description',
                            maxLines: 1,
                            style: hintTextStyle(context)?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          fq.QuillEditor(
                            controller: _controller,
                            readOnly: true,
                            showCursor: false,
                            autoFocus: false,
                            focusNode: _focusNode,
                            scrollable: true,
                            expands: false,
                            scrollController: ScrollController(),
                            padding: EdgeInsets.zero,
                          ),

                          // Text(
                          //   widget.blog.blogText!,
                          //   style: hintTextStyle(context)?.copyWith(
                          //     color: Colors.black,
                          //     fontSize: 12.sp,
                          //   ),
                          // ),
                          SB_1H,
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
