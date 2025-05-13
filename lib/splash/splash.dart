import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _scaleController.repeat(reverse: true);

    // Navigate after animation completes
    Future.delayed(const Duration(seconds: 5), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigation()),
      );

    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C4AB6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated emoji
            ScaleTransition(
              scale: _scaleAnimation,
              child: Text('🍳', style: TextStyle(fontSize: 80)),
            ),
            const SizedBox(height: 20),
            // App name with stylish text
            Text(
              'Quick Recipe',
              style: GoogleFonts.pacifico(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            Text(
              'Generator',
              style: GoogleFonts.pacifico(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Cooking animation
            // Lottie.asset(
            //   'assets/animations/cooking.json',
            //   width: 150,
            //   height: 150,
            //   fit: BoxFit.fill,
            // ),
            const SizedBox(height: 20),
            // Loading text with animated dots
            _buildLoadingText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingText() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 2),
      builder: (context, value, _) {
        final dotCount = (value * 3).floor();
        return Text(
          'Loading${'.' * dotCount}',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
          ),
        );
      },
      onEnd: () {
        setState(() {});
      },
    );
  }
}
