import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/recipe-controller.dart';
import '../widgets/Recipe Card.dart';
import 'Recipe Detail Screen.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Recipes',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (recipeController.favoriteRecipes.isEmpty) {
          return Center(
            child: Text(
              'No favorite recipes yet',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: recipeController.favoriteRecipes.length,
          itemBuilder: (context, index) {
            final recipe = recipeController.favoriteRecipes[index];
            return RecipeCard(
              recipe: recipe,
              onTap: () => Get.to(() => RecipeDetailScreen(recipe: recipe)),
              onFavoriteToggle: () =>
                  recipeController.toggleFavorite(recipe.id),
            );
          },
        );
      }),
    );
  }
}