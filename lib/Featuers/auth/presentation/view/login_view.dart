import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/auth/presentation/view/sign_up_view.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_button.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_dointhaveanaccount.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_forget_password.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_hellow.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_labletex_form.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_text_form.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_wellcom.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/navigation_bar.dart/navigation_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late GlobalKey<FormState> key;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    key = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.wightcolor,
      body: Padding(
        padding: EdgeInsets.all(width * 0.06),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.12),
                CustomHellow(),

                const SizedBox(height: 15),
                CustomWellcom(),
                SizedBox(height: height * 0.07),

                // Password Field
                CustomLabletexform(text: "Email"),
                SizedBox(height: height * 0.01),
                CustomTextForm(
                  hintText: "Enter Email",
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Email can't be empty";
                    if (!value.contains('@')) return "Enter valid email";
                    return null;
                  },
                  controller: emailController,
                ),
                SizedBox(height: height * 0.04),

                CustomLabletexform(text: "Enter Password"),
                SizedBox(height: height * 0.01),
                CustomTextForm(
                  hintText: "Enter password",
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.025),
                CustomForgetPassword(),
                SizedBox(height: height * 0.04),
                // Sign In Button
                Center(
                  child: CustomButton(
                    text: "Sign In",
                    onPressed: () async {
                      final isValid = key.currentState!.validate();
                      if (!isValid) return;

                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                        // Navigate to main app
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Navigation()),
                        );
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message ?? "Login failed")),
                        );
                      }
                    },
                  ),
                ),
                // Sign Up Text
                SizedBox(height: height * 0.25),
                CustomDointhaveanaccount(
                  text: "Don’t have an account? ",
                  text2: "Sign up",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpView();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
