import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:meal_app/Featuers/book_market/data/book_marked_meal.dart';
import 'package:meal_app/Featuers/home/data/meal_model.dart';
import 'package:meal_app/Featuers/home/presentation/view/recipe_integrate_view.dart';
import 'package:meal_app/Featuers/home/provider/home_provider.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/const/image_app.dart';
import 'package:meal_app/core/widgets/subtitel_text_widget.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';
import 'package:provider/provider.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({super.key});

  @override
  State<HomeView2> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView2> {
  late ScrollController _scrollController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Scroll Controller for pagination
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          Provider.of<HomeProvider>(context, listen: false).loadMoreMeals();
        }
      });

    // تأكد إن الفيتش يتعمل بعد البناء
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      provider.fetchAreas(); // لتحميل المناطق أولًا
      provider.fetchAllMeals(); // تحميل الوجبات
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    final areas = provider.areas;
    final selectedArea = provider.selectedArea;
    final meals = provider.filteredMeals;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomHintHome(),
              const SizedBox(height: 30),

              // مربع البحث
              TextField(
                onChanged: (value) {
                  provider.updateSearchQuery(value);
                },
                decoration: InputDecoration(
                  hintText: "Search recipe",
                  hintStyle: TextStyle(
                    color: AppColors.gerycolor,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(Ionicons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ✅ التابز (Areas)
              if (areas.isNotEmpty)
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: areas.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final area = areas[index];
                      final isSelected = area == selectedArea;
                      return GestureDetector(
                        onTap: () {
                          provider.changeSelectedArea(area);
                        },
                        child: CategoryChip(
                          selected: isSelected,
                          mealModel: MealModel(
                            strArea: area,
                            ingredients: [],
                            measures: [],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 20),

              // ✅ الوجبات + pagination
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification.metrics.pixels >=
                                  scrollNotification.metrics.maxScrollExtent -
                                      200 &&
                              provider.hasMore &&
                              !provider.isLoadMore) {
                            provider.loadMoreMeals();
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                // controller: _scrollController,
                                shrinkWrap: true,
                                itemCount:
                                    meals.length +
                                    (provider.isLoadMore ? 1 : 0),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.70,
                                      crossAxisSpacing: 19,
                                      mainAxisSpacing: 20,
                                    ),
                                itemBuilder: (context, index) {
                                  if (index < meals.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return RecipeIntegrateView(
                                                mealModel: meals[index],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: ItemMealCard(
                                        onpressed: () {
                                          final mealToSave = BookmarkedMeal(
                                            id: meals[index].idMeal ?? '',
                                            name: meals[index].strMeal ?? '',
                                            image:
                                                meals[index].strMealThumb ?? '',
                                          );

                                          Provider.of<HomeProvider>(
                                            context,
                                            listen: false,
                                          ).saveMealLocally(mealToSave);

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Meal saved successfully!',
                                              ),
                                            ),
                                          );
                                        },

                                        mealModel: meals[index],
                                        time: "15 Mins",
                                      ),
                                    );
                                  }
                                  // else {
                                  //   return const Padding(
                                  //     padding: EdgeInsets.symmetric(
                                  //       vertical: 100,
                                  //     ),
                                  //     child: Center(
                                  //       child: CircularProgressIndicator(),
                                  //     ),
                                  //   );
                                  // }
                                },
                              ),
                              if (provider.isLoadMore)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 100),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<HomeProvider>(context);
//     // if (provider.isLoading) {
//     //   return const Center(child: Center(child: CircularProgressIndicator()));
//     // }

//     final areas = provider.areas;
//     final selectedArea = provider.selectedArea;
//     List<MealModel> meals = provider.filteredMeals;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),

//             // العنوان
//             CustomHintHome(),

//             const SizedBox(height: 30),

//             // مربع البحث
//             TextField(
//               onChanged: (value) {
//                 provider.searchMeals(value);
//               },
//               decoration: InputDecoration(
//                 hintText: "Search recipe",
//                 hintStyle: TextStyle(
//                   color: AppColors.gerycolor,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 prefixIcon: const Icon(Ionicons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 25),

//             // التابز
//             SizedBox(
//               height: 50,
//               child: ListView.builder(
//                 itemCount: areas.length,

//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   final area = areas[index];
//                   final isSelected = area == selectedArea;
//                   return GestureDetector(
//                     onTap: () {
//                       provider.changeSelectedArea(area);
//                     },
//                     child: CategoryChip(
//                       selected: isSelected,
//                       mealModel: MealModel(
//                         strArea: area,
//                         ingredients: [],
//                         measures: [],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 20),

//             // الوجبات
//             Expanded(
//               child: GridView.builder(
//                 itemCount: meals.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.70,
//                   crossAxisSpacing: 19,
//                   mainAxisSpacing: 20,
//                 ),
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return RecipeIntegrateView();
//                           },
//                         ),
//                       );
//                     },
//                     child: ItemMealCard(
//                       mealModel: meals[index],

//                       time: "15 Mins",
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.textForgetpassword,
          backgroundImage: AssetImage(ImageApp.avatar), // بدّل الصورة حسب ملفك
        ),
      ],
    );
  }
}

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
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: selected
          ? BoxDecoration(
              color: AppColors.colorcatecorey,
              borderRadius: BorderRadius.circular(20),
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
