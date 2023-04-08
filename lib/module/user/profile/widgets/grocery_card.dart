import 'package:app/module/user/profile/local_storage/grocery_local.dart';
import 'package:app/module/user/profile/widgets/pop_up_ingredient_dialog.dart';
import 'package:app/module/user/widgets/dialog_utils.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GroceryCard extends StatelessWidget {
  final Map item;
  final int index;

  GroceryCard({Key? key, required this.item, required this.index})
      : super(key: key);
  final GroceryLocal ins = GroceryLocal.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.only(left: 20, right: 10),
          width: double.maxFinite,
          height: HEIGHT_5 * 1.1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            color: Colors.white,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                item['name'],
                style: subTitleTextStyle(context)?.copyWith(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Quantity :",
                    style: subTitleTextStyle(context)?.copyWith(
                        color: greyTextColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, right: 8),
                    child: Text(
                      item['quantity'],
                      style: subTitleTextStyle(context)?.copyWith(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Text(
                    "Unit :",
                    style: subTitleTextStyle(context)?.copyWith(
                        color: greyTextColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, right: 8),
                    child: Text(
                      item['type'],
                      style: subTitleTextStyle(context)?.copyWith(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () => popUpIngredientDialog(
                              context, 'Ingredients', item: item,
                              onSave: ((name, quantity, stand) {
                            ins.updateItem(index, {
                              'name': name,
                              'quantity': quantity,
                              'type': stand
                            });
                          })),
                      icon: Icon(
                        Icons.edit,
                        color: PRIMARY_COLOR,
                      )),
                  IconButton(
                      onPressed: () {
                        DialogUtils().showDeleteConfirmationDialog(context, () {
                          ins.removeItem(index);
                        }, "Delete", "Do you want to Delete this item?");
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            ],
          ),
        ),
        SB_1H
      ],
    );
  }
}
