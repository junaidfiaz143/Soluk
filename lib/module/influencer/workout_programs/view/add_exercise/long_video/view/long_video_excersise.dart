import 'dart:developer';
import 'dart:io';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/choice_chip_widget.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/widgets/video_container.dart';
import 'package:app/module/influencer/workout_programs/model/get_all_exercise_response.dart';
import 'package:app/module/influencer/workout_programs/view/add_exercise/long_video/bloc/exersise_bloc.dart';
import 'package:app/module/influencer/workout_programs/widgets/exercise_duration_dialog.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../repo/repository/web_service.dart';
import '../../../../../more/widget/custom_alert_dialog.dart';
import '../../../../../widgets/media_upload_progress_popup.dart';

class LongVideoExerciseScreen extends StatefulWidget {
  static const id = "AddExercise";
  final String? title;
  final String? workoutType;
  final String? description;
  final String? workoutID;
  final String? weekID;
  final String? dayID;
  Data? data;

  LongVideoExerciseScreen(
      {Key? key,
      this.title,
      this.description,
      this.workoutType,
      this.workoutID,
      this.weekID,
      this.dayID,
      this.data})
      : super(key: key);

  @override
  State<LongVideoExerciseScreen> createState() =>
      _LongVideoExerciseScreenState();
}

class _LongVideoExerciseScreenState extends State<LongVideoExerciseScreen> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();
  String longVideoExerciseDuration = "";
  String longVideoExerciseDurationMin = "";
  String? path;
  String? netImage;
  ExerciseCubit exerciseCubit = ExerciseCubit();

  // List<File> _createPostImageFiles = [];
  String? assetType;

  @override
  void initState() {
    if (widget.data != null) {
      _titleController.text = widget.data!.title;
      _descriptionController.text = widget.data!.instructions;
      netImage = widget.data!.assetUrl;
      assetType = widget.data!.assetType;
      longVideoExerciseDuration =
          solukFormatTime(widget.data!.exerciseTime)["time"]!;
      longVideoExerciseDurationMin =
          solukFormatTime(widget.data!.exerciseTime)["type"]!;
      solukLog(logMsg: "${widget.data!.exerciseTime}");
      solukLog(logMsg: "${solukFormatTime(widget.data!.exerciseTime)["type"]}");
      solukLog(
          logMsg: "$netImage",
          logDetail: "inside initState long_video_exercise");
      solukLog(
          logMsg: "${widget.data!.id}",
          logDetail: "inside initState long_video_exercise");
    }
    super.initState();
  }

  _pickImage(String source, {CameraMediaType? mediaType}) async {
    Pickers.instance
        .pickImage(source: source, mediaType: mediaType)
        .then((value) {
      print("image path :$path");
      if (value != null) {
        setState(() {
          path = value;
        });
      }
    });
  }

  _pickImagesFromGallery() async {
    Pickers.instance.pickFromGallery().then((_path) {
      if (_path != null) {
        solukLog(logMsg: _path[0].path);
        setState(() {
          path = _path[0].path;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    exerciseCubit = BlocProvider.of<ExerciseCubit>(context);

    log("NetImage ==>>> " + netImage.toString());
    log("Path ==>>> " + path.toString());
    return Scaffold(
      body: AppBody(
          title: widget.title!,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalisation.getTranslated(context, LKWorkoutType),
                  style: subTitleTextStyle(context)?.copyWith(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: choiceChipWidget(context,
                      title: "Long Video",
                      isIncomeSelected: true,
                      onSelected: (val) {}),
                ),
                SizedBox(
                  height: 20,
                ),
                SalukTextField(
                  textEditingController: _titleController,
                  hintText: "",
                  labelText:
                      AppLocalisation.getTranslated(context, LKExerciseName),
                ),
                SizedBox(
                  height: 20,
                ),
                if (netImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      !netImage!.contains("mp4")
                          ? ImageContainer(
                              isCloseShown: true,
                              path: netImage!,
                              onClose: () => setState(
                                () => netImage = null,
                              ),
                            )
                          : VideoContainer(
                              isCloseShown: true,
                              netUrl: netImage,
                              closeButton: () {
                                // Fluttertoast.showToast(msg: "msg");
                                setState(() {
                                  netImage = null;
                                });
                              },
                            ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: InkWell(
                      //     onTap: () {
                      //       //Navigator.pop(context);

                      //       setState(() {
                      //         netImage = null;
                      //       });
                      //       // _singleWorkOutCubit
                      //       //     .add(SetStateEvent());
                      //     },
                      //     child: Container(
                      //       width: 20,
                      //       height: 20,
                      //       child: SvgPicture.asset(
                      //           'assets/svgs/cross_icon.svg',
                      //           height: 25,
                      //           width: 25),
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Colors.grey.withOpacity(0.1),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  )
                else if (path == null)
                  MediaTypeSelectionCard(
                    callback: () {
                      log("working");
                      popUpAlertDialog(
                        context,
                        'Pick Image',
                        LKImageDialogDetail,
                        isProfile: true,
                        onCameraTap: (type) {
                          // Navigator.pop(context);
                          _pickImage(Pickers.instance.sourceCamera,
                              mediaType: type);
                        },
                        onGalleryTap: () {
                          // Navigator.pop(context);
                          _pickImagesFromGallery();
                        },
                      );
                    },
                  )
                else
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      (path!.contains("mp4"))
                          ? VideoContainer(
                              isCloseShown: true,
                              file: File(path!),
                              closeButton: () {
                                setState(() {
                                  path = null;
                                });
                              },
                            )
                          : ImageContainer(
                              isCloseShown: true,
                              path: path!,
                              onClose: () => setState(() => path = null),
                            ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: InkWell(
                      //     onTap: () {
                      //       //Navigator.pop(context);

                      //       setState(() {
                      //         path = null;
                      //       });
                      //       // _singleWorkOutCubit
                      //       //     .add(SetStateEvent());
                      //     },
                      //     child: Container(
                      //       width: 20,
                      //       height: 20,
                      //       child: SvgPicture.asset(
                      //           'assets/svgs/cross_icon.svg',
                      //           height: 25,
                      //           width: 25),
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Colors.grey.withOpacity(0.1),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                SalukTextField(
                    textEditingController: _descriptionController,
                    maxLines: 6,
                    hintText: "",
                    labelText: AppLocalisation.getTranslated(
                        context, LKTypeInstructions)),
                SizedBox(
                  height: 20,
                ),
                longVideoExerciseDuration == ''
                    ? SalukTransparentButton(
                        title: AppLocalisation.getTranslated(
                            context, LKAddDuration),
                        buttonWidth: defaultSize.screenWidth,
                        borderColor: PRIMARY_COLOR,
                        textColor: PRIMARY_COLOR,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ExerciseDurationDialog(
                                  heading: AppLocalisation.getTranslated(
                                      context, LKExerciseTime),
                                  onChanged: (String value) {
                                    setState(() {
                                      longVideoExerciseDuration = value;
                                    });
                                  },
                                  onChanged2: (String value) {
                                    setState(() {
                                      longVideoExerciseDurationMin = value;
                                    });
                                  },
                                );
                              });
                        },
                        buttonHeight: HEIGHT_4,
                        style: labelTextStyle(context)?.copyWith(
                          fontSize: 14.sp,
                          color: PRIMARY_COLOR,
                        ),
                        icon: Icon(
                          Icons.add_circle,
                          color: PRIMARY_COLOR,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      )
                    : Row(
                        children: [
                          const Icon(
                            Icons.access_time_sharp,
                            color: Colors.grey,
                          ),
                          SB_1W,
                          Text(
                            longVideoExerciseDuration +
                                ' ' +
                                longVideoExerciseDurationMin,
                            style: labelTextStyle(context)?.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          SB_1W,
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ExerciseDurationDialog(
                                      heading: AppLocalisation.getTranslated(
                                          context, LKExerciseTime),
                                      minutes: longVideoExerciseDuration,
                                      onChanged: (String value) {
                                        longVideoExerciseDuration = value;
                                        setState(() {});
                                      },
                                      onChanged2: (String value) {
                                        longVideoExerciseDurationMin = value;
                                        setState(() {});
                                      },
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.edit,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
            title: AppLocalisation.getTranslated(context, LKSubmit),
            callback: () async {
              addLongVideoExercise();
            },
            isButtonDisabled: false),
      ),
    );
  }

  addLongVideoExercise() async {
    solukLog(logMsg: "inside pick image from gallery $path");

    if (_titleController.text.isEmpty &&
        longVideoExerciseDuration.isEmpty &&
        _descriptionController.text.isEmpty) {
      showSnackBar(
        context,
        'Please fill all the fields',
        textColor: Colors.white,
      );
    } else {
      if (path != null || netImage != null) {
        Map<String, String> data = {
          "assetType": path != null
              ? path!.contains('mp4')
                  ? 'video'
                  : 'Image'
              : "",
          "title": _titleController.text,
          "instructions": _descriptionController.text,
        };
        List<String> fields = [];
        List<String> paths = [];
        if (path != null) {
          fields.add('imageVideoURL');
          paths.add(path!);
        }
        print("body data :$data");
        bool? res;
        // var _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
        // _workoutProgramBloc
        //     .add(GetWorkoutExerciseEvent(id: widget.data!.id.toString()));
        if (widget.data != null) {
          showMediaUploadDialog();
          print("id : ${widget.data!.id}");
          solukLog(logMsg: "duration : ${longVideoExerciseDuration}");
          data.addAll({"exerciseTime": "00:" + longVideoExerciseDuration});
          res = await exerciseCubit.updateExercise(data, fields, paths,
              id: widget.data!.id);
        } else {
          if (paths.isNotEmpty) {
            showMediaUploadDialog();
            print("path : ${path}");
            data.addAll({"exerciseTime": "00:" + longVideoExerciseDuration});
            res = await exerciseCubit.addLongVideoExercise(data, fields, paths,
                workOutID: widget.workoutID,
                weekID: widget.weekID,
                dayID: widget.dayID);
          } else {
            showSnackBar(
              context,
              'Please Add image to continue',
              textColor: Colors.white,
            );
          }
        }

        if (res!) {
          SolukToast.showToast("Long video added successfully");
          Navigator.pop(context, res);
          Navigator.pop(context, res);
        } else {
          Navigator.pop(context, res);
          showSnackBar(
            context,
            'Something went wrong please try again',
            textColor: Colors.white,
          );
        }
      } else {
        showSnackBar(
          context,
          'Please add image or video',
          textColor: Colors.white,
        );
      }
    }
  }

  showMediaUploadDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StreamBuilder<ProgressFile>(
            stream: BlocProvider.of<ExerciseCubit>(context).progressStream,
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
  }
}
