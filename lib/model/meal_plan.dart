enum MealType { breakfast, lunch, dinner, snack }

class MealPlan {
  final String id;
  final DateTime date;
  final String recipeId;
  final MealType mealType;

  MealPlan({
    String? id,
    required this.date,
    required this.recipeId,
    required this.mealType,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();
}