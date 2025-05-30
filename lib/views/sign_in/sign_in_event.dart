abstract class SignInEvent {}

class SignInButtonEvent extends SignInEvent {
  final String email, password;

  SignInButtonEvent({
    required this.email,
    required this.password,
  });
}
class ToggleRememberMeEvent extends SignInEvent {
  final bool value;
  ToggleRememberMeEvent(this.value);
}

class TogglePasswordVisibilityEvent extends SignInEvent {
  final bool isPasswordVisible;
  TogglePasswordVisibilityEvent(this.isPasswordVisible);
}

class PickImageEvent extends SignInEvent {}