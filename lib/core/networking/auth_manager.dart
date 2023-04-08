class AuthManager {
  AuthManager._privateConstructor();

  static final AuthManager instance = AuthManager._privateConstructor();
  String? access_token;

  initialize() async {
    try {
      access_token = "Access token";

      print("access_token : ${access_token}");
    } catch (e) {
      print("ex : $e");
    }
  }

  Map<String, String> get authHeaders {
    //print("session id : ${user.session_id}");

    return {
      "Sessionid": access_token ?? "",
      "Accept": "*/*",
      "Content-type": "application/x-www-form-urlencoded",
    };
  }
}
