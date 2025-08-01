import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/recipe_model.dart';
import '../recipe_detail_screen/recipe_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Recipe> allRecipes = [];
  List<Recipe> favoriteRecipes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteTitles = prefs.getStringList('favorites') ?? [];

    final String data = await rootBundle.loadString('assets/recipes.json');
    final List decoded = json.decode(data);
    allRecipes = decoded.map((r) => Recipe.fromJson(r)).toList();

    setState(() {
      favoriteRecipes = allRecipes.where((r) => favoriteTitles.contains(r.title)).toList();
      _loading = false;
    });
  }

  Future<void> _removeFromFavorites(String title) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favs = prefs.getStringList('favorites') ?? [];
    favs.remove(title);
    await prefs.setStringList('favorites', favs);
    _loadFavorites(); // Refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : favoriteRecipes.isEmpty
          ? const Center(child: Text("No favorites yet."))
          : ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: Image.asset(recipe.image, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(recipe.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeFromFavorites(recipe.title),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailScreen(recipe: recipe),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
