import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText,
    this.validator,

    this.onChanged,
    this.onFieldSubmitted,
  });
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onFieldSubmitted;

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,

      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        hintText: hintText ?? "",
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.w400,

          color: AppColors.gerycolor,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
