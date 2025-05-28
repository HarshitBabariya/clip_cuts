import 'package:clip_cuts/common/widget/app_component.dart';
import 'package:clip_cuts/common/widget/common_progress_indicatior.dart';
import 'package:clip_cuts/common/widget/common_snackbar.dart';
import 'package:clip_cuts/const/const_app_text.dart';
import 'package:clip_cuts/routes/app_routes.dart';
import 'package:clip_cuts/routes/navigation_services.dart';
import 'package:clip_cuts/views/sign_in/sign_in_event.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/const_app_fonts.dart';
import '../../const/const_app_images.dart';
import '../../const/const_color.dart';
import 'sign_in_bloc.dart';
import 'sign_in_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: const SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signInBloc = context.watch<SignInBloc>();

    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is Loaded) {
          //todo
          showCommonSnackbar(context: context, title: state.message ?? '');
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeScreen);
        } else if (state is Failed) {
          showCommonSnackbar(context: context, title: state.message ?? '', isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: CommonProgressIndicator(
            isLoading: state is Loading,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Image.asset(AppImages.loginBG, width: MediaQuery.sizeOf(context).width, height: MediaQuery.sizeOf(context).height / 3, fit: BoxFit.cover, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const SizedBox();
                      }),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(AppImages.appLogo, width: 125, height: 125, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const SizedBox();
                      }),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      SizedBox(height: 25),
                      Center(child: Text("Welcome Back", style: AppFonts.ralewayBold.copyWith(fontSize: 24, color: AppColors.primaryTextColor))),
                      SizedBox(height: 5),
                      Center(child: Text("Hello there. sign in to continue", style: AppFonts.ralewayMedium.copyWith(fontSize: 16, color: AppColors.hintTextColor))),
                      SizedBox(height: 20),
                      Form(
                        key: context.read<SignInBloc>().formKey,
                        child: Column(
                          children: [
                            AppComponent.commonTextField(
                              controller: context.read<SignInBloc>().emailController,
                              keyboardType: TextInputType.emailAddress,
                              textFieldType: TextFieldType.EMAIL,
                              icon: Icons.email,
                              hintText: AppHintText.hintEmailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter email.";
                                } else if (!AppRegex.emailRegex.hasMatch(value)) {
                                  return "Please enter proper email.";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            AppComponent.commonTextField(
                              controller: context.read<SignInBloc>().passwordController,
                              textFieldType: TextFieldType.PASSWORD,
                              hintText: AppHintText.hintPassword,
                              textInputAction: TextInputAction.done,
                              icon: Icons.remove_red_eye,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password.";
                                } else if (!AppRegex.passwordRegex.hasMatch(value)) {
                                  return "Please enter proper password with minimum 8 characters.";
                                }
                                return null;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                    title: Text("Remember me", style: AppFonts.ralewayMedium.copyWith(fontSize: 13, color: AppColors.primaryTextColor)),
                                    activeColor: AppColors.yellowColor,
                                    controlAffinity: ListTileControlAffinity.leading,
                                    side: BorderSide(color: AppColors.normalBorderColor),
                                    value: signInBloc.rememberMe,
                                    onChanged: (value) {
                                      context.read<SignInBloc>().add(ToggleRememberMeEvent(value ?? false));
                                    },
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forget password?",
                                      style: AppFonts.ralewayMedium.copyWith(fontSize: 13, color: AppColors.hintTextColor),
                                    ))
                              ],
                            ),
                            SizedBox(height: 15),
                            AppButton(
                              color: AppColors.btnColor,
                              splashColor: AppColors.btnColor,
                              width: MediaQuery.sizeOf(context).width,
                              shapeBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(53))),
                              onTap: () {
                                if (signInBloc.formKey.currentState!.validate()) {
                                  context.read<SignInBloc>().add(SignInButtonEvent(email: signInBloc.emailController.text, password: signInBloc.passwordController.text));
                                }
                              },
                              child: Text("SIGN IN", style: AppFonts.ralewayBold.copyWith(fontSize: 16, color: AppColors.white)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: AppFonts.ralewayMedium.copyWith(fontSize: 14, color: AppColors.hintTextColor)),
                    TextButton(
                      onPressed: () {},
                      child: Text("Sign up ", style: AppFonts.ralewayBold.copyWith(fontSize: 14, color: AppColors.primaryTextColor)),
                    )
                  ],
                ),
                SizedBox(height: 5)
              ],
            ),
          ),
        );
      },
    );
  }
}
