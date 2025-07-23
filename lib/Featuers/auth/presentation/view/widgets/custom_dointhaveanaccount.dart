import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class CustomDointhaveanaccount extends StatelessWidget {
  const CustomDointhaveanaccount({
    super.key,
    this.text,
    this.text2,
    this.onTap,
  });
  final String? text;
  final String? text2;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitelTextWidget(
            text: text ?? "",

            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          GestureDetector(
            onTap: onTap,
            child: TitelTextWidget(
              text: text2 ?? "",

              fontSize: 12,
              fontWeight: FontWeight.w500, // Semi Bold

              color: AppColors.textForgetpassword,
            ),
          ),
        ],
      ),
    );
  }
}
