import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_generator/splash/splash.dart';

import 'controllers/meal_plan.dart';
import 'controllers/recipe-controller.dart';
import 'controllers/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    Get.put(RecipeController());
    Get.put(MealPlanController());
    return GetMaterialApp(
      title: 'Quick Recipe Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF6C4AB6),
          secondary: const Color(0xFF8D72E1),
          surface: const Color(0xFFF5F5F5),
          background: const Color(0xFFFFFFFF),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(
            0xFF8D72E1,
          ), // Light theme selected item color
          unselectedItemColor:
              Colors.black, // Light theme unselected item color (set to black)
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Color.fromARGB(255, 225, 114, 158),
          secondary: Color(0xFF6C4AB6),
          surface: Color(0xFF121212),
          background: Color(0xFF1E1E1E),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white, // Apply white color to body text
          displayColor: Colors.white, // Apply white color to display text
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(
            0xFF8D72E1,
          ), // Dark theme selected item color
          unselectedItemColor:
              Colors
                  .white, // Dark theme unselected item color (make unselected items white)
        ),
      ),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
