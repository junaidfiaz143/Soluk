import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../../res/globals.dart';

class ChatFirebaseUtils {
  static final instance = ChatFirebaseUtils();

  var firestore = FirebaseFirestore.instance;
  final String CONVERSATIONS = "conversations";
  final String MESSAGES = "messages";
  final String MESSAGE = "message";
  final String CHATROOMS = "chatrooms";
  final String USERIDS = "userIds";
  final String USERS = "users";

  final String USERID = "userId";
  final String USERNAME = "userName";
  final String USERAVATAR = "userAvatar";

  final String TIMESTAMP = "timestamp";
  final String SENDERID = "senderId";

  final String READSTATUS = "readStatus";
  final String LASTMESSAGE = "lastMessage";

  final DateFormat dateFormat = DateFormat('dd-MM-yyyy • hh:mm a');

  Future<Map<String, String>> getFirebaseUser(String userId) async {
    var data;

    await firestore.collection("users").doc(userId).get().then((doc) {
      data = doc.data();
    }).catchError((e) {
      print("Error on get data from User");
    });

    print(data);
    return {
      "userId": data["userId"],
      "userName": data["userName"],
      "userAvatar": data["userAvatar"] ?? ""
    };
  }

  updateUserProfile(userProfilePic) {
    firestore
        .collection(USERS)
        .doc(globalUserId)
        .update({USERAVATAR: userProfilePic})
        .whenComplete(() {})
        .onError((error, stackTrace) {
          solukLog(logMsg: error);
        });
  }

  updateReadStatus(String chatId) {
    firestore
        .collection("users")
        .doc("$chatId")
        .update({"readStatus": true})
        .whenComplete(() {})
        .onError((error, stackTrace) {
          solukLog(logMsg: error);
        });
  }

  updateFirebaseUser() {
    FirebaseFirestore.instance
        .collection("users")
        .doc("$globalUserId")
        .update({"userAvatar": "https://picsum.photos/200/300"})
        .whenComplete(() {})
        .onError((error, stackTrace) {
          solukLog(logMsg: error);
        });
  }

  createNewChatId(String peerUserId) {
    if (int.parse(peerUserId) < int.parse(globalUserId!)) {
      return peerUserId + "-" + globalUserId!;
    } else {
      return globalUserId! + "-" + peerUserId;
    }
  }

// generateChatId(String user1, String user2) {
//   int nameId = 0;
//   for (int i = 0; i < user1.length; i++) {
//     nameId = nameId + user1.codeUnitAt(i);
//   }
//   print(nameId);
// }
}
