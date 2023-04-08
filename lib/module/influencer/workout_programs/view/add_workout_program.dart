import 'dart:io';

import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/module/influencer/widgets/show_snackbar.dart';
import 'package:app/module/influencer/widgets/video_container.dart';
import 'package:app/module/influencer/workout/bloc/tags_bloc/tagsbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/influencer/workout/widgets/add_tags_dialog.dart';
import 'package:app/module/influencer/workout_programs/model/AddWorkoutPlanRequestModel.dart';
import 'package:app/module/influencer/workout_programs/model/add_workout_plan_response.dart';
import 'package:app/module/influencer/workout_programs/model/update_workout_program_response.dart';
import 'package:app/module/influencer/workout_programs/model/workout_prerequisites_response.dart';
import 'package:app/module/influencer/workout_programs/widgets/competition_badge_dropdown.dart';
import 'package:app/module/influencer/workout_programs/widgets/difficulty_level_dropdown.dart';
import 'package:app/module/influencer/workout_programs/widgets/program_type_dropdown.dart';
import 'package:app/module/influencer/workout_programs/workout_program_bloc/workout_program_bloc.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/model_prgress_hud.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../repo/repository/web_service.dart';
import '../../more/widget/custom_alert_dialog.dart';
import '../../more/widget/pop_alert_dialog.dart';
import '../../widgets/media_upload_progress_popup.dart';
import '../../workout/widgets/tag.dart';
import '../model/get_workout_plan_response.dart';

class AddWorkoutProgram extends StatefulWidget {
  static const id = 'AddWorkoutProgramScreen';
  bool? isEditScreen = false;

  final WorkoutPlan? data;

  AddWorkoutProgram({Key? key, this.isEditScreen, this.data}) : super(key: key);

  @override
  State<AddWorkoutProgram> createState() => _AddWorkoutProgramState();
}

class _AddWorkoutProgramState extends State<AddWorkoutProgram> {
  final TextEditingController _titleController = TextEditingController(),
      _descriptionController = TextEditingController();

  late String selectedDifficultyLevelValue = 'Select Difficulty';
  late String selectedTypeValue = '';
  late String selectedCompletionBadgeValueID = '';
  late String selectedCompletionBadgeValue = '';
  late String editMedia = '1';

  WorkoutPrerequisitesListResponse? workoutPrerequisitesListResponse;

  AddWorkoutPlanRequestModel? addWorkoutPlanRequestModel;
  AddWorkoutPlanResponse? addWorkoutPlanResponse;

  UpdateWorkoutProgramResponse? updateWorkoutProgramResponse;

  List<Tags> tags = [];

