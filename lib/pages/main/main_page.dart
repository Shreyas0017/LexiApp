import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/common/gradient_background.dart';
import '../../widgets/layout/custom_app_bar.dart';

// Data model for resource items
class ResourceItem {
  final String image;
  final String title;
  final String description;
  final String url;
  final Color color;

  const ResourceItem({
    required this.image,
    required this.title,
    required this.description,
    required this.url,
    required this.color,
  });
}

class MainPage extends StatelessWidget {
  final bool useOpenDyslexicFont;
  final VoidCallback onToggleFont;

  const MainPage({
    super.key,
    required this.useOpenDyslexicFont,
    required this.onToggleFont,
  });

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ResourceItem> buttonItems = [
      ResourceItem(
        image: 'assets/images/img1.png',
        title: 'Consult a Doctor',
        description: 'Find specialists',
        url: 'https://lexicare.vercel.app/',
        color: Colors.blue.shade400,
      ),
      ResourceItem(
        image: 'assets/images/img2.png',
        title: 'Community Support',
        description: 'Join community',
        url: 'https://lexilearn-neon.vercel.app/login',
        color: Colors.green.shade400,
      ),
      ResourceItem(
        image: 'assets/images/img3.png',
        title: 'Dyslexia-Friendly Converter',
        description: 'Try converter',
        url: 'https://lexishift-new.onrender.com/',
        color: Colors.purple.shade400,
      ),
      ResourceItem(
        image: 'assets/images/img4.png',
        title: 'Learning Platform',
        description: 'Start learning',
        url: 'https://lexilearn-neon.vercel.app/login',
        color: Colors.orange.shade400,
      ),
      ResourceItem(
        image: 'assets/images/img5.png',
        title: 'Digital Library',
        description: 'Browse library',
        url: 'https://lexishift.onrender.com/learn_more',
        color: Colors.red.shade400,
      ),
      ResourceItem(
        image: 'assets/images/img6.png',
        title: 'AI Chat Support',
        description: 'Start chat',
        url: 'https://dyslu-bot.vercel.app/',
        color: Colors.teal.shade400,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        useOpenDyslexicFont: useOpenDyslexicFont,
        onToggleFont: onToggleFont,
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Explore Resources',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: useOpenDyslexicFont ? 'OpenDyslexic' : null,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: buttonItems.length,
                  itemBuilder: (context, index) {
                    final item = buttonItems[index];
                    return ResourceCard(
                      image: item.image,
                      title: item.title,
                      description: item.description,
                      color: item.color,
                      onTap: () => _launchUrl(item.url),
                      useOpenDyslexicFont: useOpenDyslexicFont,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResourceCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;
  final bool useOpenDyslexicFont;

  const ResourceCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
    required this.useOpenDyslexicFont,
  });

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withOpacity(0.2),
                  ),
                  child: Image.asset(
                    widget.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: widget.useOpenDyslexicFont ? 'OpenDyslexic' : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    fontFamily: widget.useOpenDyslexicFont ? 'OpenDyslexic' : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}