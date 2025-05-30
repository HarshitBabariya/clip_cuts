import 'package:flutter/Material.dart';

abstract class SignUpEvent {}

class PickProfileImageEvent extends SignUpEvent {
  final BuildContext context;
  PickProfileImageEvent({required this.context});
}

class PickImageFromCameraEvent extends SignUpEvent {}

class PickImageFromGalleryEvent extends SignUpEvent {}

class TermsPolicyEvent extends SignUpEvent {
  final bool value;
  TermsPolicyEvent(this.value);
}

class CountryCodeChanged extends SignUpEvent {
  final String code;
  CountryCodeChanged(this.code);
}

class SelectGender extends SignUpEvent {
  final String gender;
  SelectGender(this.gender);
}

class TogglePasswordVisibilityEvent extends SignUpEvent {
  final bool isPasswordVisible;
  TogglePasswordVisibilityEvent(this.isPasswordVisible);
}
class ToggleConfirmPasswordVisibilityEvent extends SignUpEvent {
  final bool isConfirmPasswordVisible;
  ToggleConfirmPasswordVisibilityEvent(this.isConfirmPasswordVisible);
}