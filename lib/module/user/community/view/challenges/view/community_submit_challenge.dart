import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/user/models/community_challenges_model.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../../repo/repository/web_service.dart';
import '../../../../../../res/constants.dart';
import '../../../../../../services/localisation.dart';
import '../../../../../../utils/nav_router.dart';
import '../../../../../influencer/more/widget/custom_alert_dialog.dart';
import '../../../../../influencer/more/widget/pop_alert_dialog.dart';
import '../../../../../influencer/widgets/media_upload_progress_popup.dart';
import '../../../../../influencer/widgets/show_snackbar.dart';
import '../../../../../influencer/workout_programs/widgets/video_player_widget.dart';
import '../bloc/community_challenges_cubit.dart';
import 'community_participants_by_community_screen.dart';
import 'community_participants_by_influencer_screen.dart';

class CommunitySubmitChallenge extends StatefulWidget {
  final CommunityChallenge challenge;

  const CommunitySubmitChallenge({Key? key, required this.challenge})
      : super(key: key);

  @override
  State<CommunitySubmitChallenge> createState() =>
      _CommunitySubmitChallengeState();
}

class _CommunitySubmitChallengeState extends State<CommunitySubmitChallenge> {
  String date = "";
  bool isSubmitPressed = false;
  DateTime now = DateTime.now();
  late CommunityChallengesCubit communityChallengesCubit;

  @override
  void initState() {
    super.initState();
    communityChallengesCubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    date = DateFormat('yyyy-MM-d kk:mm:ss').format(now);
    print("daud -> $date");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(alignment: Alignment.bottomCenter, children: [
        AppBody(
          title: AppLocalisation.getTranslated(context, LKSubmitYourChallenge),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.challenge.title!,
                  style: subTitleTextStyle(context)
                      ?.copyWith(fontSize: defaultSize.screenWidth * .050),
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.challenge.description}',
                  style: labelTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .040,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: MediaTypeSelectionCard(
                      callback: /*() {
                          _pickImagesFromGallery();
                        }*/
                          () => popUpAlertDialog(
                                context,
                                'Pick Image',
                                LKImageDialogDetail,
                                isProfile: true,
                                mediaType: CameraMediaType.VIDEO,
                                onCameraTap: (type) {
                                  _pickImage(Pickers.instance.sourceCamera,
                                      type: type);
                                },
                                onGalleryTap: () {
                                  // _pickImage(ImageSource.gallery);
                                  _pickImagesFromGallery();
                                },
                              ),
                      child: _createPostImageFiles.isNotEmpty
                          ? _createPostImageFiles[0].path.contains('mp4')
                              ? Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      child: VideoPlayerWidget(
                                        url: '',
                                        file: _createPostImageFiles[0],
                                        mediaTypeisLocalVideo: true,
                                      ),
                                      width: defaultSize.screenWidth,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                        onTap: () {
                                          //Navigator.pop(context);
                                          setState(() {
                                            _createPostImageFiles.clear();
                                          });
                                          // _workoutProgramBloc
                                          //     .add(SetStateEvent());
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: SvgPicture.asset(
                                              'assets/svgs/cross_icon.svg',
                                              height: 25,
                                              width: 25),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      child: Image.file(
                                        _createPostImageFiles[0],
                                        fit: BoxFit.cover,
                                      ),
                                      width: defaultSize.screenWidth,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                        onTap: () {
                                          //Navigator.pop(context);
                                          setState(() {
                                            _createPostImageFiles.clear();
                                          });
                                          // _workoutProgramBloc
                                          //     .add(SetStateEvent());
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          child: SvgPicture.asset(
                                              'assets/svgs/cross_icon.svg',
                                              height: 25,
                                              width: 25),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                          : null),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalisation.getTranslated(context, LKParticipants),
                  style: labelTextStyle(context)?.copyWith(
                    fontSize: defaultSize.screenWidth * .040,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.challenge.participantsCount ?? 0} Submitted",
                      style: subTitleTextStyle(context)?.copyWith(
                        fontSize: defaultSize.screenWidth * .040,
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {

                          var isWinnerByCommunity = widget.challenge.winnerBy
                              ?.toLowerCase()
                              .contains(CHALLENGE_COMMUNITY);
                          if (isWinnerByCommunity ?? false)
                            NavRouter.push(
                                context, CommunityParticipantsByCommunityScreen(widget.challenge));
                          else
                            NavRouter.push(
                                context,
                                CommunityParticipantsByInfluencerScreen(widget.challenge,
                                    isWinnerByCommunity: isWinnerByCommunity ?? false));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          AppLocalisation.getTranslated(
                              context, LKViewParticipants),
                          style: labelTextStyle(context)?.copyWith(
                              fontSize: defaultSize.screenWidth * .040,
                              color: const Color(0xff498AEE)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ),
          // ],
          // ),

          // )
        )
      ]),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
          title: AppLocalisation.getTranslated(context, LKSubmitChallenge),
          isButtonDisabled: false,
          callback: () async {
            if (_createPostImageFiles == null || _createPostImageFiles.isEmpty) {
              showSnackBar(context, 'Please Attach Media');
              return;
            }

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StreamBuilder<ProgressFile>(
                    stream: communityChallengesCubit
                        .progressStream,
                    builder: (context, snapshot) {
                      return CustomAlertDialog(
                        isSmallSize: true,
                        contentWidget: MediaUploadProgressPopup(
                          snapshot: snapshot,
                        ),
                      );
                    });
              },
            );

            isSubmitPressed = true;
            Map<String, String> temp = {
              "completed_at": date,
              "assetType": _createPostImageFiles.first.path.contains(".mp4")
                  ? "Video"
                  : "Image"
            };
            print(temp);
            bool res = await communityChallengesCubit
                .submitChallenge(temp, ['imageVideoURL'],
                    [_createPostImageFiles.first.path],widget.challenge.id!);
            isSubmitPressed = false;
            if (res) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  List<File> _createPostImageFiles = [];

  _pickImagesFromGallery() async {
    Pickers.instance.pickFromGallery().then((path) {
      if (path != null) {
        setState(() {
          _createPostImageFiles = path;
        });
      }
    });
  }

  String? path;
  String? netImage;

  _pickImage(String source, {CameraMediaType? type}) async {
    path = await Pickers.instance.pickImage(source: source, mediaType: type);
    if (path != null) {
      setState(() {
        _createPostImageFiles.add(File(path!));
      });
    }
  }
}
