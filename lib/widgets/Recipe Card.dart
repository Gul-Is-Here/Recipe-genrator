// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../model/recipe_model.dart';
//
// class RecipeCard extends StatelessWidget {
//   final Recipe recipe;
//   final VoidCallback onTap;
//   final VoidCallback onFavoriteToggle;
//
//   const RecipeCard({
//     super.key,
//     required this.recipe,
//     required this.onTap,
//     required this.onFavoriteToggle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(15),
//         onTap: onTap,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                   ),
//                 ),
//                 child: Center(
//                   child: Icon(
//                     Icons.fastfood,
//                     size: 50,
//                     color: Theme.of(context).colorScheme.secondary,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     recipe.title,
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.timer,
//                         size: 16,
//                         color: Theme.of(context).colorScheme.secondary,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         '${recipe.preparationTime} mins',
//                         style: GoogleFonts.poppins(fontSize: 12),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         icon: Icon(
//                           recipe.isFavorite
//                               ? Icons.favorite
//                               : Icons.favorite_border,
//                           color: recipe.isFavorite ? Colors.red : null,
//                           size: 20,
//                         ),
//                         onPressed: onFavoriteToggle,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Determine icon based on recipe category
    IconData recipeIcon = Icons.fastfood; // Default icon
    if (recipe.category == 'Dinner') {
      recipeIcon = Icons.restaurant_menu; // For dinner recipes
    } else if (recipe.category == 'Snack') {
      recipeIcon = Icons.local_dining; // For snack recipes
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Icon(
                    recipeIcon,
                    size: 50,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${recipe.preparationTime} mins',
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          recipe.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: recipe.isFavorite ? Colors.red : null,
                          size: 20,
                        ),
                        onPressed: onFavoriteToggle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
