import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class CustomWellcom extends StatelessWidget {
  const CustomWellcom({super.key});

  @override
  Widget build(BuildContext context) {
    return TitelTextWidget(
      text: "Wellcom Bake!",
      color: AppColors.textblack,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      hight: 1,
    );
  }
}
