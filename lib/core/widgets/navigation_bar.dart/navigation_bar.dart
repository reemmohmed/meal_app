import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:meal_app/Featuers/Notification/presentation/views/notification_view.dart';
import 'package:meal_app/Featuers/book_market/presentation/views/book_market_view.dart';
import 'package:meal_app/Featuers/home/presentation/view/home_view.dart';
import 'package:meal_app/Featuers/profile/presentation/views/prfile_view.dart';
import 'package:meal_app/core/const/app_colors.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<Navigation> {
  int selectedIndex = 0;
  late PageController controller;

  final List<Widget> screenPage = const [
    HomeView(),
    BookMarketView(),
    NotificationView(),
    PrfileView(),
  ];

  @override
  void initState() {
    controller = PageController(initialPage: selectedIndex);
    super.initState();
  }

  void onTabTapped(int index) {
    controller.jumpToPage(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(), // تعطيل السحب باليد
        children: screenPage,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 10,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Ionicons.home_sharp,
                  color: selectedIndex == 0 ? Colors.green : Colors.grey,
                ),
                onPressed: () => onTabTapped(0),
              ),
              IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: selectedIndex == 1 ? Colors.green : Colors.grey,
                ),
                onPressed: () => onTabTapped(1),
              ),
              const SizedBox(width: 40), // مكان الزر العائم
              IconButton(
                icon: Icon(
                  Ionicons.notifications,
                  color: selectedIndex == 2 ? Colors.green : Colors.grey,
                ),
                onPressed: () => onTabTapped(2),
              ),
              IconButton(
                icon: Icon(
                  Ionicons.person,
                  color: selectedIndex == 3 ? Colors.green : Colors.grey,
                ),
                onPressed: () => onTabTapped(3),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: FloatingActionButton(
          onPressed: () {
            // زر الإضافة (يمكنك ربطه بصفحة جديدة أو showModalBottomSheet)
          },
          backgroundColor: AppColors.button,
          child: Icon(Ionicons.add, color: Colors.white),
        ),
      ),
    );
  }
}
