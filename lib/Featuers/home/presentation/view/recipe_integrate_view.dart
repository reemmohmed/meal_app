import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/home/data/meal_model.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/const/image_app.dart';
import 'package:meal_app/core/widgets/subtitel_text_widget.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';
import 'package:meal_app/test_anvebar.dart';

class RecipeIntegrateView extends StatelessWidget {
  const RecipeIntegrateView({super.key, required this.mealModel});
  final MealModel mealModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: mealModel.strMealThumb ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,

                      placeholder: (context, url) =>
                          Center(child: const CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ), // Replace with your image asset
                    //   width: double.infinity,
                    //   height: 200,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color(0xBF000000), // أسود بشفافية 75%
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer_sharp,
                          size: 17,
                          color: AppColors.geryw,
                        ),
                        const SizedBox(width: 5),
                        SubtitelTextWidget(
                          text: "20 min ",
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.geryw,
                        ),
                        const SizedBox(width: 10),
                        CustomIconBookMarket(
                          colorIcon: AppColors.colorIcon,
                          background: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 100, 20),
                child: SubtitelTextWidget(
                  text:
                      mealModel.strMeal ??
                      "Spicy chicken burger with French fries",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Divider(),
              const SizedBox(height: 10),
              TitelTextWidget(
                text: "Ingrident",
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ImageApp.splash2,
                    width: 16.31,
                    height: 20.97,
                    color: AppColors.tragrey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "1 serve",
                    style: TextStyle(
                      color: AppColors.tragrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${mealModel.ingredients.length} Items",
                    style: TextStyle(
                      color: AppColors.tragrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mealModel.ingredients.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return CustomCardItem(
                      ingredient: mealModel.ingredients[index],
                      measure: mealModel.measures[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCardItem extends StatelessWidget {
  final String ingredient;
  final String measure;

  const CustomCardItem({
    super.key,
    required this.ingredient,
    required this.measure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.geryw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  ImageApp.splash1,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              SubtitelTextWidget(
                text: ingredient,
                color: const Color(0xff121212),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              const Spacer(),
              SubtitelTextWidget(
                text: measure,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.textcolor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomCardItem extends StatelessWidget {
//   const CustomCardItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         color: AppColors.geryw,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(
//             children: [
//               const SizedBox(width: 10),
//               ClipRRect(
//                 borderRadius: BorderRadiusGeometry.circular(12),

//                 child: Image.asset(
//                   ImageApp.splash1,
//                   width: 52,
//                   height: 52,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               SubtitelTextWidget(
//                 text: "Tomatos",
//                 color: Color(0xff121212),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//               const Spacer(),
//               SubtitelTextWidget(
//                 text: "500g",
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: AppColors.textcolor,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.more_horiz_rounded,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
