import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WorkoutSetsTile extends StatelessWidget {
  Color? titleColor;
  Color? titleDetailColor;
  String? title;
  String? titleDetail;
  var onEditPress;
  var onDeletePress;
  var onAddPress;
  bool showIcon;
  bool? showEditIcon = true;
  final double? horizontalPadding;
  final int? index;
  WorkoutSetsTile({
    Key? key,
    required this.titleColor,
    required this.titleDetailColor,
    required this.title,
    required this.titleDetail,
    this.onEditPress,
    this.onDeletePress,
    this.onAddPress,
    required this.showIcon,
    this.showEditIcon,
    this.horizontalPadding = 25,
    this.index = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("--- inside workout sets tile $title ---");
    print("--- inside workout sets tile $titleDetail ---");
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 15, horizontal: horizontalPadding!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: defaultSize.screenWidth * 0.25,
                child: Text(
                  title!,
                  style: labelTextStyle(context)?.copyWith(
                    color: titleDetailColor ?? Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              // Text(
              //   title!,
              //   style: labelTextStyle(context)?.copyWith(
              //     color: titleDetailColor ?? Colors.grey,
              //     fontSize: 12.sp,
              //   ),
              // ),
              if (showIcon == false)
                SizedBox(
                  width: defaultSize.screenWidth * 0.25,
                  child: Text(
                    titleDetail!,
                    style: labelTextStyle(context)?.copyWith(
                      color: titleDetailColor ?? Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              // Text(
              //   titleDetail!,
              //   style: labelTextStyle(context)?.copyWith(
              //     color: titleDetailColor ?? Colors.grey,
              //     fontSize: 12.sp,
              //   ),
              // )
              else
                SizedBox(
                  width: defaultSize.screenWidth * 0.25,
                  child: InkWell(
                    onTap: onAddPress,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_circle,
                          color: PRIMARY_COLOR,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "  " + AppLocalisation.getTranslated(context, LKAdd),
                          style: labelTextStyle(context)?.copyWith(
                            color: PRIMARY_COLOR,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // InkWell(
              //   onTap: onAddPress,
              //   child: Row(
              //     children: [
              //       const Icon(
              //         Icons.add_circle,
              //         color: PRIMARY_COLOR,
              //         size: 20,
              //       ),
              //       const SizedBox(
              //         width: 5,
              //       ),
              //       Text(
              //         "  " + AppLocalisation.getTranslated(context, LKAdd),
              //         style: labelTextStyle(context)?.copyWith(
              //           color: PRIMARY_COLOR,
              //           fontSize: 12.sp,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              if (showIcon == false && index == 0)
                if (showEditIcon == true)
                  InkWell(
                    onTap: () {
                      onEditPress();
                    },
                    child: const Icon(
                      Icons.edit,
                      color: PRIMARY_COLOR,
                    ),
                  )
                else
                  SB_4W
              else
                SB_4W,
              if (showIcon == false)
                if (showEditIcon == true)
                  InkWell(
                    onTap: onDeletePress,
                    child: const Icon(
                      Icons.delete_outline_outlined,
                      color: RED_COLOR,
                    ),
                  )
                else
                  SB_4W
              else
                SB_4W
            ],
          ),
        ),
      ],
    );
  }
}
