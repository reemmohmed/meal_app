import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/Featuers/Splash/presentation/view/splash_view.dart';
import 'package:meal_app/Featuers/home/provider/home_provider.dart';
import 'package:meal_app/core/servers/api_servers.dart';
import 'package:meal_app/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaelApp());
}

class MaelApp extends StatelessWidget {
  const MaelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return HomeProvider(ApiService(Dio()))..fetchAllMeals();
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,

        home: SplashView(),
      ),
    );
  }
}
