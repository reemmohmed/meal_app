import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/home/presentation/view/home_view.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/subtitel_text_widget.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';
import 'package:meal_app/test_anvebar.dart';

class SavedItem extends StatelessWidget {
  const SavedItem({super.key, required this.titel, required this.image});
  final String titel;
  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05), // حوالي 20 إذا العرض 400
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(size.width * 0.03),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: size.height * 0.25, // مثلاً 200 إذا الارتفاع 800
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [const Color(0xBF000000), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.025, // حوالي 20
            right: size.width * 0.025,
            child: Row(
              children: [
                const Icon(Icons.timer_sharp, size: 17, color: AppColors.geryw),
                SizedBox(width: size.width * 0.015),
                SubtitelTextWidget(
                  text: "20 min ",
                  fontSize: size.width * 0.028,
                  fontWeight: FontWeight.w400,
                  color: AppColors.geryw,
                ),
                SizedBox(width: size.width * 0.025),
                CustomIconBookMarket(
                  colorIcon: AppColors.colorIcon,
                  background: Colors.white,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: size.height * 0.05,
            left: size.width * 0.025,
            right: size.width * 0.025,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.025,
                right: size.width * 0.25, // بديل لـ 105
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: size.width * 0.22,
                    ), // بديل لـ 90
                    child: TitelTextWidget(
                      text: titel,
                      color: AppColors.white,
                      fontSize: size.width * 0.035,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SubtitelTextWidget(
                    text: "By Chef John",
                    color: AppColors.tragrey,
                    fontWeight: FontWeight.w400,
                    fontSize: size.width * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
