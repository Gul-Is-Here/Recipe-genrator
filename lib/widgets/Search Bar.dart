import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/recipe-controller.dart';

class RecipeSearchBar extends StatelessWidget {
  const RecipeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) {
          recipeController.searchQuery.value = value;
          recipeController.filterRecipes();
        },
        decoration: InputDecoration(
          hintText: 'Search recipes or ingredients...',
          hintStyle: GoogleFonts.poppins(),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        ),
        style: GoogleFonts.poppins(),
      ),
    );
  }
}