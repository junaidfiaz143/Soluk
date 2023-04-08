import 'package:app/module/user/community/firebase_utils/chat_firebase_utils.dart';
import 'package:app/module/user/community/widgets/chat_tiles/receiver_tile.dart';
import 'package:app/res/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../res/globals.dart';
import '../../../widgets/user_appbar.dart';
import '../../widgets/chat_tiles/sender_tile.dart';
import '../../widgets/send_message_widget.dart';

class ChatView extends StatelessWidget {
  final String peerUserId;
  final String chatId;
  final String username;

  // final String senderAvatar;
  // final String recieverAvatar;
  ChatView(
      {Key? key,
      this.chatId = "",
      this.username = "",
      // this.profilePic = "",
      // this.senderAvatar = "",
      // this.recieverAvatar = "",
      required this.peerUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String profilePic = '';

    this.chatId == ""
        ? "do nothing"
        : ChatFirebaseUtils.instance.updateReadStatus(this.chatId);
    String _chatId = this.chatId == ""
        ? ChatFirebaseUtils.instance.createNewChatId(this.peerUserId)
        : this.chatId;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: UserAppbar(
        title: '${this.username}',
        bgColor: Colors.white,
        hasBackButton: true,
      ),
      body: Column(
        children: [
          FutureBuilder<Map<String, String>>(
              future: ChatFirebaseUtils.instance.getFirebaseUser(peerUserId),
              builder: (context, user_) {
                if (user_.hasData) {
                  profilePic =
                      user_.data?[ChatFirebaseUtils.instance.USERAVATAR] ?? '';
                }
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(ChatFirebaseUtils.instance.MESSAGES)
                        .doc(ChatFirebaseUtils.instance.CHATROOMS)
                        .collection(_chatId)
                        .orderBy(ChatFirebaseUtils.instance.TIMESTAMP,
                            descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        solukLog(
                            logMsg: snapshot.data!.docs.length,
                            logDetail: "chatDetails");
                        return Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 14),
                              child: ListView(
                                  reverse: true,
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((document) {
                                    if (document[ChatFirebaseUtils
                                            .instance.SENDERID] ==
                                        globalUserId) {
                                      return SenderTile(
                                        message: document[
                                            ChatFirebaseUtils.instance.MESSAGE],
                                        time: document[ChatFirebaseUtils
                                                    .instance.TIMESTAMP] !=
                                                null
                                            ? ChatFirebaseUtils
                                                .instance.dateFormat
                                                .format(document[
                                                        ChatFirebaseUtils
                                                            .instance.TIMESTAMP]
                                                    .toDate())
                                            : "sending",
                                        avatarUrl: globalProfilePic ?? '',
                                      );
                                    } else {
                                      return ReceiverTile(
                                        message: document[
                                            ChatFirebaseUtils.instance.MESSAGE],
                                        time: document[ChatFirebaseUtils
                                                    .instance.TIMESTAMP] !=
                                                null
                                            ? ChatFirebaseUtils
                                                .instance.dateFormat
                                                .format(document[
                                                        ChatFirebaseUtils
                                                            .instance.TIMESTAMP]
                                                    .toDate())
                                            : "sending",
                                        avatarUrl: user_.data?[ChatFirebaseUtils
                                                .instance.USERAVATAR] ??
                                            '',
                                      );
                                    }
                                  }).toList())),
                        );
                      } else {
                        print("loading...");
                        return Container();
                      }
                    });
              }),
          SendMessageWidget(
            chatId: _chatId,
            isNewChat: this.chatId == "" ? true : false,
            peerUserId: this.peerUserId,
            username: this.username,
            profilePic: profilePic,
          ),
        ],
      ),
    );
  }
}
