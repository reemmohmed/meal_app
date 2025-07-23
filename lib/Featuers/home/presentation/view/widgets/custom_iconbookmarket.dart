import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';

class CustomIconBookMarket extends StatelessWidget {
  const CustomIconBookMarket({super.key, this.colorIcon, this.background});
  final Color? colorIcon;
  final Color? background;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: background ?? AppColors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.bookmark_border,
        size: 24,
        color: colorIcon ?? Color(0xff71B1A1),
      ),
    );
  }
}
