import 'package:app/module/influencer/workout/widgets/add_link.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SocialLinks extends StatefulWidget {
  final String youtube;
  final String instagram;
  final String facebook;
  final String snapchat;
  final bool showEditIcon;

  const SocialLinks(
      {Key? key,
      required this.youtube,
      required this.instagram,
      required this.facebook,
      required this.snapchat,
      this.showEditIcon = true})
      : super(key: key);

  @override
  State<SocialLinks> createState() => _SocialLinksState();
}

class _SocialLinksState extends State<SocialLinks> {
  @override
  Widget build(BuildContext context) {
    // final _linkBloc = BlocProvider.of<LinkBloc>(context);
    return Scaffold(
      body: AppBody(
        bgColor: backgroundColor,
        title: "Social Media Links",
        // applyPaddingH: false,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SB_1H,
                  Visibility(
                    visible: widget.showEditIcon,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AddLinks(
                                          facebook: widget.facebook,
                                          youtube: widget.youtube,
                                          instagram: widget.instagram,
                                          snapchat: widget.snapchat,
                                        )));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              PIN,
                              color: PRIMARY_COLOR,
                              height: WIDTH_2,
                              width: WIDTH_2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.youtube.isNotEmpty) ...[
                    LinkItem(
                        subtitle: widget.youtube,
                        title: 'Youtube',
                        icon: YOUTUBE),
                    SB_1H,
                  ],
                  if (widget.instagram.isNotEmpty) ...[
                    LinkItem(
                        subtitle: widget.instagram,
                        title: 'Instagram',
                        icon: INSTAGRAM),
                    SB_1H,
                  ],
                  if (widget.facebook.isNotEmpty) ...[
                    LinkItem(
                        subtitle: widget.facebook,
                        title: 'Facebook',
                        icon: FACEBOOK),
                    SB_1H,
                  ],
                  if (widget.snapchat.isNotEmpty) ...[
                    LinkItem(
                        subtitle: widget.snapchat,
                        title: 'Snapchat',
                        icon: SNAPCHAT),
                    SB_1H,
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinkItem extends StatelessWidget {
  final String subtitle;
  final String title;
  final String icon;
  const LinkItem(
      {Key? key,
      required this.subtitle,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: headingTextStyle(context)!.copyWith(fontSize: 15.sp),
              ),
              Text(
                subtitle,
                style: labelTextStyle(context)!
                    .copyWith(fontSize: 10.sp, color: PRIMARY_COLOR),
              )
            ],
          )
        ],
      ),
      SB_1H,
    ]);
  }
}
