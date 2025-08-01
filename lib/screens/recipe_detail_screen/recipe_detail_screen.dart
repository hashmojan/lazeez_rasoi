import 'package:flutter/material.dart';
import '../../utills/appcolors/appcolors.dart';
import '../../models/recipe_model.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: recipe.title,
                child: Image.asset(
                  recipe.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: AppColors.primary,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: AppColors.accent, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            recipe.rating.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer, color: AppColors.textLight, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe.time} mins',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.category, color: AppColors.textLight, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        recipe.category,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    recipe.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textDark,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Ingredients'),
                  const SizedBox(height: 8),
                  _buildIngredientsList(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Preparation Steps'),
                  const SizedBox(height: 8),
                  _buildStepsList(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add to favorites functionality
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.favorite_border, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildIngredientsList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.card,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: recipe.ingredients
              .map(
                (ingredient) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          ingredient,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildStepsList() {
    return Column(
      children: recipe.steps
          .map(
            (step) => Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppColors.card,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${recipe.steps.indexOf(step) + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        step,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textDark,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}