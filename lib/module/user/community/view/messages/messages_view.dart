import 'package:app/module/user/community/firebase_utils/chat_firebase_utils.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/nav_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/community_header_text.dart';
import '../../widgets/tiles/recent_messages_tile.dart';
import 'chat_view.dart';

class MessagesView extends StatelessWidget {
  MessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeaderText('Messages'),
          StreamBuilder(
              stream: ChatFirebaseUtils.instance.firestore
                  .collection(ChatFirebaseUtils.instance.CONVERSATIONS)
                  .where(ChatFirebaseUtils.instance.USERIDS,
                      arrayContains: globalUserId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data!.docs.length);
                  if (snapshot.data!.docs.length > 0) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: ListView(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((document) {
                              var userCheck =
                                  document[ChatFirebaseUtils.instance.USERS][0]
                                          [ChatFirebaseUtils.instance.USERID] ==
                                      globalUserId;
                              int userIndex = userCheck ? 0 : 1;
                              return InkWell(
                                onTap: () {
                                  String chatId = "";
                                  if (int.parse(document[ChatFirebaseUtils
                                              .instance.USERS][0]
                                          [ChatFirebaseUtils.instance.USERID]) <
                                      int.parse(document[ChatFirebaseUtils
                                              .instance.USERS][1][
                                          ChatFirebaseUtils.instance.USERID])) {
                                    chatId = document[ChatFirebaseUtils
                                                .instance.USERS][0][
                                            ChatFirebaseUtils.instance.USERID] +
                                        "-" +
                                        document[ChatFirebaseUtils
                                                .instance.USERS][1]
                                            [ChatFirebaseUtils.instance.USERID];
                                  } else {
                                    chatId = document[ChatFirebaseUtils
                                                .instance.USERS][1][
                                            ChatFirebaseUtils.instance.USERID] +
                                        "-" +
                                        document[ChatFirebaseUtils
                                                .instance.USERS][0]
                                            [ChatFirebaseUtils.instance.USERID];
                                  }

                                  solukLog(
                                      logMsg: chatId, logDetail: "hajhajshajs");
                                  NavRouter.push(
                                      context,
                                      ChatView(
                                        peerUserId:
                                            "${document[ChatFirebaseUtils.instance.USERS][userIndex == 0 ? 1 : 0][ChatFirebaseUtils.instance.USERID]}",
                                        chatId: chatId,
                                        username: document[ChatFirebaseUtils
                                                .instance
                                                .USERS][userIndex == 0 ? 1 : 0][
                                            ChatFirebaseUtils
                                                .instance.USERNAME],
                                        // profilePic: document[ChatFirebaseUtils
                                        //                 .instance.USERS]
                                        //             [userIndex == 0 ? 1 : 0][
                                        //         ChatFirebaseUtils
                                        //             .instance.USERAVATAR] ??
                                        //     "",
                                        // recieverAvatar: document[
                                        //             ChatFirebaseUtils
                                        //                 .instance.USERS]
                                        //         [userIndex == 0 ? 1 : 0][
                                        //     ChatFirebaseUtils
                                        //         .instance.USERAVATAR],
                                      ));
                                },
                                child: RecentMessagesTile(
                                  peerUserId:
                                      "${document[ChatFirebaseUtils.instance.USERS][userIndex == 0 ? 1 : 0][ChatFirebaseUtils.instance.USERID]}",
                                  lastMessage:
                                      "${document[ChatFirebaseUtils.instance.LASTMESSAGE]}",
                                  readStatus: (document[ChatFirebaseUtils
                                          .instance.READSTATUS] is String)
                                      ? false
                                      : document[ChatFirebaseUtils
                                          .instance.READSTATUS],
                                  // username:
                                  //     "${document[ChatFirebaseUtils.instance.USERS][userIndex == 0 ? 1 : 0][ChatFirebaseUtils.instance.USERNAME]}",
                                  // profilePic:
                                  //     "${document[ChatFirebaseUtils.instance.USERS][userIndex == 0 ? 1 : 0][ChatFirebaseUtils.instance.USERAVATAR]}",
                                ),
                              );
                            }).toList()),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                        child: Text("No data found"),
                      ),
                    );
                  }
                } else {
                  print("loading...");
                  return Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
              }),
        ],
      ),
    );
  }
}
