import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lazeez_rasoi/resources/routes/routes.dart';
import 'package:lazeez_rasoi/resources/routes/routes_names.dart';
import 'package:lazeez_rasoi/utills/appcolors/appcolors.dart';

void main() {
  runApp(
   LazeezRasoiApp()
  );
}

class LazeezRasoiApp extends StatelessWidget {
  const LazeezRasoiApp({Key? key}) : super(key: key); // Add const constructor

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lazeez Rasoi',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: RouteName.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}
