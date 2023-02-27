import 'package:cise/product/appConstants.dart';

class Functions {
  static String getDateTimeFormat() {

    final now = DateTime.now();

    var listDate = [now.day, now.month, now.year];

    var listTime = [now.hour, now.minute, now.second, now.millisecond, now.microsecond];

    String dateTime = "";

    for (var x in listDate) {

      if (x == now.year) {
        dateTime = dateTime + x.toString() + " ";
        break;
      }
      else {
        dateTime = dateTime + x.toString() + "/";
      }
    }

    for (var x in listTime) {

      if (x == now.millisecond) {
        dateTime = dateTime + x.toString() + now.microsecond.toString();
        break;
      }
      else {
        dateTime = dateTime + x.toString() + ":";
      }
    }

    return dateTime;
  }

  static String getDataNumberOfDaysPassed(String time) {

    final dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));

    //print(dateTime);

    final date = DateTime.now().difference(dateTime);

    //print(date);

    if (date.inDays > 0) {

      if (date.inDays > 30) {
        double month = date.inDays / 30;

        if (month > 12) {
          //print("Year: $date");
          return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
        }
        else {
          //print("Month: $month");
          return "${month.floor()}m";
        }
      }
      else {
        //print("Day: ${date.inDays}");
        return "${date.inDays}d";
      }
    }
    else {
      if (date.inHours > 0) {
        //print("Hour: ${date.inHours}");
        return "${date.inHours}h";
      }
      else {
        if (date.inMinutes > 0) {
          //print("Minute: ${date.inMinutes}");
          return "${date.inMinutes}m";
        }
        else {
          //print("Second: ${date.inSeconds}");
          return "${date.inSeconds}s";
        }
      }
    }
  }

  static String getFullLanguageName(String data) {

    for (var x in AppConstants.languages.entries) {

      if (x.key == data) {
        return x.value;
      }
    }

    return data;
  }

}