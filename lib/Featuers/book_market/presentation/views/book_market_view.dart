import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/book_market/presentation/views/widgets/saved_item.dart';
import 'package:meal_app/Featuers/home/provider/home_provider.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';
import 'package:provider/provider.dart';

class BookMarketView extends StatelessWidget {
  const BookMarketView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.loadSavedMeals();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TitelTextWidget(
          text: "Saved recipes",
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.textfeledColor,
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          final savedMeals = provider.savedMeals;

          if (savedMeals.isEmpty) {
            return const Center(child: Text("No saved recipes."));
          }

          return ListView.builder(
            itemCount: savedMeals.length,
            itemBuilder: (context, index) {
              final meal = savedMeals[index];
              return SavedItem(
                image: meal.image,
                titel: meal.name,

                // image: meal.image,
              );
            },
          );
        },
      ),
    );
  }
}
