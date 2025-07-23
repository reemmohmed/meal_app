import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class CustomHellow extends StatelessWidget {
  const CustomHellow({super.key});

  @override
  Widget build(BuildContext context) {
    return TitelTextWidget(
      text: "Hello,",
      color: AppColors.textblack,
      fontWeight: FontWeight.w600,
      fontSize: 30,
      hight: 1.0,
    );
  }
}
