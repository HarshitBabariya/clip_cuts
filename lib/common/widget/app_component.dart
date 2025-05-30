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
   Function(String)? onChanged,
   required BuildContext contexts,
   FocusNode? focusNode,
   bool obscureText = false,
   VoidCallback? onIconTap,
}){
   final node = focusNode ?? FocusNode();
    return StatefulBuilder(
      builder: (context, setState) {
        node.addListener(() {
          setState(() {});
        });
        return  TextFormField(
          focusNode: node,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction ?? TextInputAction.next,
      style: AppFonts.ralewaySemiBold.copyWith(color: AppColors.primaryTextColor),
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
        hintStyle: AppFonts.ralewayRegular.copyWith(color: AppColors.iconColor),
        suffixIcon: GestureDetector(
          onTap: onIconTap,
          child: iconName != null
            ? Image.asset(
                iconName,
                width: 25,
                height: 25,
                color: node.hasFocus ? AppColors.primaryColor : AppColors.iconColor,
              )
          :  SizedBox()),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.normalBorderColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(18))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(18))),
      ),
    );}
    );
  }

  static Widget commonBtn({
   required BuildContext context,
   required String btnText,
   Color? bgColor,
   Color? textColor,
    Function? onTap
}){
   return AppButton(
     color: bgColor ?? AppColors.btnColor,
     splashColor: AppColors.btnColor,
     width: MediaQuery.of(context).size.width,
     shapeBorder: const OutlineInputBorder(
       borderRadius: BorderRadius.all(Radius.circular(53)),
     ),
     onTap: onTap,
     child: Text(
       btnText,
       style: AppFonts.ralewayBold.copyWith(
         fontSize: 16,
         color: textColor ?? AppColors.white,
       ),
     ),
   );
  }
}