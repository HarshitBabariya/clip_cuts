import 'dart:io';

import 'package:clip_cuts/common/widget/app_component.dart';
import 'package:clip_cuts/const/const_app_text.dart';
import 'package:clip_cuts/routes/app_routes.dart';
import 'package:clip_cuts/routes/navigation_services.dart';
import 'package:clip_cuts/views/sign_up/sign_up_bloc.dart';
import 'package:clip_cuts/views/sign_up/sign_up_event.dart';
import 'package:clip_cuts/views/sign_up/sign_up_state.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/widget/common_snackbar.dart';
import '../../const/const_app_fonts.dart';
import '../../const/const_app_images.dart';
import '../../const/const_color.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.watch<SignUpBloc>();

    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: Stack(
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
                      Container(
                        padding: EdgeInsets.only(bottom: 25),
                        child: Image.asset(AppImages.signUpBg, width: MediaQuery.sizeOf(context).width, fit: BoxFit.cover, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const SizedBox();
                        }),
                      ),
                      Column(
                        children: [
                          Center(child: Text(AppConstText.lblWelcome, style: AppFonts.ralewayBold.copyWith(fontSize: 24, color: AppColors.primaryTextColor))),
                          SizedBox(height: 5),
                          Center(child: Text(AppConstText.lblCreateAccount, style: AppFonts.ralewayMedium.copyWith(fontSize: 16, color: AppColors.hintTextColor))),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                              key: context.read<SignUpBloc>().formKey,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      context.read<SignUpBloc>().add(PickProfileImageEvent(context: context));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppConstText.lblUploadPic, style: AppFonts.ralewaySemiBold.copyWith(fontSize: 16, color: AppColors.primaryTextColor)),
                                        Container(
                                          height: 70,
                                          width: 70,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppColors.normalBorderColor),
                                            image: DecorationImage(
                                              alignment: Alignment.center,
                                              image: signUpBloc.imagePath != null
                                                  ? FileImage(File(signUpBloc.imagePath!)) as ImageProvider
                                                  : AssetImage(AppImages.camera),
                                              fit: signUpBloc.imagePath != null ? BoxFit.cover : BoxFit.none,
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  AppComponent.commonTextField(
                                    controller: context.read<SignUpBloc>().fullNameController,
                                    keyboardType: TextInputType.name,
                                    textFieldType: TextFieldType.NAME,
                                    contexts: context,
                                    iconName: AppImages.user,
                                    focusNode: signUpBloc.nameFocus,
                                    hintText: AppHintText.hintFullName,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppValidation.nameEmpty;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  AppComponent.commonTextField(
                                    controller: context.read<SignUpBloc>().emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textFieldType: TextFieldType.EMAIL,
                                    contexts: context,
                                    iconName: AppImages.email,
                                    focusNode: signUpBloc.emailFocus,
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
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: context.read<SignUpBloc>().mobileController,
                                    keyboardType: TextInputType.phone,
                                    focusNode: signUpBloc.mobileFocus,
                                    textInputAction: TextInputAction.next,
                                    maxLength: 15,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(15),
                                    ],
                                    style: AppFonts.ralewaySemiBold.copyWith(color: AppColors.primaryTextColor),
                                    validator: (value){
                                      if(value == null || value.isEmpty){
                                        return AppValidation.numberEmpty;
                                      }else if(value.length < 5){
                                        return  AppValidation.numberNotValid;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: WidgetStateColor.resolveWith((states) {
                                        if (states.contains(WidgetState.focused)) {
                                          return AppColors.primaryColor.withValues(alpha: 0.1);
                                        }
                                        return AppColors.white;
                                      }),
                                      counterText: "",
                                      prefixIcon: BlocBuilder<SignUpBloc, SignUpState>(
                                        builder: (context, state) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 4, right: 4.0),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: signUpBloc.selectedCountryCode,
                                                icon: Padding(padding: EdgeInsets.only(left: 4,right: 4),child: Icon(Icons.arrow_drop_down_circle,color: AppColors.black,size: 20,)),
                                                items: context.read<SignUpBloc>().countryList.map((country) {
                                                  return DropdownMenuItem<String>(
                                                    value: country.dialCode,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 4),
                                                      child: Text(country.dialCode, style: AppFonts.ralewaySemiBold),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newCode) {
                                                  if (newCode != null) {
                                                    context.read<SignUpBloc>().add(CountryCodeChanged(newCode));
                                                  }
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      focusColor: AppColors.primaryColor.withValues(alpha: 0.1),
                                      hintText: AppHintText.hintMobileNumber,
                                      hintStyle: AppFonts.ralewayRegular.copyWith(color: AppColors.iconColor),
                                      suffixIcon: Image.asset(
                                        AppImages.call,
                                        width: 25,
                                        height: 25,
                                        color: signUpBloc.mobileFocus.hasFocus ? AppColors.primaryColor : AppColors.iconColor,
                                      ),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.normalBorderColor, width: 1),
                                          borderRadius: BorderRadius.all(Radius.circular(18))),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
                                          borderRadius: BorderRadius.all(Radius.circular(18))),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    spacing: 15,
                                    children: [
                                      Expanded(
                                        child: _buildGenderOption(
                                          gender: 'Male',
                                          isSelected: context.read<SignUpBloc>().selectedGender == 'Male',
                                          onTap: () {
                                            signUpBloc.add(SelectGender('Male'));
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: _buildGenderOption(
                                          gender: 'Female',
                                          isSelected: context.read<SignUpBloc>().selectedGender == 'Female',
                                          onTap: () {
                                            signUpBloc.add(SelectGender('Female'));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  AppComponent.commonTextField(
                                    controller: context.read<SignUpBloc>().passwordController,
                                    textFieldType: TextFieldType.PASSWORD,
                                    hintText: AppHintText.hintPassword,
                                    obscureText: !signUpBloc.isPasswordVisible,
                                    textInputAction: TextInputAction.next,
                                    focusNode: signUpBloc.passwordFocus,
                                    contexts: context,
                                    iconName: context.read<SignUpBloc>().isPasswordVisible  ? AppImages.eye : AppImages.eyeSlash,
                                    onIconTap: () {
                                      context.read<SignUpBloc>().add(TogglePasswordVisibilityEvent(
                                          signUpBloc.isPasswordVisible = !signUpBloc.isPasswordVisible
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
                                  SizedBox(height: 15),
                                  AppComponent.commonTextField(
                                    controller: context.read<SignUpBloc>().confirmPasswordController,
                                    textFieldType: TextFieldType.OTHER,
                                    hintText: AppHintText.hintConfirmPassword,
                                    textInputAction: TextInputAction.done,
                                    focusNode: signUpBloc.confirmPasswordFocus,
                                    contexts: context,
                                    obscureText: !signUpBloc.isConfirmPasswordVisible,
                                    iconName: context.read<SignUpBloc>().isConfirmPasswordVisible ? AppImages.eye : AppImages.eyeSlash,
                                    onIconTap: () {
                                      context.read<SignUpBloc>().add(ToggleConfirmPasswordVisibilityEvent(
                                          signUpBloc.isConfirmPasswordVisible = !signUpBloc.isConfirmPasswordVisible
                                      ));
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppValidation.passwordEmpty;
                                      } else if (!AppRegex.passwordRegex.hasMatch(value)) {
                                        return AppValidation.passwordNotValid;
                                      } else if(value != context.read<SignUpBloc>().passwordController.text){
                                        return AppValidation.passwordNotMatch;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      AppConstText.lblTermsPolicy,
                                      textAlign: TextAlign.start,
                                      style: AppFonts.ralewayMedium.copyWith(fontSize: 13, color: AppColors.primaryTextColor),
                                    ),
                                    activeColor: AppColors.yellowColor,
                                    controlAffinity: ListTileControlAffinity.leading,
                                    side: BorderSide(color: AppColors.normalBorderColor),
                                    value: signUpBloc.termsPolicy,
                                    onChanged: (value) {
                                      signUpBloc.add(TermsPolicyEvent(value ?? false));
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  AppButton(
                                    color: AppColors.btnColor,
                                    splashColor: AppColors.btnColor,
                                    width: MediaQuery.sizeOf(context).width,
                                    shapeBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(53))),
                                    onTap: () {
                                      if (signUpBloc.formKey.currentState!.validate()) {
                                        showCommonSnackbar(context: context, title: "Your account has been created");
                                        NavigatorService.pushNamedAndRemoveUntil(AppRoutes.signInScreen);
                                      }
                                    },
                                    child: Text(AppConstText.lblSignUp.toUpperCase(), style: AppFonts.ralewayBold.copyWith(fontSize: 16, color: AppColors.white)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    Text(AppConstText.lblAlreadyAccount, style: AppFonts.ralewayMedium.copyWith(fontSize: 14, color: AppColors.hintTextColor)),
                    TextButton(
                      onPressed: () {
                        NavigatorService.popAndPushNamed(AppRoutes.signInScreen);
                      },
                      child: Text(AppConstText.lblSignIn, style: AppFonts.ralewayBold.copyWith(fontSize: 14, color: AppColors.primaryTextColor)),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenderOption ({
    required String gender,
    required bool isSelected,
    required VoidCallback onTap,
}){
    return GestureDetector(
      onTap: onTap,
      child:  Container(
        height: 60,
        decoration: BoxDecoration(
          color:isSelected ? AppColors.primaryColor.withValues(alpha: 0.1) :  AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: isSelected ?AppColors.primaryColor : AppColors.normalBorderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              gender,
              style: isSelected ? AppFonts.ralewaySemiBold.copyWith(color: AppColors.primaryTextColor) :AppFonts.ralewayRegular.copyWith(color: AppColors.iconColor)
            ),
            const SizedBox(width: 12),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primaryColor : AppColors.iconColor,
              ),
              child: const Icon(
                Icons.circle,
                color: Colors.white,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
