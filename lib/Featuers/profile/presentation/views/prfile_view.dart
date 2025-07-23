import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:meal_app/Featuers/auth/presentation/view/sign_up_view.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_button.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_labletex_form.dart';
import 'package:meal_app/Featuers/profile/presentation/views/widgets/contaner_profile.dart';
import 'package:meal_app/Featuers/profile/presentation/views/widgets/custom_appbar_profile.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/const/image_app.dart';

class PrfileView extends StatelessWidget {
  const PrfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,

      body: Padding(
        padding: EdgeInsets.all(size.width * 0.06),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.025),
              CustomAppBarProfile(),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.13,
                      backgroundImage: AssetImage(ImageApp.profile),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: size.width * 0.11, // بدل 40
                        height: size.width * 0.11,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // لون الحد الأبيض
                            width:
                                1.5, // سُمك الحد (تقدر تغير الرقم حسب التصميم)
                          ),
                          color: AppColors
                              .colorcatecorey, // الخلفية زي اللي في الصورة
                          borderRadius: BorderRadius.circular(20), // الحواف
                        ),
                        child: Image.asset(ImageApp.camera, width: 17),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              CustomLabletexform(text: "Full Name"),
              SizedBox(height: size.height * 0.012),
              ContanerProfile(
                text:
                    (user?.displayName != null && user!.displayName!.isNotEmpty)
                    ? user!.displayName!
                    : "No Name",

                // text: user?.displayName ?? "No Name",
                image: ImageApp.person,
              ),

              const SizedBox(height: 24),
              CustomLabletexform(text: "Email"),
              ContanerProfile(
                image: ImageApp.message,
                text: user?.email ?? "reem@gmail.com",
              ),

              SizedBox(height: size.height * 0.1),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                  icon: Icon(Icons.login_rounded, color: Colors.red),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.07,

                  child: CustomButton(
                    vertical: size.height * 0.015,
                    horizontal: size.width * 0.05,

                    text: "Save",
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
