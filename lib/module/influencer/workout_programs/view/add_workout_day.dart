import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
// import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';

import 'package:app/module/influencer/workout_programs/model/add_workout_day%20_response.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_week_request_model.dart';
import 'package:app/module/influencer/workout_programs/view/bloc/day_bloc/daybloc_bloc.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/repository/web_service.dart';
import '../../more/widget/custom_alert_dialog.dart';
import '../../more/widget/pop_alert_dialog.dart';
import '../../widgets/image_container.dart';
import '../../widgets/media_upload_progress_popup.dart';
import '../../widgets/video_container.dart';
import '../model/get_week_all_days_workouts_response.dart';

class AddWorkoutDay extends StatefulWidget {
  static const id = 'AddWorkoutDay';
  bool? isEditScreen = false;
  final Data? data;

  final String workoutId;
  final String weekId;

  AddWorkoutDay(
      {Key? key,
      this.isEditScreen,
      this.data,
      required this.workoutId,
      required this.weekId})
      : super(key: key);

  @override
  State<AddWorkoutDay> createState() => _AddWorkoutDayState();
}

class _AddWorkoutDayState extends State<AddWorkoutDay> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();

  AddWorkoutDayResponse? addWorkoutDayResponse;
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
    final _workoutProgramBloc = BlocProvider.of<DayblocBloc>(context);
    return BlocConsumer<DayblocBloc, DayblocState>(listener: (context, state) {
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
      } else if (state is AddWorkoutDayState) {
        addWorkoutDayResponse = state.addWorkoutDayResponse;
        showSnackBar(
          context,
          'Workout day ${widget.isEditScreen == true ? 'updated' : 'added'} successfully!',
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        _workoutProgramBloc.add(GetWorkoutDaysEvent(
            id: widget.weekId, workoutId: widget.workoutId));
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: AppBody(
            title: widget.isEditScreen == true
                ? 'Update Workout Day'
                : AppLocalisation.getTranslated(context, LKAddWorkoutDay),
            body: ModalProgressHUD(
              inAsyncCall: state is LoadingState,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isEditScreen != true)
                      MediaTypeSelectionCard(
                        callback: () {
                          if (_createPostImageFiles.isEmpty &&
                              netImage == null) {
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
                                        netUrl: netImage,
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
                      labelText: AppLocalisation.getTranslated(
                          context, LKWorkoutTitle),
                    ),
                    SB_1H,
                    SalukTextField(
                        textEditingController: _descriptionController,
                        maxLines: 6,
                        hintText: "",
                        labelText: AppLocalisation.getTranslated(
                            context, LKDescription)),
                    SizedBox(
                      height: defaultSize.screenHeight * 0.2,
                    ),
                    SalukGradientButton(
                      title: AppLocalisation.getTranslated(context, LKSubmit),
                      onPressed: () async {
                        if (widget.isEditScreen == true) {
                          if (_titleController.text != '') {
                            if (_descriptionController.text != '') {
                              addWorkoutWeekRequestModel =
                                  AddWorkoutWeekRequestModel(
                                      workoutTitle: _titleController.text,
                                      description: _descriptionController.text,
                                      workoutID: int.parse(widget.workoutId),
                                      weekID: int.parse(widget.weekId));

                              // _workoutProgramBloc.add(UpdateWorkoutDayEvent(
                              //     addWorkoutWeekRequestModel:
                              //         addWorkoutWeekRequestModel!));

                              var res = await _workoutProgramBloc.updateDay(
                                addWorkoutWeekRequestModel!,
                                widget.data?.id ?? 0,
                              );

                              if (widget.data != null) {
                                _workoutProgramBloc.add(GetWorkoutDaysEvent(
                                    id: widget.weekId,
                                    workoutId: widget.workoutId));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
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
                                        description:
                                            _descriptionController.text,
                                        workoutID: int.parse(widget.workoutId),
                                        weekID: int.parse(widget.weekId));
/*

                              _workoutProgramBloc.add(AddWorkoutDayEvent(
                                  addWorkoutWeekRequestModel:
                                      addWorkoutWeekRequestModel!));

*/
                                var res = await _workoutProgramBloc
                                    .addDay(addWorkoutWeekRequestModel!);

                                if (widget.data != null) {
                                  _workoutProgramBloc.add(GetWorkoutDaysEvent(
                                      id: widget.data!.id.toString(),
                                      workoutId: widget.workoutId));
                                }
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
