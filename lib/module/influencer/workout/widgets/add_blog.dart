import 'dart:convert';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/media_upload_progress_popup.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/workout/bloc/blog_bloc/blogbloc_cubit.dart';
import 'package:app/module/influencer/workout/bloc/meal_bloc/mealbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/blog_modal.dart';
import 'package:app/module/influencer/workout/model/meals_modal.dart'
    as mealMod;
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../more/widget/custom_alert_dialog.dart';
import '../../widgets/show_snackbar.dart';

class AddBlog extends StatefulWidget {
  final Data? blog;
  final mealMod.Data? mealBlog;
  final bool isMealBlog;
  final String? nutrientId;

  const AddBlog(
      {Key? key,
      this.blog,
      this.isMealBlog = false,
      this.mealBlog,
      this.nutrientId})
      : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _titleController = TextEditingController();
  final _blogController = TextEditingController();
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  String? path;
  String? netImage;

  _pickImage(String source, {CameraMediaType? mediaType}) async {
    path =
        await Pickers.instance.pickImage(source: source, mediaType: mediaType);
    if (path != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    print('initttttttttttttttttttt');
    if (widget.blog != null) {
      netImage = widget.blog!.imageUrl!;
      _titleController.text = widget.blog!.title!;
      var myJSON = jsonDecode(widget.blog!.blogText!);
      _controller = QuillController(
        document: Document.fromJson(myJSON),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    if (widget.mealBlog != null) {
      print('mealllllllll not nullllllllllllll');
      netImage = widget.mealBlog!.imageUrl!;
      _titleController.text = widget.mealBlog!.title!;
      var myJSON = jsonDecode(widget.mealBlog!.blogText!);
      _controller = QuillController(
        document: Document.fromJson(myJSON),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _blogBloc = BlocProvider.of<BlogBloc>(context);
    return Scaffold(
      body: AppBody(
        title: (widget.isMealBlog)
            ? AppLocalisation.getTranslated(context, 'LKAddMealPlan')
            : AppLocalisation.getTranslated(context, 'LKAddBlog'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SB_1H,
              netImage != null
                  ? ImageContainer(
                      path: netImage!,
                      onClose: () => setState(() {
                        path = null;
                        netImage = null;
                      }),
                    )
                  : path == null
                      ? MediaTypeSelectionCard(
                          textTag: LKUploadImagePreview,
                          callback: () => popUpAlertDialog(
                            context,
                            'Pick Image',
                            LKImageDialogDetail,
                            mediaType: CameraMediaType.IMAGE,
                            isProfile: true,
                            onCameraTap: (type) {
                              _pickImage(Pickers.instance.sourceCamera,
                                  mediaType: type);
                            },
                            onGalleryTap: () {
                              _pickImage(Pickers.instance.sourceGallery);
                            },
                          ),
                        )
                      : ImageContainer(
                          path: path!,
                          onClose: () => setState(() {
                            path = null;
                            netImage = null;
                          }),
                        ),
              SB_1H,
              SalukTextField(
                textEditingController: _titleController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
                ],
                hintText: '',
                labelText: (widget.isMealBlog)
                    ? "Meal Title"
                    : AppLocalisation.getTranslated(context, 'LKBlogTitle'),
                onChange: (_) {
                  // setState(() {});
                },
              ),
              SB_1H,
              Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: PRIMARY_COLOR, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: QuillEditor(
                    controller: _controller,
                    readOnly: false,
                    placeholder: "Description...",
                    showCursor: true,
                    autoFocus: false,
                    focusNode: _focusNode,
                    scrollable: true,
                    expands: false,
                    scrollController: ScrollController(),
                    padding: EdgeInsets.zero,
                  )
                  // QuillEditor.basic(
                  //   controller: _controller,
                  //   readOnly: false,
                  // ),
                  ),
              SB_1H,
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2)),
                child: QuillToolbar.basic(
                  controller: _controller,
                  showVideoButton: false,
                  showHeaderStyle: false,
                  showCodeBlock: false,
                  showListCheck: false,
                  showInlineCode: false,
                  showUndo: false,
                  showRedo: false,

                  showJustifyAlignment: false,
                  showAlignmentButtons: false,
                  showDirection: false,
                  showCenterAlignment: false,
                  showDividers: false,
                  showLeftAlignment: false,
                  showRightAlignment: false,
                  showIndent: false,
                  showClearFormat: false,
                  showListNumbers: false,
                  showStrikeThrough: false,
                  showCameraButton: false,
                  showImageButton: false,
                  // mediaPickSettingSelector: (context)async{
                  //   return MediaPickSetting.;
                  // },
                  dialogTheme: QuillDialogTheme(
                    dialogBackgroundColor: Colors.white,
                  ),
                  // filePickImpl: (context) async {
                  //   return Future.value('hello');
                  // },
                  // onVideoPickCallback: (f)async{
                  //   print(f.path);
                  // },

                  onImagePickCallback: (file) async {
                    print(file.path);
                    return file.path;
                    // return 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg';
                  },
                ),
              ),
              SB_1H,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: StreamBuilder<ProgressFile>(
            stream: widget.isMealBlog
                ? BlocProvider.of<MealblocCubit>(context).progressStream
                : BlocProvider.of<BlogblocCubit>(context).progressStream,
            builder: (context, snapshot) {
              return SalukBottomButton(
                  title: /* (snapshot.data?.done ?? 0) != 0
                      ? '${(((snapshot.data?.done ?? 1) / (snapshot.data?.total ?? 1)) * 100).toInt()} % '
                      :*/
                      AppLocalisation.getTranslated(context, 'LKSubmit'),
                  callback: () {
                    if (!validateInput()) {
                      return;
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return StreamBuilder<ProgressFile>(
                            stream: widget.isMealBlog
                                ? BlocProvider.of<MealblocCubit>(context)
                                    .progressStream
                                : BlocProvider.of<BlogblocCubit>(context)
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

                    print(_controller.document.toDelta().toJson());
                    if (widget.isMealBlog) {
                      if (widget.mealBlog == null) {
                        addBlog();
                      } else {
                        updateBlog();
                      }
                    } else {
                      if (widget.blog == null) {
                        addBlog();
                      } else {
                        updateBlog();
                      }
                    }
                  },
                  isButtonDisabled: false
                  // _titleController.text.isEmpty || _blogController.text.isEmpty,
                  );
            }),
      ),
    );
  }

  updateBlog() async {
    String blogText = json.encode(_controller.document.toDelta().toJson());
    Map<String, String> body = {
      'title': _titleController.text,
      'blogText': blogText,
      // 'isNutritionBlog': '0',
    };
    if (widget.isMealBlog) {
      body.addAll({
        'nutritionId': '${widget.mealBlog!.nutritionId!}',
        'isNutritionBlog': '1',
        'blog_id': '${widget.mealBlog!.id}'
      });
    } else {
      body.addAll({'isNutritionBlog': '0', 'blog_id': '${widget.blog!.id}'});
    }
    print(body);
    print(widget.isMealBlog);
    // return ;
    List<String> fields = [];
    List<String> paths = [];
    if (path != null) {
      fields.add('imageURL');
      paths.add(path!);
    }
    print(body);
    bool res;
    if (widget.isMealBlog) {
      res = await BlocProvider.of<MealblocCubit>(context, listen: false)
          .updateMealBlog(body, fields, paths);
    } else {
      res = await BlocProvider.of<BlogblocCubit>(context, listen: false)
          .updateBlog(body, fields, paths);
    }

    if (res) {
      // BlocProvider.of<BlogblocCubit>(context, listen: false).getBlogs();
      if (widget.isMealBlog) {
        widget.mealBlog?.title = _titleController.text;
        widget.mealBlog?.blogText = blogText;
      } else {
        widget.blog?.title = _titleController.text;
        widget.blog?.blogText = blogText;
      }

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  addBlog() async {
    String blogText = json.encode(_controller.document.toDelta().toJson());
    Map<String, String> body = {
      'title': _titleController.text,
      'blogText': blogText,
      // 'isNutritionBlog': '0',
    };
    if (widget.isMealBlog) {
      body.addAll({
        'nutritionId': '${widget.nutrientId}',
        'isNutritionBlog': '1',
      });
    } else {
      body.addAll({'isNutritionBlog': '0'});
    }
    List<String> fields = [];
    List<String> paths = [];
    if (path != null) {
      fields.add('imageURL');
      paths.add(path!);
    }
    print(body);
    bool res;
    if (widget.isMealBlog) {
      res = await BlocProvider.of<MealblocCubit>(context, listen: false)
          .addMealBlog(body, fields, paths);
    } else {
      res = await BlocProvider.of<BlogblocCubit>(context, listen: false)
          .addBlog(body, fields, paths);
    }

    if (res) {
      // BlocProvider.of<BlogblocCubit>(context, listen: false).getBlogs();
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  bool validateInput() {
    if ((path == null || path!.isEmpty) &&
        (netImage == null || netImage!.isEmpty)) {
      showSnackBar(
        context,
        "Please add Preview Image",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (_titleController.text.isEmpty) {
      showSnackBar(
        context,
        "Please add Title",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (_controller.document.toPlainText().replaceAll("\n", "").isEmpty) {
      showSnackBar(
        context,
        "Please write Description",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }
}
