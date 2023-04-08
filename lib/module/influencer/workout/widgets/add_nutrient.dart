import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/workout/bloc/nutrients_bloc/nutrientsbloc_cubit.dart';
import 'package:app/module/influencer/workout/model/nutrients_modal.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/repository/web_service.dart';
import '../../more/widget/custom_alert_dialog.dart';
import '../../widgets/media_upload_progress_popup.dart';

class AddNutrients extends StatefulWidget {
  final Data? nutrientsData;

  const AddNutrients({Key? key, this.nutrientsData}) : super(key: key);

  @override
  State<AddNutrients> createState() => _AddNutrientsState();
}

class _AddNutrientsState extends State<AddNutrients> {
  final _titleController = TextEditingController();
  String? image;
  String? path;

  _pickImage(String source, {CameraMediaType? mediaType}) async {
    path =
        await Pickers.instance.pickImage(source: source, mediaType: mediaType);
    if (path != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    if (widget.nutrientsData != null) {
      _titleController.text = widget.nutrientsData?.title ?? '';
      image = widget.nutrientsData?.imageUrl ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _nutrientBloc = BlocProvider.of<NutrientBloc>(context);
    return Scaffold(
      body: AppBody(
        title: "Add Nutrients Plan",
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image != null
                  ? ImageContainer(
                      path: image!,
                      onClose: () => setState(() => image = null),
                    )
                  : path == null
                      ? MediaTypeSelectionCard(
                          textTag: LKUploadImagePreview,
                          callback: () => popUpAlertDialog(
                            context,
                            'Pick Image',
                            LKImageDialogDetail,
                            isProfile: true,
                            mediaType: CameraMediaType.IMAGE,
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
                          onClose: () => setState(() => path = null),
                        ),
              // const DottedContainer(),
              SB_1H,
              SalukTextField(
                textEditingController: _titleController,
                hintText: '',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
                ],
                labelText: 'Add Title',
                onChange: (_) {
                  setState(() {});
                },
              ),
              SB_1H,
              // GridView.count(
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     crossAxisSpacing: 10,
              //     mainAxisSpacing: 10,
              //     crossAxisCount: 2,
              //     children: [
              //       ...List.generate(
              //           2,
              //           (index) => Container(
              //                 height: HEIGHT_5 * 2,
              //                 width: HEIGHT_5 * 2,
              //                 padding: const EdgeInsets.all(10),
              //                 decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.circular(WIDTH_3),
              //                   image: const DecorationImage(
              //                       image: NetworkImage(
              //                           'https://domf5oio6qrcr.cloudfront.net/medialibrary/10450/GettyImages-1278940460.jpg'),
              //                       fit: BoxFit.fill),
              //                 ),
              //                 child: Column(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.end,
              //                         children: [
              //                           Container(
              //                               decoration: BoxDecoration(
              //                                   shape: BoxShape.circle,
              //                                   color: Colors.white
              //                                       .withOpacity(0.5)),
              //                               child: const Icon(
              //                                 Icons.close,
              //                                 color:
              //                                     TOGGLE_BACKGROUND_COLOR,
              //                               )),
              //                         ],
              //                       ),
              //                       Container(
              //                         alignment: Alignment.bottomLeft,
              //                         child: Text(
              //                           "Break Fast",
              //                           textAlign: TextAlign.center,
              //                           style: labelTextStyle(context)
              //                               ?.copyWith(
              //                                   color: Colors.white,
              //                                   fontWeight:
              //                                       FontWeight.w500),
              //                         ),
              //                       )
              //                     ]),
              //               )),
              //       ...[
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const AddMeal()));
              //   },
              //   child: SizedBox(
              //     height: HEIGHT_5 * 2,
              //     width: HEIGHT_5 * 2,
              //     child: DottedContainer(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(
              //             Icons.add_circle,
              //             size: WIDTH_4,
              //             color: PRIMARY_COLOR,
              //           ),
              //           Text(
              //             "Add Meal",
              //             textAlign: TextAlign.center,
              //             style: labelTextStyle(context)?.copyWith(
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
              //       ]
              //     ]),
              SB_2H,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SalukBottomButton(
          title: "Submit",
          callback: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StreamBuilder<ProgressFile>(
                    stream: BlocProvider.of<NutrientsblocCubit>(context)
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

            if (widget.nutrientsData == null) {
              addNutrientsBlog();
            } else {
              updateNutrients();
            }
          },
          isButtonDisabled: _titleController.text.isEmpty,
        ),
      ),
    );
  }

  addNutrientsBlog() async {
    // var _controller;
    // String blogText = json.encode(_controller.document.toDelta().toJson());
    Map<String, String> body = {
      'title': _titleController.text,
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
      Navigator.pop(context);
    }
  }

  updateNutrients() async {
    // var _controller;
    // String blogText = json.encode(_controller.document.toDelta().toJson());
    Map<String, String> body = {
      'title': _titleController.text,
      'nutritionId': '${widget.nutrientsData!.id}'
    };
    List<String> fields = [];
    List<String> paths = [];
    if (path != null) {
      fields.add('imageURL');
      paths.add(path!);
    }
    print(body);
    bool res = await BlocProvider.of<NutrientsblocCubit>(context, listen: false)
        .updateNutrients(body, fields, paths);
    if (res) {
      // BlocProvider.of<BlogblocCubit>(context, listen: false).getBlogs();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
