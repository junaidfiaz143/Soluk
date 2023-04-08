import 'package:app/module/influencer/challenges/cubit/comments_bloc/commentsbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/comments_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../../animations/slide_up_transparent_animation.dart';
import '../../../../../repo/data_source/local_store.dart';
import '../../../../../res/color.dart';
import '../../../../../res/constants.dart';
import '../../../../../res/globals.dart';
import '../../../../../services/localisation.dart';
import '../../../more/widget/custom_alert_dialog.dart';
import '../../../widgets/reward_popup.dart';
import '../../../widgets/saluk_gradient_button.dart';

class CommentTile extends StatelessWidget {
  final Data item;
  final String? userId;

  const CommentTile({Key? key, required this.item, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = item.user!.imageUrl;
    // DateTime date=DateFormat("yyyy-MM-dd HH:mm:ss").parse(item.createdDate??'');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: HEIGHT_3,
          height: HEIGHT_3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: imageUrl == null
                ? SvgPicture.asset(
                    'assets/svgs/placeholder.svg',
                    width: HEIGHT_3,
                    height: HEIGHT_3,
                  )
                : CachedNetworkImage(
                    width: HEIGHT_3,
                    height: HEIGHT_3,
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: PRIMARY_COLOR,
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.user?.fullname ?? 'Hello',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: item.user!.roleId == 1
                            ? Colors.blue
                            : Colors.black),
                  ),
                  // Container(
                  //     width: 10,
                  //     height: 10,
                  //     decoration: BoxDecoration(color: Colors.blue),
                  //     child: Icon(Icons.check)),
                  Visibility(
                    visible: item.user!.roleId == 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Image.asset(
                          'assets/images/official_check_icon.png',
                          scale: 4),
                    ),
                  ),
                  Spacer(),
                  FutureBuilder<dynamic>(
                      future: LocalStore.getData(PREFS_USERTYPE),
                      builder: (context, snapshot) {
                        return (snapshot.data == INFLUENCER ||
                                userId == item.user?.id?.toString())
                            ? GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState?.push(
                                    SlideUpTransparentRoute(
                                      enterWidget: CustomAlertDialog(
                                        sigmaX: 0,
                                        sigmaY: 0,
                                        contentWidget: RewardPopUp(
                                          iconPath:
                                              'assets/images/ic_dialog_delete.png',
                                          title: AppLocalisation.getTranslated(
                                              context, LKDelete),
                                          content:
                                              AppLocalisation.getTranslated(
                                                  context,
                                                  LKConfirmDeleteComment),
                                          actionButtons: Row(
                                            children: [
                                              SizedBox(
                                                width: defaultSize.screenWidth *
                                                    .37,
                                                child: SalukGradientButton(
                                                  title: AppLocalisation
                                                      .getTranslated(
                                                          context, LKYes),
                                                  onPressed: () async {
                                                    BlocProvider.of<
                                                                CommentsblocCubit>(
                                                            context)
                                                        .delete(
                                                            '${item.challengeId}',
                                                            '${item.ccId}');
                                                    Navigator.pop(context);
                                                  },
                                                  buttonHeight: HEIGHT_3,
                                                ),
                                              ),
                                              const Spacer(),
                                              SizedBox(
                                                width: defaultSize.screenWidth *
                                                    .37,
                                                child: SalukGradientButton(
                                                  title: AppLocalisation
                                                      .getTranslated(
                                                          context, LKNo),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  buttonHeight: HEIGHT_3,
                                                  linearGradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Colors.black,
                                                      Colors.black,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      routeName: CustomAlertDialog.id,
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.delete_rounded,
                                    color: Color(0xffF85656),
                                    size: 20,
                                  ),
                                ),
                              )
                            : SizedBox.shrink();
                      }),
                ],
              ),
              const SizedBox(height: 2),
              Padding(
                padding: EdgeInsets.only(right: 14),
                child: Text(
                  '${item.description!}',
                  // 'Lorem ipsum dolor sit amet, consectetur adipis elit. Lacus, sit Rhoncus matti. Rhoncus, massa rutrum ut fermentum in.,',
                  style: TextStyle(fontSize: 12),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 1),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  Jiffy(item.createdDate, "yyyy-MM-dd HH:mm:ss").fromNow(),
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ),
              const SizedBox(height: 4),
              const Divider(thickness: 0.6),
            ],
          ),
        )
      ],
    );
  }
}
