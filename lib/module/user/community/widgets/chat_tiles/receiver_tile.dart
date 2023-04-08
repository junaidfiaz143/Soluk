import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../res/color.dart';

class ReceiverTile extends StatelessWidget {
  final String message;
  final String time;
  final String avatarUrl;

  const ReceiverTile(
      {Key? key,
      required this.message,
      required this.time,
      required this.avatarUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    solukLog(logMsg: avatarUrl);
    solukLog(logMsg: message);
    return Container(
      margin: EdgeInsets.only(bottom: 12, right: 26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatarUrl == ""
              ? SvgPicture.asset(
                  'assets/svgs/placeholder.svg',
                  width: 42,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                  radius: 21,
                ),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$message",
                    // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mus maecenas in rutrum consequat elementum et. Lobortis tempus, urna accumsan massa sit blandit ac velit arcu.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '$time',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
