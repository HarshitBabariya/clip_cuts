abstract class SignInState {}

class Init extends SignInState {}

class ObscureTxt extends SignInState {}

class Loading extends SignInState {}

class Loaded extends SignInState {
  final String? message;

  Loaded( {this.message});
}

class Failed extends SignInState {
  final String? message;

  Failed({this.message});
}

