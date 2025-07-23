import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/home/data/meal_model.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/subtitel_text_widget.dart';
import 'package:meal_app/test_anvebar.dart';

class ItemMealCard extends StatelessWidget {
  const ItemMealCard({
    super.key,
    required this.time,
    required this.mealModel,
    this.onpressed,
  });

  final String time;
  final MealModel mealModel;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.gerycolor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.fromLTRB(12, 50, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30), // مساحة للصورة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SubtitelTextWidget(
                  text: mealModel.strMeal ?? "No name",

                  fontWeight: FontWeight.bold,

                  fontSize: 14,
                  color: Color(0xff484748),
                ),
              ),
              const SizedBox(height: 20),
              SubtitelTextWidget(
                text: "time",
                color: AppColors.tragrey,
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(time, style: TextStyle(color: Colors.grey[600])),
                  GestureDetector(
                    onTap: onpressed,
                    child: CustomIconBookMarket(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -6,
          left: 25,
          right: 25,

          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: mealModel.strMealThumb ?? '',
                fit: BoxFit.cover,
                width: 120,
                height: 120,
                placeholder: (context, url) =>
                    Center(child: const CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
