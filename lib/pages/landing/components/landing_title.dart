import 'package:flutter/material.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/constants/colors.dart';

class LandingTitle extends StatefulWidget {
  const LandingTitle({super.key});

  @override
  State<LandingTitle> createState() => _LandingTitleState();
}

class _LandingTitleState extends State<LandingTitle> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main Title
        ScaleTransition(
          scale: _scaleAnimation,
          child: Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  color: AppColors.text.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Subtitle
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            AppStrings.welcome,
            style: TextStyle(
              fontSize: 24,
              color: AppColors.text.withOpacity(0.8),
              letterSpacing: 1.5,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}