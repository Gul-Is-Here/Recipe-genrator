import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart'; // Import share_plus

import '../controllers/recipe-controller.dart';
import '../model/recipe_model.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();

    // Function to share recipe via share_plus
    void _shareRecipe(BuildContext context) {
      final shareText = '''
✨ ${recipe.title} ✨

🍽️ Category: ${recipe.category}
⏱️ Prep Time: ${recipe.preparationTime} minutes

📝 Ingredients:
${recipe.ingredients.map((item) => '• $item').join('\n')}

📋 Instructions:
${recipe.instructions}

Bon Appétit! 🍴
''';

      // Using Share.share from share_plus
      Share.share(shareText, subject: '${recipe.title} Recipe');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Get.back();
              recipeController.deleteRecipeWithUndo(recipe.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.timer, '${recipe.preparationTime} mins'),
            _buildInfoRow(Icons.category, recipe.category),
            if (recipe.dietaryTags.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: recipe.dietaryTags.map((tag) => Chip(
                  label: Text(tag),
                  backgroundColor: Get.theme.colorScheme.secondary.withOpacity(0.2),
                )).toList(),
              ),
            ],
            const SizedBox(height: 20),
            Text(
              'Ingredients',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...recipe.ingredients.map((ingredient) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                '• $ingredient',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            )),
            const SizedBox(height: 20),
            Text(
              'Instructions',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              recipe.instructions,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
