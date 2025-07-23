import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class CustomLabletexform extends StatelessWidget {
  const CustomLabletexform({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return TitelTextWidget(
      text: text ?? "",
      color: AppColors.textfeledColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }
}
