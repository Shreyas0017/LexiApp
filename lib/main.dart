import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'pages/landing/landing_page.dart';

void main() {
  runApp(const LexiShiftApp());
}

class LexiShiftApp extends StatefulWidget {
  const LexiShiftApp({super.key});

  @override
  State<LexiShiftApp> createState() => _LexiShiftAppState();
}

class _LexiShiftAppState extends State<LexiShiftApp> {
  bool _useOpenDyslexicFont = false;

  void _toggleFont() {
    setState(() {
      _useOpenDyslexicFont = !_useOpenDyslexicFont;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LexiShift',
      theme: AppTheme.getTheme(_useOpenDyslexicFont),
      home: LandingPage(
        useOpenDyslexicFont: _useOpenDyslexicFont,
        onToggleFont: _toggleFont,
      ),
    );
  }
}