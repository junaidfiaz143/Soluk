import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendMessageWidget extends StatefulWidget {
  final String chatId;
  final bool isNewChat;
  final String peerUserId;
  final String username;
  final String profilePic;

  const SendMessageWidget({
    Key? key,
    required this.chatId,
    this.isNewChat = false,
    this.peerUserId = "",
    this.username = "",
    this.profilePic = "",
  }) : super(key: key);

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController messageController = TextEditingController();

  updateLastMessage(String message) {
    solukLog(logMsg: "inside onSendMessage");
    FirebaseFirestore.instance
        .collection("conversations")
        .doc("${widget.chatId}")
        .update({
          "lastMessage": "$message",
          "timestamp": FieldValue.serverTimestamp(),
          "readStatus": false
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          solukLog(logMsg: error);
        });
  }

  onSendMessage(String message) {
    solukLog(logMsg: "inside onSendMessage");
    FirebaseFirestore.instance
        .collection("messages")
        .doc("chatrooms")
        .collection("${widget.chatId}")
        .doc()
        .set({
      "senderName": "$globalUserName",
      "senderId": "$globalUserId",
      "message": "$message",
      "timestamp": FieldValue.serverTimestamp(),
    }).whenComplete(() {
      updateLastMessage(message);
    }).onError((error, stackTrace) {
      solukLog(logMsg: error);
    });
  }

  startNewConversation(String message) {
    solukLog(logMsg: "inside startNewConversation");
    FirebaseFirestore.instance
        .collection("conversations")
        .doc("${widget.chatId}")
        .set({
          "lastMessage": "$globalUserName",
          "readStatus": "$globalUserId",
          "message": "$message",
          "timestamp": FieldValue.serverTimestamp(),
          "userIds": ["$globalUserId", "${widget.peerUserId}"],
          "users": [
            {
              "userId": "${widget.peerUserId}",
              "userName": "${widget.username}",
              "userAvatar": "${widget.profilePic}",
            },
            {
              "userId": "$globalUserId",
              "userName": "$globalUserName",
              "userAvatar": "",
            }
          ]
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          solukLog(logMsg: error);
        });
  }

  createNewUser() {
    solukLog(logMsg: "inside startNewConversation");
    FirebaseFirestore.instance
        .collection("users")
        .doc("${widget.peerUserId}")
        .set({
          "userId": "${widget.peerUserId}",
          "userName": "${widget.username}",
          "userAvatar": "${widget.profilePic}",
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          solukLog(logMsg: error);
        });
    FirebaseFirestore.instance
        .collection("users")
        .doc("${globalUserId}")
        .set({
          "userId": "${globalUserId}",
          "userName": "${globalUserName}",
          "userAvatar": "",
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          solukLog(logMsg: error);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20) +
          EdgeInsets.only(bottom: 14),
      // todo : manage platform-level padding
      child: Row(
        children: [
          Flexible(
            child: TextField(
              onChanged: (val) {
                setState(() {});
              },
              cursorColor: Colors.grey,
              controller: messageController,
              decoration: InputDecoration(
                  hintText: 'Write message here...',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: _outlineInputBorder,
                  isDense: true,
                  disabledBorder: _outlineInputBorder,
                  enabledBorder: _outlineInputBorder,
                  focusedBorder: _outlineInputBorder),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (messageController.text.length > 0) {
                onSendMessage(messageController.text);
                if (widget.isNewChat) {
                  startNewConversation(messageController.text);
                  createNewUser();
                }
                solukLog(logMsg: messageController.text);
                messageController.clear();
                setState(() {});
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: messageController.text.length > 0
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
);
