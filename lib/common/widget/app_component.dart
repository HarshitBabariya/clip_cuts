import 'package:flutter/Material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/const_app_fonts.dart';
import '../../const/const_color.dart';

class AppComponent{

 static Widget commonTextField({
   required TextEditingController controller,
   required String hintText,
   required TextFieldType textFieldType,
   String? iconName,
   IconData? icon,
   TextInputType? keyboardType,
    TextInputAction? textInputAction,
   String? Function(String?)? validator,
   Function(String)? onChanged
}){
    return AppTextField(
      controller: controller,
      keyboardType: keyboardType,
      textFieldType: textFieldType,
      textInputAction: textInputAction ?? TextInputAction.next,
      textStyle: AppFonts.ralewaySemiBold.copyWith(color: AppColors.primaryTextColor),
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return AppColors.primaryColor.withValues(alpha: 0.1);
          }
          return AppColors.white;
        }),
        focusColor: AppColors.primaryColor.withValues(alpha: 0.1),
        hintText: hintText,
        hintStyle: AppFonts.ralewayRegular.copyWith(color:  WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return AppColors.primaryColor;
          }
          return AppColors.iconColor;
        })),
        suffixIcon: Image.asset(iconName ?? "", width: 25, height: 25,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Icon(icon ?? Icons.notes, size: 25, color: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return AppColors.primaryColor;
              }
              return AppColors.iconColor;
            }));
          }),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.normalBorderColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(18))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(18))),
      ),
    );
  }
}