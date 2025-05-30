import 'package:clip_cuts/const/const_app_fonts.dart';
import 'package:clip_cuts/const/const_app_text.dart';
import 'package:clip_cuts/const/const_color.dart';
import 'package:clip_cuts/utils/permission_handle.dart';
import 'package:clip_cuts/views/sign_up/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode mobileFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  bool termsPolicy = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = true;
  String selectedGender = "Male";
  String? imagePath;
  String selectedCountryCode = "+91";
  final ImagePicker _picker = ImagePicker();

  final List<CountryCode> countryList = [
    CountryCode(name: 'India', code: 'IN', dialCode: '+91', phoneValidation: RegExp(r'^[6789]\d{9}$')),
    CountryCode(name: 'United States', code: 'US', dialCode: '+1', phoneValidation: RegExp(r'^\d{10}$')),
    CountryCode(name: 'United Kingdom', code: 'GB', dialCode: '+44', phoneValidation: RegExp(r'^\d{10}$')),
    CountryCode(name: 'Canada', code: 'CA', dialCode: '+1', phoneValidation: RegExp(r'^\d{10}$')),
    CountryCode(name: 'Australia', code: 'AU', dialCode: '+61', phoneValidation: RegExp(r'^\d{9}$')),
    CountryCode(name: 'Germany', code: 'DE', dialCode: '+49', phoneValidation: RegExp(r'^\d{10,11}$')),
    CountryCode(name: 'France', code: 'FR', dialCode: '+33', phoneValidation: RegExp(r'^\d{9}$')),
    CountryCode(name: 'Brazil', code: 'BR', dialCode: '+55', phoneValidation: RegExp(r'^\d{10,11}$')),
    CountryCode(name: 'Russia', code: 'RU', dialCode: '+7', phoneValidation: RegExp(r'^\d{10}$')),
    CountryCode(name: 'Japan', code: 'JP', dialCode: '+81', phoneValidation: RegExp(r'^\d{9}$')),
    CountryCode(name: 'China', code: 'CN', dialCode: '+86', phoneValidation: RegExp(r'^\d{11}$')),
    CountryCode(name: 'South Africa', code: 'ZA', dialCode: '+27', phoneValidation: RegExp(r'^\d{9}$')),
  ];

  SignUpBloc() : super(Init()) {

    // on<PickProfileImageEvent>((event, emit) async {
    //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //   if (pickedFile != null) {
    //     imagePath = pickedFile.path;
    //     emit(Init());
    //   }
    // });

    on<PickProfileImageEvent>((event, emit) async {
      await _showImageSourceDialog(event.context);
    });

    on<PickImageFromCameraEvent>((event, emit) async {
      final PermissionStatus  hasPermission = await getCameraPermission();
      if (hasPermission == PermissionStatus.granted) {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 100,
        );
        if (pickedFile != null) {
          imagePath = pickedFile.path;
          emit(Init());
        }
      } else {
       handleInvalidPermissions(hasPermission);
      }
    });

    on<PickImageFromGalleryEvent>((event, emit) async {
      final PermissionStatus  hasPermission = await getMediaLibraryPermission();
      if (hasPermission == PermissionStatus.granted) {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 100,
        );
        if (pickedFile != null) {
          imagePath = pickedFile.path;
          emit(Init());
        }
      } else {
        handleInvalidPermissions(hasPermission);
      }
    });

    on<TermsPolicyEvent>((event, emit) {
      termsPolicy = event.value;
      emit(Init());
    });

    on<CountryCodeChanged>((event, emit) {
      selectedCountryCode = event.code;
      emit(Init());
    });

    on<SelectGender>((event, emit) {
      selectedGender = event.gender;
      emit(Init());
    });

    on<TogglePasswordVisibilityEvent>((event, emit) {
      isPasswordVisible = event.isPasswordVisible;
      emit(Init());
    });

    on<ToggleConfirmPasswordVisibilityEvent>((event, emit) {
      isConfirmPasswordVisible = event.isConfirmPasswordVisible;
      emit(Init());
    });
  }

  // Show dialog to choose image source
  Future<void> _showImageSourceDialog(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28)),
                    border: Border.all(color: AppColors.normalBorderColor,width: 1)
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppConstText.lblSelectImage,
                  style: AppFonts.ralewayBold.copyWith(fontSize: 18,color: AppColors.primaryTextColor),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageSourceOption(
                      context,
                      icon: Icons.camera_alt,
                      label: AppConstText.lblCamera,
                      onTap: () {
                        Navigator.pop(context);
                        add(PickImageFromCameraEvent());
                      },
                    ),
                    _buildImageSourceOption(
                      context,
                      icon: Icons.photo_library,
                      label: AppConstText.lblGallery,
                      onTap: () {
                        Navigator.pop(context);
                        add(PickImageFromGalleryEvent());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.normalBorderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: AppColors.primaryColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppFonts.ralewayMedium.copyWith(fontSize: 14, color: AppColors.primaryTextColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    mobileController.dispose();
    confirmPasswordController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    mobileFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    return super.close();
  }
}