// ingredient_suggestion_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/recipe-controller.dart';
import '../widgets/Recipe Card.dart';
import 'Recipe Detail Screen.dart';

class IngredientSuggestionScreen extends StatefulWidget {
  const IngredientSuggestionScreen({super.key});

  @override
  State<IngredientSuggestionScreen> createState() => _IngredientSuggestionScreenState();
}

class _IngredientSuggestionScreenState extends State<IngredientSuggestionScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _enteredIngredients = [];

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Recipes by Ingredients',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientController,
                    decoration: InputDecoration(
                      labelText: 'Add an ingredient',
                      labelStyle: GoogleFonts.poppins(),
                    ),
                    style: GoogleFonts.poppins(),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        setState(() {
                          _enteredIngredients.add(value.trim());
                          _ingredientController.clear();
                        });
                        recipeController.findRecipesByIngredients(_enteredIngredients);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_ingredientController.text.trim().isNotEmpty) {
                      setState(() {
                        _enteredIngredients.add(_ingredientController.text.trim());
                        _ingredientController.clear();
                      });
                      recipeController.findRecipesByIngredients(_enteredIngredients);
                    }
                  },
                ),
              ],
            ),
          ),
          if (_enteredIngredients.isNotEmpty)
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _enteredIngredients.length,
                itemBuilder: (context, index) {
                  return Chip(
                    label: Text(_enteredIngredients[index]),
                    onDeleted: () {
                      setState(() {
                        _enteredIngredients.removeAt(index);
                      });
                      recipeController.findRecipesByIngredients(_enteredIngredients);
                    },
                  );
                },
              ),
            ),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (recipeController.filteredRecipes.isEmpty) {
                return Center(
                  child: Text(
                    _enteredIngredients.isEmpty
                        ? 'Add ingredients to find matching recipes'
                        : 'No recipes found with these ingredients',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                itemCount: recipeController.filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipeController.filteredRecipes[index];
                  return RecipeCard(
                    recipe: recipe,
                    onTap: () => Get.to(() => RecipeDetailScreen(recipe: recipe)),
                    onFavoriteToggle: () =>
                        recipeController.toggleFavorite(recipe.id),
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