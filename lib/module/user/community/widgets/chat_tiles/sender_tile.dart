import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SenderTile extends StatelessWidget {
  final String message;
  final String time;
  final String avatarUrl;

  const SenderTile(
      {Key? key, this.message = "", this.time = "", this.avatarUrl = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, left: 26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$message",
                    // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Magna sagittis scelerisque sed imperdiet in nec tellus eu. hac elementum. Semper aliquam eget tristique congue aliquam mi tellus.',
                    style: TextStyle(color: Colors.black),
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
          SizedBox(width: 4),
          avatarUrl == ""
              ? SvgPicture.asset(
                  'assets/svgs/placeholder.svg',
                  width: 42,
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                  radius: 21,
                ),
        ],
      ),
    );
  }
}
