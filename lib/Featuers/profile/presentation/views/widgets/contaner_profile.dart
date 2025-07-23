import 'package:flutter/material.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class ContanerProfile extends StatelessWidget {
  const ContanerProfile({super.key, required this.text, required this.image});
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.09,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xffF3F3F3), // لون الحد الأبيض
          width: size.width * 0.003, // سُمك الحد (تقدر تغير الرقم حسب التصميم)
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: size.width * 0.035),
          Image.asset(
            image,
            width: size.width * 0.06, // كان 24
            height: size.width * 0.06,
          ),
          const SizedBox(width: 14),
          TitelTextWidget(
            text: text,
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
