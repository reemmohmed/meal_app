import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:meal_app/Featuers/book_market/data/book_marked_meal.dart';
import 'package:meal_app/Featuers/home/data/meal_model.dart';
import 'package:meal_app/Featuers/home/presentation/view/recipe_integrate_view.dart';
import 'package:meal_app/Featuers/home/provider/home_provider.dart';
import 'package:meal_app/core/const/app_colors.dart';

import 'package:meal_app/test_anvebar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _scrollController;

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
                                      childAspectRatio: 0.76,
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
