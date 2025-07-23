import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.vertical,
    this.horizontal,
  });
  final String? text;
  final void Function()? onPressed;
  final double? vertical;
  final double? horizontal;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          // vertical: size.height * 0.015,
          // horizontal: size.width * 0.05,
          vertical: vertical ?? size.height * 0.02,
          horizontal: horizontal ?? size.width * 0.30,
        ),
        backgroundColor: AppColors.button,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitelTextWidget(
            text: text ?? " ",
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w600,
            color: AppColors.wightcolor,
          ),
          SizedBox(width: size.width * 0.08),
          Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    );
  }
}
