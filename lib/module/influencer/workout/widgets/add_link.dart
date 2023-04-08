import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout/bloc/link_bloc.dart';
import 'package:app/module/influencer/workout/bloc/social_links_bloc/sociallinksbloc_cubit.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddLinks extends StatefulWidget {
  final String? youtube;
  final String? instagram;
  final String? facebook;
  final String? snapchat;

  const AddLinks(
      {Key? key, this.youtube, this.instagram, this.facebook, this.snapchat})
      : super(key: key);

  @override
  State<AddLinks> createState() => _AddLinksState();
}

class _AddLinksState extends State<AddLinks> {
  final _youtubeController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final _snapchatController = TextEditingController();

  @override
  void initState() {
    if (widget.youtube != null ||
        widget.instagram != null ||
        widget.facebook != null ||
        widget.snapchat != null) {
      _youtubeController.text = widget.youtube ?? '';
      _instagramController.text = widget.instagram ?? '';
      _facebookController.text = widget.facebook ?? '';
      _snapchatController.text = widget.snapchat ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _linkBloc = BlocProvider.of<LinkBloc>(context);
    return Scaffold(
      body: AppBody(
        title: "Add Links",
        // applyPaddingH: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SB_1H,
                    LinkItem(
                        controller: _youtubeController,
                        title: 'Youtube',
                        icon: YOUTUBE),
                    SB_1H,
                    LinkItem(
                        controller: _instagramController,
                        title: 'Instagram',
                        icon: INSTAGRAM),

                    SB_1H,
                    LinkItem(
                        controller: _facebookController,
                        title: 'Facebook',
                        icon: FACEBOOK),
                    SB_1H,
                    LinkItem(
                        controller: _snapchatController,
                        title: 'Snapchat',
                        icon: SNAPCHAT),
                    // SalukTextField(
                    //   textEditingController: _titleController,
                    //   hintText: '',
                    //   labelText: 'Title',
                    //   onChange: (_) {
                    //     setState(() {});
                    //   },
                    // ),
                    SB_1H,
                    // SalukTextField(
                    //   textEditingController: _linkController,
                    //   hintText: '',
                    //   labelText: 'Paste Link',
                    //   maxLines: 2,
                    //   onChange: (_) {
                    //     setState(() {});
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
            title: "Submit",
            callback: () async {
              print('object');
              if (_facebookController.text.isEmpty &&
                  (widget.facebook ?? '').isNotEmpty) {
                showSnackBar(
                  context,
                  "Field once filled cannot be emptied again",
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
                return;
              } else if (_youtubeController.text.isEmpty &&
                  (widget.youtube ?? '').isNotEmpty) {
                showSnackBar(
                  context,
                  "Field once filled cannot be emptied again",
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
                return;
              } else if (_instagramController.text.isEmpty &&
                  (widget.instagram ?? '').isNotEmpty) {
                showSnackBar(
                  context,
                  "Field once filled cannot be emptied again",
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
                return;
              } else if (_snapchatController.text.isEmpty &&
                  (widget.snapchat ?? '').isNotEmpty) {
                showSnackBar(
                  context,
                  "Field once filled cannot be emptied again",
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
                return;
              }
              // if(_facebookController.text.isEmpty || _instagramController.text.isEmpty ||_youtubeController.text.isEmpty){
              // showSnackBar(
              //   context,
              //   "Please fill all the fields",
              //   backgroundColor: Colors.black,
              //   textColor: Colors.white,
              // );
              // return;
              // }
              bool status = await BlocProvider.of<SociallinksblocCubit>(context,
                      listen: false)
                  .addSocialLinks(
                      fb: _facebookController.text,
                      insta: _instagramController.text,
                      yout: _youtubeController.text,
                      snapchat: _snapchatController.text);
              if (status) {
                Navigator.pop(context, 1);
              }
            },
            isButtonDisabled: false
            // _titleController.text.isEmpty || _linkController.text.isEmpty,
            ),
      ),
    );
  }
}

class LinkItem extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String icon;

  const LinkItem(
      {Key? key,
      required this.controller,
      required this.title,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          // SvgPicture.asset(icon),
          Image.asset(
            icon,
            height: 40,
            width: 40,
          ),
          SB_1W,
          Text(
            title,
            style: headingTextStyle(context)!.copyWith(fontSize: 15.sp),
          )
        ],
      ),
      SB_BY_4,
      SalukTextField(
        textEditingController: controller,
        hintText: '',
        labelText: 'Account Link',
        onChange: (_) {
          // setState(() {});
        },
      ),
    ]);
  }
}
