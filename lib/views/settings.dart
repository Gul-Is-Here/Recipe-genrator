import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => SwitchListTile(
              title: Text(
                'Dark Mode',
                style: GoogleFonts.poppins(),
              ),
              value: themeController.isDarkMode.value,
              onChanged: (value) {
                themeController.toggleTheme(); // Toggles the theme when changed
              },
            )),
            const SizedBox(height: 20),
            Text(
              'About',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                'Version',
                style: GoogleFonts.poppins(),
              ),
              trailing: Text(
                '1.0.0',
                style: GoogleFonts.poppins(),
              ),
            ),
            ListTile(
              title: Text(
                'Developer',
                style: GoogleFonts.poppins(),
              ),
              trailing: Text(
                'Quick Recipe Team',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
