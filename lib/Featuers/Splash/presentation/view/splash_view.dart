import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/auth/presentation/view/login_view.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/const/image_app.dart';
import 'package:meal_app/core/widgets/titel_text_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(children: [BackgroundImage(), TopContent(), BottomContent()]),
    );
  }
}

// ✅ خلفية الصورة
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Image.asset(ImageApp.splash1, fit: BoxFit.cover),
    );
  }
}

// ✅ المحتوى العلوي (الصورة الصغيرة + النص العلوي)
class TopContent extends StatelessWidget {
  const TopContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Image.asset(ImageApp.splash2),
            const SizedBox(height: 14),
            TitelTextWidget(
              text: "100K+ Premium Recipe ",
              fontWeight: FontWeight.w600,
              hight: 1.0,
              fontSize: 18,
              color: AppColors.wightcolor,
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ المحتوى السفلي (النصوص + الزر)
class BottomContent extends StatelessWidget {
  const BottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const TitelTextWidget(
              text: "Get\n Cooking",
              fontSize: 50,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              hight: 1.2,
              color: AppColors.wightcolor,
            ),
            const SizedBox(height: 20),
            const TitelTextWidget(
              text: "Simple way to find Tasty RecipeNames",
              color: AppColors.wightcolor,
              textAlign: TextAlign.center,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              hight: 1.0,
            ),
            const SizedBox(height: 64),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 50,
                ),
                backgroundColor: AppColors.button,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginView(), // مؤقتًا، غيّرها بصفحتك لاحقًا
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  TitelTextWidget(
                    text: "Start Cooking",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.wightcolor,
                  ),
                  SizedBox(width: 9),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 95),
          ],
        ),
      ),
    );
  }
}
