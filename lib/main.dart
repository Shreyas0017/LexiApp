import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        fontFamily: _useOpenDyslexicFont ? 'OpenDyslexic' : 'Roboto',
      ),
      home: LandingPage(
        useOpenDyslexicFont: _useOpenDyslexicFont,
        onToggleFont: _toggleFont,
      ),
    );
  }
}

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
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.grey[900]!,
              Colors.black,
            ],
          ),
        ),
        child: Stack(
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LexiShift',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Welcome to LexiShift',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[300],
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                MainPage(
                                  useOpenDyslexicFont: widget.useOpenDyslexicFont,
                                  onToggleFont: widget.onToggleFont,
                                ),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Welcome to the New You',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                        ),
                      ),
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
                child: Switch(
                  value: widget.useOpenDyslexicFont,
                  onChanged: (_) => widget.onToggleFont(),
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.grey,
                  activeTrackColor: Colors.grey[400],
                  inactiveTrackColor: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'LexiShift',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Switch(
              value: useOpenDyslexicFont,
              onChanged: (_) => onToggleFont(),
              activeColor: Colors.white,
              inactiveThumbColor: Colors.grey,
              activeTrackColor: Colors.grey[400],
              inactiveTrackColor: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.grey[900]!,
              Colors.black,
            ],
          ),
        ),
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