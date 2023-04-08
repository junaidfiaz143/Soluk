import 'package:app/res/globals.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlanTile extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback callback;
  const PlanTile({
    Key? key,
    required this.image,
    required this.title,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            callback();
          },
          child: Container(
            width: double.maxFinite,
            height: HEIGHT_5 * 1.3,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: WIDTH_5 * 3,
                      height: HEIGHT_5 * 1.3,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        image: DecorationImage(
                          image: AssetImage(
                            image,
                          ),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                      ),
                      // child: Image(
                      //   image: AssetImage(
                      //     image,
                      //   ),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      title,
                      style: subTitleTextStyle(context)?.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SB_1H
      ],
    );
  }
}