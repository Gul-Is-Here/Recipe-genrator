import 'package:get/get.dart';

import '../model/meal_plan.dart';

class MealPlanController extends GetxController {
  var mealPlans = <MealPlan>[].obs;

  void addMealPlan(DateTime date, String recipeId, MealType mealType) {
    mealPlans.add(MealPlan(
      date: date,
      recipeId: recipeId,
      mealType: mealType,
    ));
  }

  void removeMealPlan(String id) {
    mealPlans.removeWhere((plan) => plan.id == id);
  }

  List<MealPlan> getPlansForDay(DateTime date) {
    return mealPlans.where((plan) =>
    plan.date.year == date.year &&
        plan.date.month == date.month &&
        plan.date.day == date.day
    ).toList();
  }
}