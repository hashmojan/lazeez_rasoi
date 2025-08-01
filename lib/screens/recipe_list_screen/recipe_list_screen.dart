import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utills/appcolors/appcolors.dart';
import '../../models/recipe_model.dart';
import '../recipe_detail_screen/recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  final String category;

  const RecipeListScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  List<Recipe> _filteredRecipes = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecipes();
    _searchController.addListener(_filterRecipes);
  }

  Future<void> _loadRecipes() async {
    try {
      final String data = await rootBundle.loadString('assets/recipes/recipes.json');
      final List<dynamic> jsonResult = json.decode(data);
      final List<Recipe> allRecipes = jsonResult.map((json) => Recipe.fromJson(json)).toList();

      setState(() {
        _recipes = allRecipes.where((r) => r.category.toLowerCase() == widget.category.toLowerCase()).toList();
        _filteredRecipes = _recipes; // Initialize filtered recipes with all recipes
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading recipes: $e');
      // Optionally show an error message to the user
    }
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecipes = _recipes.where((recipe) {
        return recipe.title.toLowerCase().contains(query) ||
            recipe.description.toLowerCase().contains(query) ||
            recipe.ingredients.join(' ').toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.card,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeDetailScreen(recipe: recipe),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    recipe.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: AppColors.categoryChip,
                        child: Icon(Icons.fastfood, color: AppColors.textLight),
                      );
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        recipe.description,
                        style: TextStyle(
                          color: AppColors.textLight,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 16,
                            color: AppColors.textLight,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${recipe.time} mins',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: AppColors.accent,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${recipe.rating}',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textLight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      backgroundColor: AppColors.background,
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.card,
                hintText: 'Search ${widget.category} recipes...',
                prefixIcon: Icon(Icons.search, color: AppColors.textLight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              style: TextStyle(color: AppColors.textDark),
            ),
          ),
          Expanded(
            child: _filteredRecipes.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: AppColors.textLight,
                  ),
                  SizedBox(height: 16),
                  Text(
                    _searchController.text.isEmpty
                        ? "No recipes available in ${widget.category}"
                        : "No recipes found for '${_searchController.text}'",
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (_searchController.text.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        _searchController.clear();
                        _filterRecipes();
                      },
                      child: Text(
                        'Clear search',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = _filteredRecipes[index];
                return _buildRecipeCard(recipe);
              },
            ),
          ),
        ],
      ),
    );
  }
}