import 'package:intl/intl.dart';

String dateFormat(DateTime date) {
  return DateFormat('dd/MM/yy').format(date);
}

DateTime parseDate(String date) {
  return DateFormat('dd/MM/yy').parse(date);
}

String changeDateFormat(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

String convertDateFormat(String dateString) {
  // Parse the input string into a DateTime object
  DateFormat inputFormat = DateFormat('dd/MM/yyyy');
  DateTime date = inputFormat.parse(dateString);

  // Format the DateTime object into the desired format
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  return outputFormat.format(date);
}

String timeFormat(DateTime date) {
  return DateFormat('HH:mm').format(date);
}

DateTime getYearStartDate(DateTime date) {
  if (date.month > 3) {
    return DateTime(date.year, 4, 1);
  } else {
    return DateTime(date.year - 1, 4, 1);
  }
}

DateTime getYearEndDate(DateTime date) {
  if (date.month > 3) {
    return DateTime(date.year + 1, 3, 31);
  } else {
    return DateTime(date.year, 3, 31);
  }
}

String reverseDateFormat(String date) {
  List<String> parts = date.split('/');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);

  // Create a DateTime object
  DateTime dateTime = DateTime(year, month, day);

  // Format the DateTime object into the desired format
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

DateTime stringToDate(String date) {
  List<String> dateParts = date.split('/');

  int day = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int year = int.parse(dateParts[2]);

  return DateTime(year, month, day);
}

int daysDuration({required String startDate, required String endDate}){
  final diffDays = DateTime.parse(endDate).difference(DateTime.parse(startDate));
  return diffDays.inDays;
}
