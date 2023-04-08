import 'package:app/module/user/community/firebase_utils/chat_firebase_utils.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

class RecentMessagesTile extends StatelessWidget {
  final String peerUserId;
  final String lastMessage;
  final String? username;
  final String? profilePic;
  final bool readStatus;

  const RecentMessagesTile(
      {Key? key,
      this.lastMessage = "",
      this.readStatus = true,
      required this.peerUserId,
      this.username,
      this.profilePic})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
        future: ChatFirebaseUtils.instance.getFirebaseUser(peerUserId),
        builder: (context, user_) {
          if (user_.hasData) {
            solukLog(logMsg: user_.data);
            return Slidable(
              enabled: true,
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                extentRatio: 0.20,
                children: [
                  SlidableAction(
                    onPressed: (BuildContext? context) => {},
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.red,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    user_.data![ChatFirebaseUtils.instance.USERAVATAR] == ""
                        ? SvgPicture.asset(
                            'assets/svgs/placeholder.svg',
                            width: 48,
                          )
                        : CircleAvatar(
                            backgroundColor: const Color(0xFFe7e7e7),
                            backgroundImage: NetworkImage(
                                '${user_.data![ChatFirebaseUtils.instance.USERAVATAR]}'),
                            radius: 24,
                          ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${user_.data![ChatFirebaseUtils.instance.USERNAME]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Just now',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                          SizedBox(height: 6),
                          Text(
                            '$lastMessage',
                            style: TextStyle(
                                fontSize: 12,
                                color: this.readStatus
                                    ? Colors.grey
                                    : Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else
            return SizedBox.shrink();
        });
  }
}
