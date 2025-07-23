import 'package:flutter/material.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/const/image_app.dart';
import 'package:meal_app/core/widgets/subtitel_text_widget.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class CustomHintHome extends StatelessWidget {
  const CustomHintHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitelTextWidget(
              text: "Hello Jega",

              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            SubtitelTextWidget(
              text: "What are you cooking today?",
              fontWeight: FontWeight.w400,
              color: AppColors.textcolor,
              fontSize: 11,
            ),
          ],
        ),

        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xffFFCE80), // الخلفية زي اللي في الصورة
            borderRadius: BorderRadius.circular(12), // الحواف
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              ImageApp.avatar, // المسار حسب مكان صورتك
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
