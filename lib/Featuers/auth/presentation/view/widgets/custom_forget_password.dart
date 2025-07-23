import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class CustomForgetPassword extends StatelessWidget {
  const CustomForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TitelTextWidget(
        text: "Forgot Password?",
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textForgetpassword,
      ),
    );
  }
}
