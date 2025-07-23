import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/auth/presentation/view/login_view.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/accept_timers_widght.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_button.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_dointhaveanaccount.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_labletex_form.dart'
    show CustomLabletexform;
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_signup_header.dart';
import 'package:meal_app/Featuers/auth/presentation/view/widgets/custom_text_form.dart';
import 'package:meal_app/core/const/app_colors.dart';
import 'package:meal_app/core/widgets/navigation_bar.dart/navigation_bar.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late GlobalKey key = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: AppColors.wightcolor,
      body: Padding(
        padding: EdgeInsets.all(width * 0.06),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.01),
                CustomSignUpHeader(),

                SizedBox(height: height * 0.02),
                CustomLabletexform(text: "Name"),
                SizedBox(height: height * 0.005),

                CustomTextForm(
                  hintText: "Enter Name",
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nameController.value;
                  },
                ),

                SizedBox(height: height * 0.02),
                CustomLabletexform(text: "Email"),
                SizedBox(height: height * 0.005),

                CustomTextForm(
                  hintText: "Enter Email",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    emailController.value;
                  },
                ),

                SizedBox(height: height * 0.02),
                CustomLabletexform(text: "Password"),
                SizedBox(height: height * 0.005),

                CustomTextForm(
                  hintText: "Enter Password",
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    passwordController.value;
                  },
                ),

                SizedBox(height: height * 0.02),
                CustomLabletexform(text: "Confirm Password"),
                SizedBox(height: height * 0.005),
                CustomTextForm(
                  hintText: "Retype Password",
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    confirmPasswordController.value;
                  },
                ),
                AcceptTermsWidget(value: true, onChanged: (value) {}),
                SizedBox(height: height * 0.026),
                CustomButton(
                  text: "Sign Up",
                  onPressed: () async {
                    final isValid = (key.currentState as FormState).validate();
                    if (!isValid) return;

                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Navigation()),
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message ?? "Sign up failed")),
                      );
                    }
                  },
                ),
                SizedBox(height: height * 0.16),
                CustomDointhaveanaccount(
                  text: "Already a member?",
                  text2: "Sign In",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginView();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
