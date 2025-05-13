// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_generator/views/Favorites%20Screen.dart';

import '../controllers/recipe-controller.dart';
import '../widgets/Recipe Card.dart';
import '../widgets/Search Bar.dart';
import 'Recipe Detail Screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Recipe Generator',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                );
              },
              icon: Icon(Icons.favorite_border),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const RecipeSearchBar(),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (recipeController.filteredRecipes.isEmpty) {
                return Center(
                  child: Text(
                    'No recipes found',
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
                itemCount: recipeController.filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipeController.filteredRecipes[index];
                  return RecipeCard(
                    recipe: recipe,
                    onTap:
                        () => Get.to(() => RecipeDetailScreen(recipe: recipe)),
                    onFavoriteToggle:
                        () => recipeController.toggleFavorite(recipe.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
