class AppConstText {
  static const String appName = "Clip Cuts";
  static const String appLabel = "ClipCuts";

  ///Dialog MSG
  static const String lblLogOut = "Are you sure you want to\nlogout?";

  ///Button
  static const String lblYes = "Yes";
  static const String lblNo = "No";

}

class AppHintText {
  static const String hintFullName = "Full Name";
  static const String hintEmailAddress = "Email address";
  static const String hintPassword = "Password";
  static const String hintSearch = "Search by name or pet ID";
}

class AppValidation {

  static const emailEmpty = "Please enter email.";
  static const emailNotValid = "Please enter proper email.";
  static const passwordEmpty = "Please enter password.";
  static const passwordNotValid = "Please enter password.";
  static const errorMessage = "Please enter proper password with minimum 8 characters.";
}

class AppRegex {
  static RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$`%^&*~]).{8,}$');
  static RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp commonRegex = RegExp("[a-zA-Z0-9]");
  static RegExp nameRegex = RegExp(r"^[a-zA-Z]+([',-][a-zA-Z ])");
  static RegExp phoneNumber = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  static RegExp amountFormat = RegExp(r'^\d+\.?\d{0,4}');
  static RegExp negativeAmountFormat = RegExp(r'^-?\d+(\.\d{0,4})?$');
  static RegExp discountPercentageFormat = RegExp(r'^\d+\.?\d{0,4}%?$');
  static RegExp addressRegex = RegExp(r'^\d+\s[A-z]+\s[A-z]+(?:\s[A-z]+)?,\s[A-z]+\s[A-z]+\s(?:[A-z]+\s)?\d{6}(?:-\d{4})?$');
}