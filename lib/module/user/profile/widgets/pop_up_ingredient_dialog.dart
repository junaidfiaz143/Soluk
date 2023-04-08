import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/workout/widgets/components/measurement_standard.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> popUpIngredientDialog(BuildContext context, String title,
    {Function(String name, String quantity, String stand)? onSave, Map? item}) {
  TextEditingController _ingreNameCont = TextEditingController();
  TextEditingController _quantityCont = TextEditingController();
  String? stand;
  if (item != null) {
    _ingreNameCont.text = item['name'] ?? '';
    _quantityCont.text = '${item['quantity'] ?? ''}';
    stand = '${item['type']}';
  }
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.43,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.5.h),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 7.w, right: 7.w, bottom: 1.2.h, top: 3.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                                radius: 13,
                                backgroundColor: const Color(0xFFe7e7e7),
                                child: Image(
                                  height: 2.h,
                                  image: const AssetImage(CLOSE),
                                )),
                          ),
                        ),
                        Text(
                          title,
                          style: headingTextStyle(context)!.copyWith(
                            fontSize: defaultSize.screenWidth * .05,
                          ),
                        ),
                        SB_1H,
                        SalukTextField(
                          textEditingController: _ingreNameCont,
                          hintText: '',
                          labelText: AppLocalisation.getTranslated(
                              context, 'LKIngredientName'),
                          onChange: (_) {
                            // setState(() {});
                          },
                        ),
                        SB_1H,
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SalukTextField(
                                textEditingController: _quantityCont,
                                hintText: '',
                                textInputType: TextInputType.number,
                                labelText: AppLocalisation.getTranslated(
                                    context, 'LKQuantity'),
                                onChange: (_) {
                                  // setState(() {});
                                },
                              ),
                            ),
                            SB_1W,
                            Expanded(
                                flex: 2,
                                child: MeasurementStandard(
                                  onChange: (va) {
                                    stand = va;
                                  },
                                  selected: stand,
                                ))
                          ],
                        ),
                        SB_2H,
                        SalukGradientButton(
                          title: 'Save',
                          dim: false,
                          onPressed: () {
                            print(_ingreNameCont.text.isNotEmpty &&
                                _quantityCont.text.isNotEmpty);
                            if (_ingreNameCont.text.isNotEmpty &&
                                _quantityCont.text.isNotEmpty &&
                                stand != null) {
                              Navigator.pop(context);
                              onSave!(_ingreNameCont.text, _quantityCont.text,
                                  stand!);
                            }
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
}
