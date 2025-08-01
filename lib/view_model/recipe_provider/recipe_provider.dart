// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../models/recipe_model.dart';
//
// class RecipeProvider with ChangeNotifier {
//   List<Recipe> _recipes = [];
//   bool _isLoading = true;
//   String _error = '';
//
//   List<Recipe> get recipes => List.unmodifiable(_recipes);
//   bool get isLoading => _isLoading;
//   String get error => _error;
//
//   RecipeProvider() {
//     _loadRecipes();
//   }
//
//   Future<void> _loadRecipes() async {
//     try {
//       final String data = await rootBundle.loadString('assets/recipes.json');
//       final List<dynamic> decoded = json.decode(data);
//
//       _recipes = decoded.map((json) => Recipe.fromJson(json)).toList();
//       _error = '';
//     } catch (e) {
//       _error = 'Failed to load recipes: ${e.toString()}';
//       debugPrint(_error);
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Recipe? getRecipeByTitle(String title) {
//     try {
//       return _recipes.firstWhere((recipe) => recipe.title == title);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   List<Recipe> getRecipesByCategory(String category) {
//     return _recipes.where((recipe) => recipe.category == category).toList();
//   }
//
//   Future<void> refreshRecipes() async {
//     _isLoading = true;
//     notifyListeners();
//     await _loadRecipes();
//   }
// }