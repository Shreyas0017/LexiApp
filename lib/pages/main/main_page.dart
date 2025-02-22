import 'package:flutter/material.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/layout/custom_app_bar.dart';

class MainPage extends StatelessWidget {
  final bool useOpenDyslexicFont;
  final VoidCallback onToggleFont;

  const MainPage({
    super.key,
    required this.useOpenDyslexicFont,
    required this.onToggleFont,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        useOpenDyslexicFont: useOpenDyslexicFont,
        onToggleFont: onToggleFont,
      ),
      body: GradientBackground(
        child: const Center(
          child: Text(
            'Main Page Content',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}