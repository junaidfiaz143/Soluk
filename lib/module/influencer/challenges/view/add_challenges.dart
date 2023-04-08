import 'dart:io';

import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/badges_modal.dart';
import 'package:app/module/influencer/challenges/widget/badge_dropdown.dart';
import 'package:app/module/influencer/challenges/widget/soluk_date_time.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../repo/repository/web_service.dart';
import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';
import '../../more/widget/custom_alert_dialog.dart';
import '../../more/widget/pop_alert_dialog.dart';
import '../../widgets/media_upload_progress_popup.dart';
import '../../workout_programs/widgets/video_player_widget.dart';
import '../widget/choose_winner_dropdown.dart';

class AddChallenges extends StatefulWidget {
  static const String id = "/add_challenges";

  const AddChallenges({Key? key}) : super(key: key);

  @override
  State<AddChallenges> createState() => _AddChallengesState();
}

class _AddChallengesState extends State<AddChallenges> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();
  String date = "";
  String time = "";
  String tempTime = "";
  CompletionBadge? badge;
  String? winner;
  bool isSubmitPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(alignment: Alignment.bottomCenter, children: [
        AppBody(
          title: AppLocalisation.getTranslated(context, LKAddChallenges),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediaTypeSelectionCard(
                    callback: /*() {
                        _pickImagesFromGallery();
                      }*/
                        () => popUpAlertDialog(
                              context,
                              'Pick Image',
                              LKImageDialogDetail,
                              isProfile: true,
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
                                      autoPlay: false,
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
                SB_1H,
                SalukTextField(
                  textEditingController: _titleController,
                  hintText: "",
                  labelText:
                      AppLocalisation.getTranslated(context, LKAddChallenge),
                ),
                SB_1H,
                BadgeDropDown(onValueChange: (value) => badge = value),
                SB_1H,
                ChooseWinnerDropDown(onValueChange: (value) => winner = value),
                SB_1H,
                SolukDateTime(
                    onDateChange: (value) => date = value,
                    onTimeChange: (value, tTime) {
                      time = value;
                      tempTime = tTime;
                    }),
                SB_1H,
                SalukTextField(
                  textEditingController: _descriptionController,
                  hintText:
                      AppLocalisation.getTranslated(context, LKDescription),
                  labelText: "",
                  maxLines: 8,
                ),
                SB_5H,
                SB_5H,
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
          title: AppLocalisation.getTranslated(context, LKSubmit),
          isButtonDisabled: false,
          callback: () async {
            if (badge == null ||
                _titleController.text.isEmpty ||
                _descriptionController.text.isEmpty ||
                date.isEmpty ||
                time.isEmpty ||
                winner == null) {
              showSnackBar(context, 'Please fill all fields');
              return;
            }

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StreamBuilder<ProgressFile>(
                    stream: BlocProvider.of<ChallengesblocCubit>(context)
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
              "badge": "${badge!.badgeId}",
              "title": _titleController.text,
              "description": _descriptionController.text,
              "expiryDateTime": "$date $tempTime",
              "assetType": "Image",
              'winnerBy': winner!
            };
            print(temp);
            bool res = await BlocProvider.of<ChallengesblocCubit>(context)
                .addChallenge(temp, ['imageVideoURL'],
                    [_createPostImageFiles.first.path]);
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
