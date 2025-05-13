// meal_plan_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/meal_plan.dart';
import '../controllers/recipe-controller.dart';
import '../model/meal_plan.dart';
import '../model/recipe_model.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final MealPlanController mealPlanController = Get.put(MealPlanController());
  final RecipeController recipeController = Get.find();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal Planning',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            headerStyle: HeaderStyle(
              titleTextStyle: GoogleFonts.poppins(),
              formatButtonTextStyle: GoogleFonts.poppins(),
            ),
            calendarStyle: CalendarStyle(
              todayTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              selectedTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: _buildDayPlan(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMealDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDayPlan() {
    if (_selectedDay == null) {
      return Center(
        child: Text(
          'Select a day to plan meals',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      );
    }

    final plans = mealPlanController.getPlansForDay(_selectedDay!);

    if (plans.isEmpty) {
      return Center(
        child: Text(
          'No meals planned for this day',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        final recipe = recipeController.recipes.firstWhere(
              (r) => r.id == plan.recipeId,
          orElse: () => Recipe(
            id: '',
            title: 'Recipe not found',
            ingredients: [],
            instructions: '',
            preparationTime: 0,
            category: '',
          ),
        );

        return ListTile(
          title: Text(
            '${plan.mealType.toString().split('.').last.toUpperCase()}: ${recipe.title}',
            style: GoogleFonts.poppins(),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => mealPlanController.removeMealPlan(plan.id),
          ),
        );
      },
    );
  }

  void _showAddMealDialog() {
    if (_selectedDay == null) return;

    showDialog(
      context: context,
      builder: (context) {
        MealType selectedMealType = MealType.breakfast;
        String? selectedRecipeId;

        return AlertDialog(
          title: Text(
            'Add Meal Plan',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<MealType>(
                value: selectedMealType,
                items: MealType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(
                      type.toString().split('.').last.toUpperCase(),
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedMealType = value;
                  }
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                hint: Text(
                  'Select Recipe',
                  style: GoogleFonts.poppins(),
                ),
                items: recipeController.recipes.map((recipe) {
                  return DropdownMenuItem(
                    value: recipe.id,
                    child: Text(
                      recipe.title,
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedRecipeId = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(),
              ),
            ),
            TextButton(
              onPressed: () {
                if (selectedRecipeId != null) {
                  mealPlanController.addMealPlan(
                    _selectedDay!,
                    selectedRecipeId!,
                    selectedMealType,
                  );
                  Get.back();
                }
              },
              child: Text(
                'Add',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        );
      },
    );
  }
}