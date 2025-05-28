import 'package:nb_utils/nb_utils.dart';

removePrefKey(String key,) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

savePrefString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getPrefString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? "";
}

savePrefInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

getPrefInt(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key) ?? 0;
}

savePrefBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<bool> getPrefBool(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

savePrefDouble(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

Future<double> getPrefDouble(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(key) ?? 0.00;
}

savePrefList(String key, List<String> value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);
}

Future<List<String>> getPrefList(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key) ?? [];
}

class AppPrefKey {
  static const String websysCustomerCode = "websysCustomerCode";
  static const String jwtToken = "jwtToken";
  static const String masterToken = "masterToken";
  static const String isCustomerLogin = "isCustomerLogin";
  static const String isUserLogin = "isUserLogin";
  static const String userId = "userId";
  static const String userName = "userName";
  static const String userTypeId = "userTypeId";
  static const String fmcToken = "fmcToken";

  static const String currentCompanyName = "currentCompanyName";
  static const String currentCompanyId = "currentCompanyId";
  static const String currentYearId = "currentYearId";
  static const String bluePrinterDevice = "bluePrinterDevice";
  static const String stockDisplaySettings = "StockDisplaySettings";
  static const String printerSettings = "PrinterSettings";
}
