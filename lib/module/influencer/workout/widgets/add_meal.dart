import 'dart:convert';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/workout/bloc/nutrients_bloc/nutrientsbloc_cubit.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({Key? key}) : super(key: key);

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  final _titleController = TextEditingController();
  final _blogController = TextEditingController();
  final QuillController _controller = QuillController.basic();
  String? path;

  _pickImage(String source, {CameraMediaType? type}) async {
    path = await Pickers.instance.pickImage(source: source, mediaType: type);
    if (path != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        title: "Add Meal Plan",
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SB_1H,
              path == null
                  ? MediaTypeSelectionCard(
                      callback: () => popUpAlertDialog(
                        context,
                        'Pick Image',
                        LKImageDialogDetail,
                        isProfile: true,
                        mediaType: CameraMediaType.IMAGE,
                        onCameraTap: (type) {
                          _pickImage(Pickers.instance.sourceCamera, type: type);
                        },
                        onGalleryTap: () {
                          _pickImage(Pickers.instance.sourceGallery);
                        },
                      ),
                    )
                  : ImageContainer(
                      path: path!,
                      onClose: () => setState(() => path = null),
                    ),
              SB_1H,
              SalukTextField(
                textEditingController: _titleController,
                hintText: '',
                labelText: 'Add Title',
                onChange: (_) {
                  setState(() {});
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
                child: QuillEditor.basic(
                  controller: _controller,
                  readOnly: false, // true for view only mode
                ),
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
// showListBullets: false,
                  showIndent: false,
                  showClearFormat: false,
// showBackgroundColorButton: false,
                  showListNumbers: false,
                  showStrikeThrough: false,
                  showCameraButton: false,
                  showImageButton: false,

                  onImagePickCallback: (file) async {
                    print(file.path);
                  },
                ),
              ),
              SB_1H,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
            title: "Submit",
            callback: () {
              print(_controller.document.toDelta().toJson());
              addMeal();
            },
            isButtonDisabled: false
            // _titleController.text.isEmpty || _blogController.text.isEmpty,
            ),
      ),
    );
  }

  addMeal() async {
    String blogText = json.encode(_controller.document.toDelta().toJson());
    Map<String, String> body = {
      'title': _titleController.text,
      'blogText': blogText,
      'isNutritionBlog': '1',
      'nutritionId': '2'
    };
    List<String> fields = [];
    List<String> paths = [];
    if (path != null) {
      fields.add('imageURL');
      paths.add(path!);
    }
    print(body);
    bool res = await BlocProvider.of<NutrientsblocCubit>(context, listen: false)
        .addNutrientsBlog(body, fields, paths);
    if (res) {
      // BlocProvider.of<BlogblocCubit>(context, listen: false).getBlogs();
      Navigator.pop(context);
    }
  }
}
