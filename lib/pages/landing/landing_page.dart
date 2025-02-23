import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/landing_title.dart';
import 'components/welcome_button.dart';
import 'animations/fade_in_animation.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/common/font_toggle.dart';
import '../main/main_page.dart';

class LandingPage extends StatefulWidget {
  final bool useOpenDyslexicFont;
  final VoidCallback onToggleFont;

  const LandingPage({
    super.key,
    required this.useOpenDyslexicFont,
    required this.onToggleFont,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -100,
              right: -100,
              child: _buildDecorativeCircle(200, Colors.white.withOpacity(0.1)),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: _buildDecorativeCircle(150, Colors.white.withOpacity(0.05)),
            ),

            // Main content
            FadeInAnimation(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Floating illustration
                    AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnimation.value),
                          child: child,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/landing_illustration.svg', // Add your illustration
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const LandingTitle(),
                    const SizedBox(height: 20),
                    Text(
                      'Empowering learners with dyslexia through innovative tools and support',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontFamily: widget.useOpenDyslexicFont ? 'OpenDyslexic' : null,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildEnhancedWelcomeButton(context),
                  ],
                ),
              ),
            ),

            // Font toggle
            Positioned(
              top: 40,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: 1.0,
                child: FontToggle(
                  value: widget.useOpenDyslexicFont,
                  onChanged: (_) => widget.onToggleFont(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildEnhancedWelcomeButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: WelcomeButton(
        onPressed: () => _navigateToMainPage(context),
        useOpenDyslexicFont: widget.useOpenDyslexicFont,
      ),
    );
  }

  void _navigateToMainPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MainPage(
          useOpenDyslexicFont: widget.useOpenDyslexicFont,
          onToggleFont: widget.onToggleFont,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}