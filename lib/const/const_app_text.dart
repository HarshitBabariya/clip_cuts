class AppConstText {
  static const String appName = "Clip Cuts";
  static const String appLabel = "ClipCuts";
  static const String lblWelcomeBack = "Welcome Back";
  static const String lblHello = "Hello there. sign in to continue";
  static const String lblRemember = "Remember me";
  static const String lblForget = "Forget password?";
  static const String lblDoNotAccount = "Don't have an account?";
  static const String lblMatting = "Matting";
  static const String lblBreedingPartner = "Breeding Partner";
  static const String lblPregnancy = "Pregnancy";
  static const String lblY = "Y";
  static const String lblN = "N";
  static const String lblId = "Id";
  static const String lblAlreadyAccount = "Already have an account?";
  static const String lblWelcome = "Hi welcome there";
  static const String lblSelectImage = "Select Image Source";
  static const String lblCreateAccount = "Please create your new account";
  static const String lblUploadPic = "Upload profile picture";
  static const String lblTermsPolicy = "By Signing up, you agree to our Terms & Privacy Policy.";


  ///Dialog MSG
  static const String lblLogOut = "Are you sure you want to\nlogout?";

  ///Button
  static const String lblYes = "YES";
  static const String lblNo = "NO";
  static const String lblCamera = "Camera";
  static const String lblGallery = "Gallery";
  static const String lblSignIn = "Sign In";
  static const String lblSignUp = "Sign Up";

}

class AppHintText {
  static const String hintFullName = "Full Name";
  static const String hintEmailAddress = "Email address";
  static const String hintMobileNumber = "Mobile number";
  static const String hintPassword = "Password";
  static const String hintConfirmPassword = "Confirm Password";
  static const String hintSearch = "Search by name or pet ID";
}

class AppValidation {

  static const nameEmpty = "Please enter full name.";
  static const emailEmpty = "Please enter email.";
  static const numberEmpty = "Please enter mobile number.";
  static const numberNotValid = "Please enter at least 5 digits.";
  static const emailNotValid = "Please enter proper email.";
  static const passwordEmpty = "Please enter password.";
  static const passwordNotValid = "Please enter valid password.";
  static const passwordNotMatch = "Password does not match.";
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