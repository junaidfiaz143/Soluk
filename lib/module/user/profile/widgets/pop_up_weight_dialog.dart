import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/widgets/saluk_transparent_button.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> popUpWeightDialog(BuildContext context, String title,
    {Function(String weightInKg, String imagePath)? onSave, Map? item}) {
  TextEditingController _weight = TextEditingController();
  // TextEditingController _quantityCont = TextEditingController();
  String? path;
  String? stand;
  if (item != null) {
    // _ingreNameCont.text = item['name'] ?? '';
    // _quantityCont.text = '${item['quantity'] ?? ''}';
    // stand = '${item['type']}';
  }
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.5.h),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 7.w, right: 7.w, bottom: 1.2.h, top: 1.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: const Color(0xFFe7e7e7),
                                  child: Image(
                                    height: 2.h,
                                    image: const AssetImage(CLOSE),
                                  )),
                            ),
                          ),
                          Center(
                            child: Text(
                              title,
                              style: headingTextStyle(context)!.copyWith(
                                  fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SB_1H,
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: SalukTextField(
                                    textEditingController: _weight,
                                    hintText: '',
                                    labelText: "Current Weight",
                                    onChange: (_) {
                                      // setState(() {});
                                    },
                                  )),
                              SB_1W,
                              Text(
                                "in KG",
                                style: subTitleTextStyle(context)!.copyWith(
                                  color: Colors.grey,
                                  fontSize: defaultSize.screenWidth * .03,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Row(
                            children: [
                              Text(
                                'Add Image',
                                style: headingTextStyle(context)!.copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 2.sp,
                              ),
                              Text(
                                "(Optional)",
                                style: subTitleTextStyle(context)!.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          (path == null)
                              ? SalukTransparentButton(
                                  title: "",
                                  buttonWidth: defaultSize.screenWidth * 0.23,
                                  textColor: PRIMARY_COLOR,
                                  borderColor: PRIMARY_COLOR,
                                  onPressed: () {
                                    popUpAlertDialog(
                                      context,
                                      AppLocalisation.getTranslated(
                                          context, 'LKUploadImage'),
                                      LKImageDialogDetail,
                                      onCameraTap: (type) async {
                                        path = await Pickers.instance.pickImage(
                                            source:
                                                Pickers.instance.sourceCamera,
                                            mediaType: type);
                                        setState(() {});

                                        // _selectIntroVideo(source: ImageSource.camera);
                                      },
                                      onGalleryTap: () async {
                                        path = await Pickers.instance
                                            .pickImage(
                                                source: Pickers
                                                    .instance.sourceGallery);
                                        setState(() {});
                                        // _selectIntroVideo(source: ImageSource.gallery);
                                      },
                                    );
                                  },
                                  buttonHeight: defaultSize.screenWidth * 0.23,
                                  style: labelTextStyle(context)?.copyWith(
                                    fontSize: 14.sp,
                                    color: PRIMARY_COLOR,
                                  ),
                                  icon: const Icon(
                                    Icons.add_circle,
                                    size: 20,
                                    color: PRIMARY_COLOR,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                )
                              : Container(
                                  width: defaultSize.screenWidth * 0.2,
                                  height: defaultSize.screenWidth * 0.2,
                                  child: ImageContainer(
                                    path: path!,
                                    onClose: () => setState(() => path = null),
                                  ),
                                ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          SalukGradientButton(
                            title: 'DONE',
                            onPressed: () {
                              Navigator.pop(context);
                              onSave!(_weight.text, path??"",);
                            },
                            buttonHeight: HEIGHT_3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
}
