import 'package:flutter/material.dart';

void main() {
  runApp(const LexiLearnApp());
}

class LexiLearnApp extends StatefulWidget {
  const LexiLearnApp({super.key});

  @override
  State<LexiLearnApp> createState() => _LexiLearnAppState();
}

class _LexiLearnAppState extends State<LexiLearnApp> {
  bool _useOpenDyslexicFont = false;
  double _fontSize = 18.0;

  static const double _minFontSize = 14.0;
  static const double _maxFontSize = 32.0;
  static const double _fontSizeStep = 2.0;

  void _toggleFont() {
    setState(() {
      _useOpenDyslexicFont = !_useOpenDyslexicFont;
    });
  }

  void _increaseFontSize() {
    setState(() {
      if (_fontSize < _maxFontSize) {
        _fontSize += _fontSizeStep;
      }
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > _minFontSize) {
        _fontSize -= _fontSizeStep;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LexiLearnApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: _useOpenDyslexicFont ? 'OpenDyslexic' : 'Roboto',
      ),
      home: HomePage(
        fontSize: _fontSize,
        useOpenDyslexicFont: _useOpenDyslexicFont,
        onToggleFont: _toggleFont,
        onIncreaseFontSize: _increaseFontSize,
        onDecreaseFontSize: _decreaseFontSize,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final double fontSize;
  final bool useOpenDyslexicFont;
  final VoidCallback onToggleFont;
  final VoidCallback onIncreaseFontSize;
  final VoidCallback onDecreaseFontSize;

  const HomePage({
    super.key,
    required this.fontSize,
    required this.useOpenDyslexicFont,
    required this.onToggleFont,
    required this.onIncreaseFontSize,
    required this.onDecreaseFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LexiLearnApp',
          style: TextStyle(fontSize: fontSize + 4),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is a sample text with dynamic font!',
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Another text to verify global font change.',
              style: TextStyle(fontSize: fontSize),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onDecreaseFontSize,
                  child: const Text('A-'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onIncreaseFontSize,
                  child: const Text('A+'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onToggleFont,
              child: Text(
                useOpenDyslexicFont
                    ? 'Switch to Default Font'
                    : 'Switch to OpenDyslexic Font',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}