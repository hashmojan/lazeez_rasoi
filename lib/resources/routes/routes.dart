import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lazeez_rasoi/resources/routes/routes_names.dart';
import 'package:lazeez_rasoi/screens/about_screen/about_screen.dart';
import 'package:lazeez_rasoi/screens/favorites_screen/favorites_screen.dart';
import 'package:lazeez_rasoi/screens/home_screen/home_screen.dart';
import 'package:lazeez_rasoi/screens/recipe_detail_screen/recipe_detail_screen.dart';
import 'package:lazeez_rasoi/screens/recipe_list_screen/recipe_list_screen.dart';

import '../../screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static final List<GetPage> routes = [
  // Auth Routes
  GetPage(name: RouteName.splashScreen, page: () =>  SplashScreen()),
  GetPage(name: RouteName.homePage, page: () =>  HomeScreen()),
  GetPage(name: RouteName.recipeList, page: () =>  RecipeListScreen(category: 'category')),
  // GetPage(name: RouteName.recipeDetail, page: () =>  RecipeDetailScreen()),
    GetPage(name: RouteName.favoritesScreen, page: () =>  FavoritesScreen()),
    GetPage(name: RouteName.aboutPage, page: () =>  AboutScreen()),


  ];
}