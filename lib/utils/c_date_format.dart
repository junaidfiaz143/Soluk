import 'package:intl/intl.dart';

// String getDate(DateTime date) =>
//     DateFormat('y MM dd').format(date).replaceAll(' ', '');

class CDateFormat {
  static String getDate(DateTime date) =>
      DateFormat('y MM dd').format(date).replaceAll(' ', '');

  static String fullDate(DateTime date) =>
      DateFormat('EEE, d MMM y    hh:mm a').format(date);

  static String amPm(DateTime date) => DateFormat('a').format(date);

  static String hourTime(DateTime date) => DateFormat('HH:mm').format(date);

  static String monthYear(DateTime date) => DateFormat('MMMM y').format(date);

  static DateTime parsetoDate(String formattedDate) =>
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);

  static String returnMonthDayYear(String date) {
    if (date.isEmpty) return date;
    DateTime dateTime = parsetoDate(date);
    return new DateFormat.yMMMd().format(dateTime);
  }

  static String convertTimeToMinsAndSec(String time) {
    String solukMinTime = '';
    String solukSecTime = '';
    String formattedTime = '';

    if (time.split(":").length == 2) {
      solukMinTime = time.split(":")[0];
      solukSecTime = time.split(":")[1];
      if (int.parse(solukMinTime) != 0) {
        formattedTime = "$solukMinTime Mints";
      }
      if (int.parse(solukSecTime) != 0) {
        formattedTime = "$formattedTime $solukSecTime Secs";
      }
    } else if (time.split(":").length == 3) {
      solukMinTime = time.split(":")[1];
      solukSecTime = time.split(":")[2];
      if (int.parse(solukMinTime) != 0) {
        formattedTime = "$solukMinTime Mints";
      }
      if (int.parse(solukSecTime) != 0) {
        formattedTime = "$formattedTime $solukSecTime Secs";
      }
    }

    return formattedTime;
  }
}
