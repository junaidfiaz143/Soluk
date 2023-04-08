import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_week_request_model.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_week_response.dart';
import 'package:app/module/influencer/workout_programs/view/bloc/week_bloc/week_bloc_bloc.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../more/widget/custom_alert_dialog.dart';
import '../../more/widget/pop_alert_dialog.dart';
import '../../widgets/image_container.dart';
import '../../widgets/media_upload_progress_popup.dart';
import '../../widgets/video_container.dart';
import '../model/get_workout_all_weeks_response.dart';

class AddWorkoutWeek extends StatefulWidget {
  static const id = 'AddWorkoutWeek';
  bool? isEditScreen = false;
  final int iD;

  final Data? data;

  AddWorkoutWeek({Key? key, this.isEditScreen, required this.iD, this.data})
      : super(key: key);

  @override
  State<AddWorkoutWeek> createState() => _AddWorkoutWeekState();
}

class _AddWorkoutWeekState extends State<AddWorkoutWeek> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();

  AddWorkoutWeekResponse? addWorkoutWeekResponse;
  AddWorkoutWeekRequestModel? addWorkoutWeekRequestModel;
  late String editMedia = '1';

  @override
  void initState() {
    super.initState();
    if (widget.isEditScreen == true) {
      _titleController.text = widget.data!.title;
      _descriptionController.text = widget.data!.description;
      editMedia = '2';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _workoutProgramBloc = BlocProvider.of<WeekBlocBloc>(context);
    // _workoutProgramBloc.add(WorkoutPrerequisitesLoadingEvent());
    return BlocConsumer<WeekBlocBloc, WeekBlocState>(
        listener: (context, state) {
      if (state is LoadingState) {
      } else if (state is SetStateState) {
        editMedia = "3";
      } else if (state is ErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else if (state is InternetErrorState) {
        showSnackBar(
          context,
          state.error,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      } else if (state is AddWorkoutWeekState) {
        addWorkoutWeekResponse = state.addWorkoutWeekResponse;
        showSnackBar(
          context,
          'Workout week added successfully!',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        _workoutProgramBloc.add(GetWorkoutWeeksEvent(id: widget.iD.toString()));
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: AppBody(
            title: AppLocalisation.getTranslated(context, LKAddWorkoutWeek),
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaTypeSelectionCard(
                      callback: () {
                        if (_createPostImageFiles.isEmpty && netImage == null) {
                          popUpAlertDialog(
                            context,
                            'Pick Image',
                            LKImageDialogDetail,
                            isProfile: true,
                            onCameraTap: (type) {
                              _pickImage(Pickers.instance.sourceCamera,
                                  mediaType: type);
                            },
                            onGalleryTap: () {
                              // _pickImage(ImageSource.gallery);
                              _pickImagesFromGallery();
                            },
                          );
                        }
                      },
                      child: _createPostImageFiles.isNotEmpty
                          ? _createPostImageFiles[0].path.contains('mp4')
                              ? VideoContainer(
                                  file: _createPostImageFiles[0],
                                  closeButton: () {
                                    _createPostImageFiles.clear();
                                    _workoutProgramBloc.add(SetStateEvent());
                                  },
                                  isCloseShown: true,
                                )
                              : ImageContainer(
                                  path: _createPostImageFiles[0].path,
                                  onClose: () {
                                    _createPostImageFiles.clear();
                                    _workoutProgramBloc.add(SetStateEvent());
                                  },
                                  isCloseShown: true,
                                )
                          : editMedia == '2'
                              ? widget.data!.assetType == 'Image'
                                  ? ImageContainer(
                                      path: netImage!,
                                      onClose: () {
                                        netImage = null;
                                        editMedia = '3';
                                        _workoutProgramBloc
                                            .add(SetStateEvent());
                                      },
                                      isCloseShown: true,
                                    )
                                  : VideoContainer(
                                      netUrl: netImage!,
                                      isCloseShown: true,
                                      closeButton: () {
                                        netImage = null;
                                        editMedia = '3';
                                        _workoutProgramBloc
                                            .add(SetStateEvent());
                                      },
                                    )
                              : null,
                    ),
                    SB_1H,
                    SalukTextField(
                        textEditingController: _titleController,
                        hintText: "",
                        labelText: "Workout Week Title"),
                    SB_1H,
                    SalukTextField(
                        textEditingController: _descriptionController,
                        maxLines: 6,
                        hintText: "",
                        labelText: "Description"),
                    SizedBox(
                      height: defaultSize.screenHeight * 0.2,
                    ),
                    SalukGradientButton(
                      title: AppLocalisation.getTranslated(context, LKSubmit),
                      onPressed: () async {
                        if (_createPostImageFiles.isNotEmpty) {
                          if (_titleController.text != '') {
                            if (_descriptionController.text != '') {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StreamBuilder<ProgressFile>(
                                      stream:
                                          _workoutProgramBloc.progressStream,
                                      builder: (context, snapshot) {
                                        return CustomAlertDialog(
                                          isSmallSize: true,
                                          contentWidget:
                                              MediaUploadProgressPopup(
                                            snapshot: snapshot,
                                          ),
                                        );
                                      });
                                },
                              );

                              addWorkoutWeekRequestModel =
                                  AddWorkoutWeekRequestModel(
                                      media: _createPostImageFiles[0],
                                      assetType: _createPostImageFiles[0]
                                              .path
                                              .contains('mp4')
                                          ? 'video'
                                          : 'image',
                                      workoutTitle: _titleController.text,
                                      description: _descriptionController.text,
                                      workoutID: widget.iD);

                              // _workoutProgramBloc.add(AddWorkoutWeekEvent(
                              //     addWorkoutWeekRequestModel:
                              //         addWorkoutWeekRequestModel!));

                              var res = await _workoutProgramBloc
                                  .addWeek(addWorkoutWeekRequestModel!);

                              _workoutProgramBloc.add(GetWorkoutWeeksEvent(
                                  id: widget.iD.toString()));
                            } else {
                              showSnackBar(
                                context,
                                'Please enter workout plan description',
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            }
                          } else {
                            showSnackBar(
                              context,
                              'Please enter a title of Program',
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                            );
                          }
                        } else {
                          showSnackBar(
                            context,
                            'Please select a media file (Photo or Video)',
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                        }
                      },
                      buttonHeight: HEIGHT_4,
                      dim: false,
                    ),
                    SB_1H,
                  ],
                ),
              ),
            )),
      );
    });
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
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   allowMultiple: false,
    //   type: FileType.media,
    //   allowCompression: true,
    // );
    // if (result != null) {
    //   log(result.toString());
    //   setState(() {
    //     if (result.paths.first != null) {
    //       path = result.paths.first;
    //       _createPostImageFiles.add(File(path!));
    //     }
    //   });
    // } else {}
  }

  String? path;
  String? netImage;

  _pickImage(String source, {CameraMediaType? mediaType}) async {
    path =
        await Pickers.instance.pickImage(source: source, mediaType: mediaType);
    if (path != null) {
      setState(() {
        _createPostImageFiles.add(File(path!));
      });
    }
  }
}
