import 'package:flutter/material.dart';
import 'components/landing_title.dart';
import 'components/welcome_button.dart';
import 'animations/fade_in_animation.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/common/font_toggle.dart';
import '../main/main_page.dart';

class LandingPage extends StatelessWidget {
  final bool useOpenDyslexicFont;
  final VoidCallback onToggleFont;

  const LandingPage({
    super.key,
    required this.useOpenDyslexicFont,
    required this.onToggleFont,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            FadeInAnimation(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LandingTitle(),
                    const SizedBox(height: 60),
                    WelcomeButton(
                      onPressed: () => _navigateToMainPage(context),
                      useOpenDyslexicFont: useOpenDyslexicFont,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: 1.0,
                child: FontToggle(
                  value: useOpenDyslexicFont,
                  onChanged: (_) => onToggleFont(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMainPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MainPage (
          useOpenDyslexicFont: useOpenDyslexicFont,
          onToggleFont: onToggleFont,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}