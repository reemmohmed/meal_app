import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/home/data/meal_model.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/subtitel_text_widget.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,

    required this.selected,
    required this.mealModel,
  });

  final bool selected;
  final MealModel mealModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: selected
          ? BoxDecoration(
              color: AppColors.colorcatecorey,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green),
            )
          : null,
      child: Align(
        alignment: Alignment.center,
        child: SubtitelTextWidget(
          text: mealModel.strArea ?? "",
          color: selected ? Colors.white : AppColors.colorNoselect,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}