  selectedTags(List<TagData> list, List<int> selectedIdsList) {
    tags.clear();
    List<TagData> selectedList =
        list.where((element) => selectedIdsList.contains(element.id)).toList();
    for (var item in selectedList) {
      tags.add(Tags(id: item.id, name: item.name));
    }
    print(tags.length);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
    final _tagsBloc = BlocProvider.of<TagsblocCubit>(context);
    _tagsBloc.getTags();

    _workoutProgramBloc.add(WorkoutPrerequisitesLoadedEvent());
    return BlocConsumer<WorkoutProgramBloc, WorkoutProgramState>(
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
      } else if (state is WorkoutPrerequisitesLoadedState) {
        workoutPrerequisitesListResponse =
            state.workoutPrerequisitesListResponse;
        if (widget.isEditScreen == true) {
          tags.clear();
          widget.data!.workoutPlanTags!
              .map((e) => tags.add(Tags(id: e.tags?.id, name: e.tags?.name)));

          _titleController.text = widget.data!.title ?? "";
          _descriptionController.text = widget.data!.description ?? "";
          selectedDifficultyLevelValue = widget.data!.difficultyLevel ?? "";
          print("selected difficult level : $selectedDifficultyLevelValue");
          selectedTypeValue = widget.data!.programType ?? "";
          editMedia = '2';
          netImage = widget.data!.assetUrl;
          for (int i = 0;
              i <
                  workoutPrerequisitesListResponse!
                      .responseDetails.completionBadge.length;
              i++) {
            if (widget.data!.completionBadge ==
                workoutPrerequisitesListResponse!
                    .responseDetails.completionBadge[i].badgeId
                    .toString()) {
              selectedCompletionBadgeValue = workoutPrerequisitesListResponse!
                  .responseDetails.completionBadge[i].title;
              selectedCompletionBadgeValueID = widget.data!.completionBadge ?? "";
              print(selectedCompletionBadgeValue);
              break;
            }
          }
        }

        //workoutPrerequisitesListResponse!.responseDetails.completionBadge.add(value)
      } else if (state is AddWorkoutProgramState) {
        addWorkoutPlanResponse = state.addWorkoutPlanResponse;
        showSnackBar(
          context,
          addWorkoutPlanResponse!.responseDescription,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        print('////////////////////');
        _workoutProgramBloc.add(GetWorkoutProgramsEvent());
        Navigator.pop(context);
        Navigator.pop(context);
      } else if (state is UpdateWorkoutProgramState) {
        updateWorkoutProgramResponse = state.updateWorkoutProgramResponse;
        showSnackBar(
          context,
          updateWorkoutProgramResponse!.responseDescription,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      solukLog(logMsg: state, logDetail: "state in add_workout_program");
      return ModalProgressHUD(
        inAsyncCall: state is LoadingState,
        child: Scaffold(
            body: AppBody(
                title:
                    AppLocalisation.getTranslated(context, LKAddWorkoutProgram),
                body: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MediaTypeSelectionCard(
                        callback: /*() {
                          _pickImagesFromGallery();
                        }*/
                            () {
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
                            : editMedia == '2' && netImage != null
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
                                // : Stack(
                                //     alignment: Alignment.topRight,
                                //     children: [
                                //       Container(
                                //         child: VideoPlayerWidget(
                                //           url: widget.data!.assetUrl,
                                //           mediaTypeisLocalVideo: false,
                                //         ),
                                //         width: defaultSize.screenWidth,
                                //       ),
                                //       Padding(
                                //         padding: const EdgeInsets.all(10.0),
                                //         child: InkWell(
                                //           onTap: () {
                                //             //Navigator.pop(context);

                                //             editMedia = '3';
                                //             _workoutProgramBloc
                                //                 .add(SetStateEvent());
                                //           },
                                //           child: Container(
                                //             width: 30,
                                //             height: 30,
                                //             child: SvgPicture.asset(
                                //                 'assets/svgs/cross_icon.svg',
                                //                 height: 25,
                                //                 width: 25),
                                //             decoration: const BoxDecoration(
                                //               shape: BoxShape.circle,
                                //               color: Colors.grey,
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   )
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
                      Row(
                        children: [
                          DifficultyLevelDropDown(
                            itemsList: [
                              'Select Difficulty',
                              'Easy',
                              'Medium',
                              'Intermediate',
                              'Hard',
                              'Expert'
                            ],
                            defaultValue: selectedDifficultyLevelValue != ''
                                ? selectedDifficultyLevelValue
                                : 'Select Difficulty',
                            dropdownHint: selectedDifficultyLevelValue != ''
                                ? selectedDifficultyLevelValue
                                : 'Select Difficulty',
                            onChanged: (value) {
                              selectedDifficultyLevelValue = value;
                            },
                          ),
                          const Spacer(),
                          ProgramTypeDropDown(
                            itemsList: const [
                              "Select Type",
                              "Free",
                              "Paid",
                              "Promo"
                            ],
                            defaultValue: selectedTypeValue != ''
                                ? selectedTypeValue
                                : 'Select Type',
                            dropdownHint: selectedTypeValue != ''
                                ? selectedTypeValue
                                : 'Select Type',
                            onChanged: (value) {
                              selectedTypeValue = value;
                            },
                          ),
                        ],
                      ),
                      SB_1H,
                      workoutPrerequisitesListResponse != null
                          ? CompetitionBadgeDropDown(
                              itemsList: workoutPrerequisitesListResponse!
                                  .responseDetails.completionBadge,
                              defaultValue: selectedCompletionBadgeValueID != ''
                                  ? selectedCompletionBadgeValue
                                  : 'Select Completion Badge',
                              dropdownHint: selectedCompletionBadgeValueID != ''
                                  ? selectedCompletionBadgeValue
                                  : 'Select Completion Badge',
                              onChanged: (value) {
                                selectedCompletionBadgeValueID =
                                    value.badgeId.toString();
                                print(selectedCompletionBadgeValueID);
                              },
                            )
                          : SizedBox(),
                      SB_1H,
                      Text(
                        "Select Tags",
                        style: subTitleTextStyle(context)!.copyWith(
                          fontSize: defaultSize.screenWidth * .05,
                        ),
                      ),
                      SizedBox(
                        height: WIDTH_1,
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                        style: labelTextStyle(context)!
                            .copyWith(color: const Color(0xFFa4a2aa)),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      (tags.length > 0)
                          ? Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              children: List.generate(
                                tags.length,
                                (index) {
                                  return Tag(
                                      text: tags[index].name ?? '',
                                      callback: () {
                                        addTagsDialog(
                                            context, _tagsBloc.state.tagsModel,
                                            alreadySelectedList: tags,
                                            selectedTags: (val) {
                                          List<int> selectedIdsList = [];
                                          tags.forEach((element) {
                                            selectedIdsList.add(element.id!);
                                          });
                                          print(val);
                                          selectedTags(
                                              _tagsBloc.state.tagsModel
                                                      ?.responseDetails?.data ??
                                                  [],
                                              val);
                                        });
                                      });
                                },
                              ),
                            )
                          : SalukTransparentButton(
                              title: "Add Tag",
                              buttonWidth: defaultSize.screenWidth,
                              textColor: PRIMARY_COLOR,
                              borderColor: PRIMARY_COLOR,
                              onPressed: () {
                                addTagsDialog(
                                    context, _tagsBloc.state.tagsModel,
                                    selectedTags: (val) {
                                  print(val);
                                  // Navigator.pop(context);
                                  setState(() {
                                    selectedTags(
                                        _tagsBloc.state.tagsModel
                                                ?.responseDetails?.data ??
                                            [],
                                        val);
                                  });
                                  // setState(() {
                                  //   _selectedTags = val;
                                  // });
                                });
                              },
                              buttonHeight: HEIGHT_4,
                              style: labelTextStyle(context)?.copyWith(
                                fontSize: 14.sp,
                                color: PRIMARY_COLOR,
                              ),
                              icon: const Icon(
                                Icons.add_circle,
                                color: PRIMARY_COLOR,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                      // SB_Half,

                      SB_1H,
                      SalukTextField(
                        textEditingController: _descriptionController,
                        maxLines: 6,
                        hintText: "",
                        labelText: AppLocalisation.getTranslated(
                            context, LKDescription),
                      ),
                      SB_1H,
                      SalukGradientButton(
                        title: AppLocalisation.getTranslated(context, LKSubmit),
                        onPressed: () async {
                          if (widget.isEditScreen == false) {
                            if (_createPostImageFiles.isNotEmpty) {
                              if (_titleController.text != '') {
                                if (selectedDifficultyLevelValue != '' &&
                                    selectedDifficultyLevelValue !=
                                        'Select Difficulty') {
                                  if (selectedTypeValue != '' &&
                                      selectedTypeValue != 'Select Type') {
                                    if (selectedCompletionBadgeValueID != '') {
                                      if (_descriptionController.text != '') {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return StreamBuilder<ProgressFile>(
                                                stream: _workoutProgramBloc
                                                    .progressStream,
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

                                        addWorkoutPlanRequestModel =
                                            AddWorkoutPlanRequestModel(
                                                media: _createPostImageFiles[0],
                                                assetType:
                                                    _createPostImageFiles[0]
                                                            .path
                                                            .contains('mp4')
                                                        ? 'video'
                                                        : 'image',
                                                workoutTitle:
                                                    _titleController.text,
                                                difficultyLevel:
                                                    selectedDifficultyLevelValue,
                                                programType: selectedTypeValue,
                                                completionBadgeId:
                                                    selectedCompletionBadgeValueID,
                                                description:
                                                    _descriptionController.text,
                                                isEditing: false);

                                        // _workoutProgramBloc.add(
                                        //     AddWorkoutProgramEvent(
                                        //         addWorkoutPlanRequestModel:
                                        //             addWorkoutPlanRequestModel!));

                                        dynamic res = await _workoutProgramBloc
                                            .addWorkoutBlog(
                                                addWorkoutPlanRequestModel!);

                                        if (res) {
                                          _workoutProgramBloc
                                              .add(GetWorkoutProgramsEvent());
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          showSnackBar(
                                            context,
                                            'Please try again, Something went wrong',
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                          );
                                        }

                                        //  _workoutProgramBloc = BlocProvider.of<WorkoutProgramBloc>(context);
                                        // _workoutProgramBloc.add(GetWorkoutProgramsEvent());
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
                                        'Please select completetion badge',
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                      );
                                    }
                                  } else {
                                    showSnackBar(
                                      context,
                                      'Please select workout type',
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                    );
                                  }
                                } else {
                                  showSnackBar(
                                    context,
                                    'Please select difficulty level',
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
                          } else {
                            if (_titleController.text != '') {
                              if (selectedDifficultyLevelValue != '' &&
                                  selectedDifficultyLevelValue !=
                                      'Select Difficulty') {
                                if (selectedTypeValue != '' &&
                                    selectedTypeValue != 'Select Type') {
                                  if (selectedCompletionBadgeValueID != '') {
                                    if (_descriptionController.text != '') {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return StreamBuilder<ProgressFile>(
                                              stream: _workoutProgramBloc
                                                  .progressStream,
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

                                      addWorkoutPlanRequestModel =
                                          AddWorkoutPlanRequestModel(
                                              media: _createPostImageFiles
                                                      .isNotEmpty
                                                  ? _createPostImageFiles[0]
                                                  : null,
                                              assetType: _createPostImageFiles
                                                      .isNotEmpty
                                                  ? _createPostImageFiles[0]
                                                          .path
                                                          .contains('mp4')
                                                      ? 'video'
                                                      : 'image'
                                                  : null,
                                              workoutTitle:
                                                  _titleController.text,
                                              difficultyLevel:
                                                  selectedDifficultyLevelValue,
                                              programType: selectedTypeValue,
                                              completionBadgeId:
                                                  selectedCompletionBadgeValueID,
                                              description:
                                                  _descriptionController.text,
                                              isEditing: true,
                                              workoutProgramID:
                                                  widget.data!.id);

/*
                                      _workoutProgramBloc.add(
                                          AddWorkoutProgramEvent(
                                              addWorkoutPlanRequestModel:
                                                  addWorkoutPlanRequestModel!));
                                      GetWorkoutPlansResponse?
                                          getWorkoutPlansResponse;
                                      if (getWorkoutPlansResponse != null) {
                                        getWorkoutPlansResponse
                                            .responseDetails.totalPublished = 0;
                                        getWorkoutPlansResponse.responseDetails
                                            .totalUnpublished = 0;
                                      }
                                      _workoutProgramBloc
                                          .add(GetWorkoutProgramsEvent());
*/
                                      dynamic res = await _workoutProgramBloc
                                          .addWorkoutBlog(
                                              addWorkoutPlanRequestModel!);

                                      if (res) {
                                        _workoutProgramBloc
                                            .add(GetWorkoutProgramsEvent());
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pop(context);
                                        showSnackBar(
                                          context,
                                          'Please try again, Something went wrong',
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
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
                                      'Please select completetion badge',
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                    );
                                  }
                                } else {
                                  showSnackBar(
                                    context,
                                    'Please select workout type',
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                }
                              } else {
                                showSnackBar(
                                  context,
                                  'Please select difficulty level',
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
                          }
                        },
                        buttonHeight: HEIGHT_4,
                        dim: false,
                      ),
                      SB_1H,
                    ],
                  ),
                ))),
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
