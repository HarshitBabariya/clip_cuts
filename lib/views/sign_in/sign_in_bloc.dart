import 'package:clip_cuts/service/auth_service.dart';
import 'package:clip_cuts/utils/auth_interceptor.dart';
import 'package:clip_cuts/views/sign_in/sign_in_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart'; // Ensure NBUtils is imported

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SignInRepo _signInRepo = SignInRepo();
  late SharedPreferences sharedPreferences;

  bool rememberMe = false;

  SignInBloc() : super(Init()) {
    on<SignInButtonEvent>(_onSignInButtonPressed);

    // Load saved credentials when Bloc is created
    _loadSavedCredentials();
    on<ToggleRememberMeEvent>((event, emit) {
      rememberMe = event.value;
      emit(Init()); // Rebuilds UI with updated rememberMe value
    });

  }



  Future<void> _loadSavedCredentials() async {
    bool? savedRememberMe = getBoolAsync('remember_me');
    if (savedRememberMe) {
      emailController.text = getStringAsync('saved_email');
      passwordController.text = getStringAsync('saved_password');
      rememberMe = true;
    }
  }

  Future<void> _onSignInButtonPressed(SignInButtonEvent event, Emitter<SignInState> emit) async {

    emit(Loading());
    try {
      final response = await _signInRepo.login(email: event.email, password: event.password);

      if (response.success) {
        final token = response.data?.data?.token ?? '';
        await AuthService.saveAuthToken(token);
        AuthInterceptor.setToken(token);



        emit(Loaded(message: response.data?.message));
      } else {
        emit(Failed(message: response.message));
      }
    } catch (e) {
      print(e.toString());
      emit(Failed(message: e.toString()));
    }

  }



  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
