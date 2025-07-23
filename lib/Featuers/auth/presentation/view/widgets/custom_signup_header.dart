import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/subtitel_text_widget.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class CustomSignUpHeader extends StatelessWidget {
  const CustomSignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitelTextWidget(
          text: "Create an account",
          color: AppColors.textblack,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 6, 150, 20),
          child: SubtitelTextWidget(
            text: "Let’s help you set up your account, it won’t take long.",

            fontWeight: FontWeight.w400,
            color: AppColors.textfeledColor,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
