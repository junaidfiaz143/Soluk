import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../res/color.dart';
import '../../../influencer/widgets/empty_widget.dart';
import '../../widgets/text_view.dart';

class UserInfoSelectionTile extends StatelessWidget {
  final String title;
  final bool isSelected;

  const UserInfoSelectionTile({
    Key? key,
    required this.title,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 20) + EdgeInsets.only(bottom: 14),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: isSelected
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: PRIMARY_COLOR),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: Offset(0.0, 10),
                        blurRadius: 15.0,
                      )
                    ],
                  )
                : BoxDecoration(
                    color: Color(0xffC4C4C4).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
            child: TextView(
              title,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: isSelected ? PRIMARY_COLOR : Color(0xffC4C4C4),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: isSelected
                ? SvgPicture.asset('assets/svgs/ic_tick.svg')
                : EmptyWidget(),
          )
        ],
      ),
    );
  }
}
