class Recipe {
  final String id;
  final String title;
  final List<String> ingredients;
  final String instructions;
  final int preparationTime;
  final String category;
  bool isFavorite;
  List<String> dietaryTags;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.preparationTime,
    required this.category,
    this.isFavorite = false,
    this.dietaryTags = const [],
  });
}