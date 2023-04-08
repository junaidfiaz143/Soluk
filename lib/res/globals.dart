import 'dart:convert';

import 'package:app/utils/default_size.dart';
import 'package:flutter/material.dart';

import '../repo/data_source/remote_data_source.dart';
import '../repo/repository/web_service.dart';
import '../utils/dependency_injection.dart';

// Username and UserId for chat
String? globalUserId;
String? globalUserName;
String? globalProfilePic;
String? globalUserType;
bool? globalUserSubscription;

String? selectedWorkoutProgram;
int? selectedWorkoutProgramId = -1;

double? subscriptionCharges = 0.0;

//Use defaultSize to set height and width of widgets
DefaultSize defaultSize = DefaultSize();

///Use this Height in [SizedBox]
double HEIGHT_1 = defaultSize.screenHeight * .03;
double HEIGHT_2 = defaultSize.screenHeight * .05;
double HEIGHT_3 = defaultSize.screenHeight * .06;
double HEIGHT_4 = defaultSize.screenHeight * .07;
double HEIGHT_5 = defaultSize.screenHeight * .1;

double WIDTH_1 = defaultSize.screenWidth * .03;
double WIDTH_2 = defaultSize.screenWidth * .05;
double WIDTH_3 = defaultSize.screenWidth * .06;
double WIDTH_4 = defaultSize.screenWidth * .07;
double WIDTH_5 = defaultSize.screenWidth * .1;
double WIDTH_6 = defaultSize.screenWidth * .2;

///Use this padding while using [EdgeInsets.symmetric(horizontal: )]
double HORIZONTAL_PADDING = defaultSize.screenWidth * .05;

EdgeInsets DEFAULT_HORIZONTAL_PADDING = EdgeInsets.symmetric(
  horizontal: HORIZONTAL_PADDING,
);

//Border Radius Of Button
BorderRadius BORDER_CIRCULAR_RADIUS = BorderRadius.circular(
  defaultSize.screenWidth * .03,
);

///Use this [TextStyle] for Headings
TextStyle? headingTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.headline4?.copyWith(
        fontSize: defaultSize.screenWidth * .065,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
}

///Use this [TextStyle] for subTitles
TextStyle? subTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.headline4?.copyWith(
        fontSize: defaultSize.screenWidth * .055,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );
}

///Use this [TextStyle] for simple text
TextStyle? labelTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyText1?.copyWith(
        fontSize: defaultSize.screenWidth * .04,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        letterSpacing: 0.1,
      );
}

///Use this [TextStyle] for hint text
TextStyle? hintTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyText1?.copyWith(
        fontSize: defaultSize.screenWidth * .04,
        fontWeight: FontWeight.normal,
        color: Colors.grey,
        letterSpacing: 0.1,
      );
}

///Use this [TextStyle] for button text
TextStyle? buttonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyText2?.copyWith(
        fontSize: defaultSize.screenWidth * .045,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 0.1,
      );
}

//RegEx for Email
RegExp getEmailRegExp() {
  return RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
}

//RegEx for Name
RegExp getFullNameExp() {
  return RegExp(r"^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$");
}

//RegEx for Phone Number
RegExp getPhoneNumberExp() {
  return RegExp(r"^(?:[+0]9)?[0-9]$");
}

//RegEx for Phone Number
RegExp getUsernameExp() {
  return RegExp(r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$");
}

//RegEx for removing leading Zero 00339 -> 339
RegExp getRemovedLeadingZero() {
  return RegExp(r'^0+(?=.)');
}

//Vertical SizedBox Between Widgets
SizedBox SB_BY_4 = SizedBox(
  height: HEIGHT_1 / 4,
);
SizedBox SB_Half = SizedBox(
  height: HEIGHT_1 / 2,
);
SizedBox SB_1H = SizedBox(
  height: HEIGHT_1,
);
SizedBox SB_2H = SizedBox(
  height: HEIGHT_2,
);
SizedBox SB_3H = SizedBox(
  height: HEIGHT_3,
);
SizedBox SB_4H = SizedBox(
  height: HEIGHT_4,
);
SizedBox SB_5H = SizedBox(
  height: HEIGHT_5,
);

//Horizontal SizedBox Between Widgets
SizedBox SB_BY_4W = SizedBox(
  width: WIDTH_1 / 4,
);
SizedBox SB_1W = SizedBox(
  width: WIDTH_1,
);
SizedBox SB_2W = SizedBox(
  width: WIDTH_2,
);
SizedBox SB_3W = SizedBox(
  width: WIDTH_3,
);
SizedBox SB_4W = SizedBox(
  width: WIDTH_4,
);
SizedBox SB_5W = SizedBox(
  width: WIDTH_5,
);
SizedBox SB_6W = SizedBox(
  width: WIDTH_6,
);

//Navigator Key will be used to routing
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//Print colored logs in VS Code console and very helpful in finding logs
String solukLogTypeInfo = "info",
    solukLogTypeError = "error",
    solukLogTypeWarning = "warning";
solukLog(
    {required dynamic logMsg, dynamic logDetail = "", String type = "info"}) {
  // var logger = Logger();

  logMsg = logMsg.toString();
  logDetail = logDetail.toString();
  if (logDetail != "") {
    logDetail = " : " + logDetail;
    logMsg += logDetail;
  }
  if (type == "info") {
    // logger.i("$logMsg");
    debugPrint("\x1B[32m--> $logMsg <--\x1B[0m");
  } else if (type == "warning") {
    // logger.w("$logMsg");
    debugPrint("\x1B[33m--> $logMsg <--\x1B[0m");
  } else if (type == "error") {
    // logger.e("$logMsg");
    debugPrint("\x1B[31m--> $logMsg <--\x1B[0m");
  }
}

//Format HH:MM:SS or MM:SS to MM:SS MINS or SECS
Map<String, String> solukFormatTime(String time) {
  Map<String, String> solukTime = {
    "time": "",
    "type": "",
  };

  if (time.split(":").length == 2) {
    solukTime["time"] = "${time.split(":")[0]}:${time.split(":")[1]}";
    if (int.parse(time.split(":")[0]) == 0) {
      solukTime["type"] = " Secs";
    } else {
      solukTime["type"] = " Mins";
    }
  } else if (time.split(":").length == 3) {
    solukTime["time"] = "${time.split(":")[1]}:${time.split(":")[2]}";
    if (int.parse(time.split(":")[1]) == 0) {
      solukTime["type"] = " Secs";
    } else {
      solukTime["type"] = " Mins";
    }
  }
  return solukTime;
}

loadPackageDetails() async {
  ApiResponse apiResponse = await sl.get<WebServiceImp>().fetchGetAPI(
        endPoint: 'api/packages',
      );

  var response = jsonDecode(apiResponse.data);
  solukLog(logMsg: response);

  subscriptionCharges =
      double.parse(response["responseDetails"]["data"][0]["price"].toString());
}

// Demo payment Variable
bool? isPayment_Demo = false;
bool isDietUpdated = false;
