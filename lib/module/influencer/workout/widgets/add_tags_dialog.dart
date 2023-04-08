import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/workout/model/tags.dart';
import 'package:app/module/influencer/workout/widgets/multi_select_chips.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../model/get_influencer.dart';

Future<dynamic> addTagsDialog(BuildContext context, TagsModel? tagsModel,
    {required Function(List<int>) selectedTags,
    List<Tags>? alreadySelectedList}) {
  List<int> _selectedTags = [];
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.5.h),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                                radius: 12,
                                backgroundColor: const Color(0xFFe7e7e7),
                                child: Image(
                                  height: 2.h,
                                  image: const AssetImage(CLOSE),
                                )),
                          ),
                        ),
                        Text(
                          'Add Tags',
                          style: headingTextStyle(context)!.copyWith(
                            fontSize: defaultSize.screenWidth * .055,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Tags',
                              style: subTitleTextStyle(context)!.copyWith(
                                fontSize: defaultSize.screenWidth * .04,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                              style: labelTextStyle(context)!.copyWith(
                                  fontSize: defaultSize.screenWidth * .038,
                                  color: const Color(0xFFa4a2aa)),
                            ),
                            SizedBox(height: 1.h),
                            MultiSelectChip(
                              tagsModel: tagsModel!,
                              selectedTags: (val) {
                                _selectedTags = val;
                              },
                              alreadySelectedItem:
                                  (alreadySelectedList != null &&
                                          alreadySelectedList.isNotEmpty)
                                      ? alreadySelectedList
                                      : [],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: SalukGradientButton(
                          title: 'Save',
                          onPressed: () {
                            // final _prefs = await SharedPreferences.getInstance();
                            // _prefs.setStringList('tags', _selectedTags);
                            selectedTags(_selectedTags);
                            Navigator.pop(context);
                          },
                          buttonHeight: 50),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
