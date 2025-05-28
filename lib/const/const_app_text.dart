class AppConstText {
  static const String appName = "Clip Cuts";

  ///Dialog MSG
  static const String lblLogOut = "Are you sure you want to\nlogout?";

}

class AppHintText {
  static const String hintFullName = "Full Name";
  static const String hintEmailAddress = "Email address";
  static const String hintPassword = "Password";
  static const String hintSearch = "Search by name or pet ID";
}

class AppValidation {

  static const userEmpty = "Please enter your User ID.";
  static const passwordEmpty = "Please enter your password.";
  static const errorMessage = "Oops! Something went wrong.";
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