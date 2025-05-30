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
          showCommonSnackbar(context: context, title: state.message ?? '');
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homeScreen);
        } else if (state is Failed) {
          showCommonSnackbar(context: context, title: state.message ?? '', isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: CommonProgressIndicator(
            isLoading: state is Loading,
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: 50,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? MediaQuery.of(context).viewInsets.bottom : 24
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Image.asset(
                                AppImages.signInBG,
                                width: MediaQuery.sizeOf(context).width,
                                height: MediaQuery.sizeOf(context).height / 3,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                AppImages.signIn,
                                width: 100,
                                height: 100,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: Text(
                            AppConstText.lblWelcomeBack,
                            style: AppFonts.ralewayBold.copyWith(fontSize: 24, color: AppColors.primaryTextColor),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            AppConstText.lblHello,
                            style: AppFonts.ralewayMedium.copyWith(fontSize: 16, color: AppColors.hintTextColor),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: signInBloc.formKey,
                            child: Column(
                              children: [
                                AppComponent.commonTextField(
                                  controller: signInBloc.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textFieldType: TextFieldType.EMAIL,
                                  contexts: context,
                                  iconName: AppImages.email,
                                  focusNode: signInBloc.emailFocus,
                                  hintText: AppHintText.hintEmailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppValidation.emailEmpty;
                                    } else if (!AppRegex.emailRegex.hasMatch(value)) {
                                      return AppValidation.emailNotValid;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                AppComponent.commonTextField(
                                  controller: signInBloc.passwordController,
                                  textFieldType: TextFieldType.OTHER,
                                  hintText: AppHintText.hintPassword,
                                  textInputAction: TextInputAction.done,
                                  contexts: context,
                                  focusNode: signInBloc.passwordFocus,
                                  obscureText: !signInBloc.isPasswordVisible,
                                  iconName: context.read<SignInBloc>().isPasswordVisible ? AppImages.eye : AppImages.eyeSlash,
                                  onIconTap: () {
                                    context.read<SignInBloc>().add(TogglePasswordVisibilityEvent(
                                        signInBloc.isPasswordVisible = !signInBloc.isPasswordVisible
                                    ));
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppValidation.passwordEmpty;
                                    } else if (!AppRegex.passwordRegex.hasMatch(value)) {
                                      return AppValidation.passwordNotValid;
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          AppConstText.lblRemember,
                                          style: AppFonts.ralewayMedium.copyWith(fontSize: 13, color: AppColors.primaryTextColor),
                                        ),
                                        activeColor: AppColors.yellowColor,
                                        controlAffinity: ListTileControlAffinity.leading,
                                        side: BorderSide(color: AppColors.normalBorderColor),
                                        value: signInBloc.rememberMe,
                                        onChanged: (value) {
                                          signInBloc.add(ToggleRememberMeEvent(value ?? false));
                                        },
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        AppConstText.lblForget,
                                        style: AppFonts.ralewayMedium.copyWith(fontSize: 13, color: AppColors.hintTextColor),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                AppComponent.commonBtn(
                                  context: context,
                                  btnText: AppConstText.lblSignIn.toUpperCase(),
                                  onTap: () {
                                    if (signInBloc.formKey.currentState!.validate()) {
                                      signInBloc.add(SignInButtonEvent(
                                        email: signInBloc.emailController.text,
                                        password: signInBloc.passwordController.text,
                                      ));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppConstText.lblDoNotAccount,
                        style: AppFonts.ralewayMedium.copyWith(fontSize: 14, color: AppColors.hintTextColor),
                      ),
                      TextButton(
                        onPressed: () {
                          NavigatorService.pushNamed(AppRoutes.signUpScreen);
                        },
                        child: Text(
                          AppConstText.lblSignUp,
                          style: AppFonts.ralewayBold.copyWith(fontSize: 14, color: AppColors.primaryTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
