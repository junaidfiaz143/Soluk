import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/module/influencer/bloc/language_bloc.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/enums.dart';

class ItemHeader extends StatelessWidget {
  final String title;
  const ItemHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HEIGHT_5 * 4,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              CHALLENGES,
            ),
            fit: BoxFit.cover),
      ),
      padding: EdgeInsets.symmetric(
            horizontal: HORIZONTAL_PADDING,
          ) +
          EdgeInsets.only(
            top: defaultSize.screenHeight * .02,
          ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<LanguageBloc, Language>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: defaultSize.screenWidth * .09,
                        maxWidth: defaultSize.screenWidth * .09,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          defaultSize.screenWidth * .02,
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: state == Language.ENGLISH
                            ? defaultSize.screenWidth * .02
                            : 0,
                        right: state == Language.ARABIC
                            ? defaultSize.screenWidth * .02
                            : 0,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: defaultSize.screenWidth * .05,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Text(
                title,
                style: headingTextStyle(context)?.copyWith(
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: defaultSize.screenWidth * .09,
                    maxWidth: defaultSize.screenWidth * .09,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      defaultSize.screenWidth * .02,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: defaultSize.screenWidth * .05,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
