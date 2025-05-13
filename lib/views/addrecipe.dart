import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/recipe-controller.dart';
import '../model/recipe_model.dart';

class AddRecipeScreen extends StatefulWidget {
  final Recipe? recipe;

  const AddRecipeScreen({super.key, this.recipe});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final RecipeController recipeController = Get.find();

  late String _title;
  late List<String> _ingredients;
  late String _instructions;
  late int _preparationTime;
  late String _category;
  late bool _isFavorite;

  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _categories = ['Breakfast', 'Lunch', 'Dinner', 'Dessert'];

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _title = widget.recipe!.title;
      _ingredients = List.from(widget.recipe!.ingredients);
      _instructions = widget.recipe!.instructions;
      _preparationTime = widget.recipe!.preparationTime;
      _category = widget.recipe!.category;
      _isFavorite = widget.recipe!.isFavorite;
    } else {
      _title = '';
      _ingredients = [];
      _instructions = '';
      _preparationTime = 0;
      _category = _categories[0];
      _isFavorite = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipe == null ? 'Add Recipe' : 'Edit Recipe',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Recipe Title',
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 20),
              Text(
                'Ingredients',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ..._ingredients.map(
                (ingredient) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text('• $ingredient', style: GoogleFonts.poppins()),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () {
                          setState(() {
                            _ingredients.remove(ingredient);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ingredientController,
                      decoration: InputDecoration(
                        labelText: 'Add Ingredient',
                        labelStyle: GoogleFonts.poppins(),
                      ),
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_ingredientController.text.isNotEmpty) {
                        setState(() {
                          _ingredients.add(_ingredientController.text);
                          _ingredientController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _instructions,
                decoration: InputDecoration(
                  labelText: 'Instructions',
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter instructions';
                  }
                  return null;
                },
                onSaved: (value) => _instructions = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _preparationTime.toString(),
                decoration: InputDecoration(
                  labelText: 'Preparation Time (minutes)',
                  labelStyle: GoogleFonts.poppins(),
                ),
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter preparation time';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _preparationTime = int.parse(value!),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _category,
                items:
                    _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category, style: GoogleFonts.poppins()),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Add to Favorites', style: GoogleFonts.poppins()),
                  const Spacer(),
                  Switch(
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() {
                        _isFavorite = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _saveRecipe,
                  child: Text(
                    widget.recipe == null ? 'Add Recipe' : 'Update Recipe',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newRecipe = Recipe(
        id: widget.recipe?.id ?? DateTime.now().toString(),
        title: _title,
        ingredients: _ingredients,
        instructions: _instructions,
        preparationTime: _preparationTime,
        category: _category,
        isFavorite: _isFavorite,
      );

      if (widget.recipe == null) {
        recipeController.addRecipe(newRecipe);
        Get.snackbar(
          'Success',
          'Recipe added successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        recipeController.updateRecipe(newRecipe);
        Get.snackbar(
          'Updated',
          'Recipe updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:  Colors.green,
          colorText: Colors.white,
        );
      }

      Get.back(); // Close the screen
    }
  }
}
