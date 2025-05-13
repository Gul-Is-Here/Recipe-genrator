import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/recipe_model.dart';

class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var filteredRecipes = <Recipe>[].obs;
  var favoriteRecipes = <Recipe>[].obs;
  var selectedCategory = 'All'.obs;
  var searchQuery = ''.obs;
  var selectedDietaryTags = <String>[].obs;
  var recentlyDeletedRecipe = Rxn<Recipe>();

  @override
  void onInit() {
    super.onInit();
    loadSampleRecipes();
  }

  void loadSampleRecipes() {
    recipes.addAll([
      // Desi Recipes
      Recipe(
        id: '1',
        title: 'Chicken Karahi',
        ingredients: [
          'Chicken',
          'Tomatoes',
          'Ginger',
          'Garlic',
          'Green chilies',
          'Coriander',
        ],
        instructions:
            '1. Cook chicken with spices\n2. Add tomatoes and cook\n3. Garnish with fresh coriander',
        preparationTime: 50,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '2',
        title: 'Biryani',
        ingredients: [
          'Rice',
          'Chicken',
          'Yogurt',
          'Biryani spices',
          'Mint',
          'Fried onions',
        ],
        instructions:
            '1. Marinate chicken\n2. Cook rice\n3. Layer chicken and rice together and cook',
        preparationTime: 60,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '3',
        title: 'Aloo Keema',
        ingredients: [
          'Minced meat',
          'Potatoes',
          'Onions',
          'Tomatoes',
          'Ginger',
          'Garlic',
        ],
        instructions:
            '1. Cook minced meat\n2. Add potatoes and cook together\n3. Garnish with coriander',
        preparationTime: 40,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '4',
        title: 'Samosas',
        ingredients: ['Flour', 'Potatoes', 'Peas', 'Spices', 'Oil'],
        instructions:
            '1. Prepare the filling\n2. Fold into samosas and fry until crispy',
        preparationTime: 30,
        category: 'Snack',
        dietaryTags: ['Vegetarian'],
      ),
      Recipe(
        id: '5',
        title: 'Palak Paneer',
        ingredients: ['Spinach', 'Paneer', 'Onions', 'Garlic', 'Ginger'],
        instructions:
            '1. Cook spinach and blend\n2. Cook paneer with spinach mixture\n3. Garnish with cream',
        preparationTime: 30,
        category: 'Vegetarian',
        dietaryTags: ['Vegetarian', 'Dairy'],
      ),
      // Chinese Recipes
      Recipe(
        id: '6',
        title: 'Chicken Fried Rice',
        ingredients: ['Rice', 'Chicken', 'Vegetables', 'Soy sauce', 'Eggs'],
        instructions:
            '1. Cook rice\n2. Stir-fry chicken and vegetables\n3. Combine with rice and soy sauce',
        preparationTime: 25,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '7',
        title: 'Kung Pao Chicken',
        ingredients: [
          'Chicken',
          'Peanuts',
          'Chili peppers',
          'Soy sauce',
          'Rice vinegar',
        ],
        instructions:
            '1. Marinate chicken\n2. Stir-fry with peanuts and chili peppers\n3. Add soy sauce mixture',
        preparationTime: 30,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '8',
        title: 'Sweet and Sour Chicken',
        ingredients: [
          'Chicken',
          'Pineapple',
          'Bell peppers',
          'Vinegar',
          'Sugar',
        ],
        instructions:
            '1. Stir-fry chicken\n2. Add bell peppers, pineapple, and sauce\n3. Serve hot',
        preparationTime: 35,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '9',
        title: 'Spring Rolls',
        ingredients: [
          'Spring roll wrappers',
          'Cabbage',
          'Carrots',
          'Tofu',
          'Soy sauce',
        ],
        instructions:
            '1. Fill spring rolls with vegetables and tofu\n2. Fry until crispy',
        preparationTime: 20,
        category: 'Snack',
        dietaryTags: ['Vegetarian', 'Vegan'],
      ),
      Recipe(
        id: '10',
        title: 'Mapo Tofu',
        ingredients: [
          'Tofu',
          'Ground pork',
          'Chili paste',
          'Soy sauce',
          'Garlic',
        ],
        instructions:
            '1. Stir-fry ground pork and garlic\n2. Add tofu and chili paste\n3. Cook until flavors combine',
        preparationTime: 25,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      // International Recipes
      Recipe(
        id: '11',
        title: 'Spaghetti Bolognese',
        ingredients: [
          'Spaghetti',
          'Ground beef',
          'Tomatoes',
          'Onions',
          'Garlic',
        ],
        instructions:
            '1. Cook spaghetti\n2. Make the sauce with ground beef and tomatoes\n3. Combine with pasta',
        preparationTime: 45,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '12',
        title: 'Caesar Salad',
        ingredients: [
          'Lettuce',
          'Croutons',
          'Parmesan cheese',
          'Caesar dressing',
        ],
        instructions:
            '1. Toss lettuce with dressing\n2. Add croutons and cheese\n3. Serve chilled',
        preparationTime: 10,
        category: 'Salad',
        dietaryTags: ['Vegetarian'],
      ),
      // Additional recipes...
      Recipe(
        id: '13',
        title: 'Chicken Shawarma',
        ingredients: ['Chicken', 'Garlic', 'Yogurt', 'Cumin', 'Paprika'],
        instructions:
            '1. Marinate chicken with spices\n2. Cook and serve in pita bread',
        preparationTime: 40,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '14',
        title: 'Peking Duck',
        ingredients: ['Duck', 'Hoisin sauce', 'Ginger', 'Garlic', 'Scallions'],
        instructions:
            '1. Roast the duck\n2. Serve with hoisin sauce and pancakes',
        preparationTime: 120,
        category: 'Dinner',
        dietaryTags: ['Non-Vegetarian'],
      ),
      Recipe(
        id: '15',
        title: 'Chow Mein',
        ingredients: ['Noodles', 'Vegetables', 'Soy sauce', 'Sesame oil'],
        instructions:
            '1. Stir-fry vegetables\n2. Add noodles and soy sauce\n3. Cook until crispy',
        preparationTime: 20,
        category: 'Dinner',
        dietaryTags: ['Vegetarian'],
      ),
    ]);
    filteredRecipes.assignAll(recipes);
  }

  // void loadSampleRecipes() {
  //   recipes.addAll([
  //     Recipe(
  //       id: '1',
  //       title: 'Vegetable Pasta',
  //       ingredients: ['Pasta', 'Tomatoes', 'Bell peppers', 'Olive oil', 'Garlic'],
  //       instructions: '1. Boil pasta\n2. Sauté vegetables\n3. Mix together',
  //       preparationTime: 20,
  //       category: 'Dinner',
  //       dietaryTags: ['Vegetarian'],
  //     ),
  //     Recipe(
  //       id: '2',
  //       title: 'Avocado Toast',
  //       ingredients: ['Bread', 'Avocado', 'Lemon juice', 'Salt', 'Pepper'],
  //       instructions: '1. Toast bread\n2. Mash avocado\n3. Spread and season',
  //       preparationTime: 5,
  //       category: 'Breakfast',
  //       dietaryTags: ['Vegetarian', 'Vegan', 'Dairy-Free'],
  //     ),
  //     Recipe(
  //       id: '3',
  //       title: 'Chocolate Cake',
  //       ingredients: ['Flour', 'Sugar', 'Cocoa powder', 'Eggs', 'Milk'],
  //       instructions: '1. Mix dry ingredients\n2. Add wet ingredients\n3. Bake at 350°F',
  //       preparationTime: 45,
  //       category: 'Dessert',
  //     ),
  //   ]);
  //   filteredRecipes.assignAll(recipes);
  // }

  void filterRecipes() {
    if (searchQuery.value.isEmpty &&
        selectedCategory.value == 'All' &&
        selectedDietaryTags.isEmpty) {
      filteredRecipes.assignAll(recipes);
    } else {
      filteredRecipes.assignAll(
        recipes.where((recipe) {
          final matchesSearch =
              recipe.title.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              recipe.ingredients.any(
                (ingredient) => ingredient.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ),
              );

          final matchesCategory =
              selectedCategory.value == 'All' ||
              recipe.category == selectedCategory.value;

          final matchesDietary =
              selectedDietaryTags.isEmpty ||
              selectedDietaryTags.every(
                (tag) => recipe.dietaryTags.contains(tag),
              );

          return matchesSearch && matchesCategory && matchesDietary;
        }),
      );
    }
  }

  void toggleDietaryTag(String tag) {
    if (selectedDietaryTags.contains(tag)) {
      selectedDietaryTags.remove(tag);
    } else {
      selectedDietaryTags.add(tag);
    }
    filterRecipes();
  }

  void toggleFavorite(String recipeId) {
    final index = recipes.indexWhere((recipe) => recipe.id == recipeId);
    if (index != -1) {
      recipes[index].isFavorite = !recipes[index].isFavorite;
      if (recipes[index].isFavorite) {
        favoriteRecipes.add(recipes[index]);
      } else {
        favoriteRecipes.removeWhere((recipe) => recipe.id == recipeId);
      }
      recipes.refresh();
      filteredRecipes.refresh();
    }
  }

  void addRecipe(Recipe newRecipe) {
    recipes.add(newRecipe);
    if (newRecipe.isFavorite) {
      favoriteRecipes.add(newRecipe);
    }
    Get.snackbar(
      'Success',
      'Recipe added successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    filterRecipes();
  }

  void updateRecipe(Recipe updatedRecipe) {
    final index = recipes.indexWhere((recipe) => recipe.id == updatedRecipe.id);
    if (index != -1) {
      recipes[index] = updatedRecipe;
      if (updatedRecipe.isFavorite) {
        favoriteRecipes.add(updatedRecipe);
      } else {
        favoriteRecipes.removeWhere((recipe) => recipe.id == updatedRecipe.id);
      }
      filterRecipes();
    }
  }

  void deleteRecipe(String recipeId) {
    recipes.removeWhere((recipe) => recipe.id == recipeId);
    favoriteRecipes.removeWhere((recipe) => recipe.id == recipeId);
    filterRecipes();
  }

  void deleteRecipeWithUndo(String recipeId) {
    final recipe = recipes.firstWhere((r) => r.id == recipeId);
    recentlyDeletedRecipe.value = recipe;
    deleteRecipe(recipeId);
    Get.snackbar(
      'Recipe Deleted',
      '${recipe.title} has been deleted',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      mainButton: TextButton(
        onPressed: () {
          if (recentlyDeletedRecipe.value != null) {
            addRecipe(recentlyDeletedRecipe.value!);
            recentlyDeletedRecipe.value = null;
            Get.closeCurrentSnackbar();
          }
        },
        child: const Text('UNDO', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void findRecipesByIngredients(List<String> ingredients) {
    filteredRecipes.assignAll(
      recipes.where((recipe) {
        return ingredients.every(
          (ingredient) => recipe!.ingredients.any(
            (item) => item.toLowerCase().contains(ingredient.toLowerCase()),
          ),
        );
      }),
    );
  }
}
