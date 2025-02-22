import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonItems = [
      {
        'image': 'assets/images/img1.png',
        'title': 'Consult a Doctor',
        'description': 'Find specialists',
        'url': 'https://lexicare.vercel.app/',
      },
      {
        'image': 'assets/images/img2.png',
        'title': 'Community Support',
        'description': 'Join community',
        'url': 'https://lexilearn-neon.vercel.app/login',
      },
      {
        'image': 'assets/images/img3.png',
        'title': 'Dyslexia-Friendly Converter',
        'description': 'Try converter',
        'url': 'https://lexishift-new.onrender.com/',
      },
      {
        'image': 'assets/images/img4.png',
        'title': 'Learning Platform',
        'description': 'Start learning',
        'url': 'https://lexilearn-neon.vercel.app/login',
      },
      {
        'image': 'assets/images/img5.png',
        'title': 'Digital Library',
        'description': 'Browse library',
        'url': 'https://lexishift.onrender.com/learn_more',
      },
      {
        'image': 'assets/images/img6.png',
        'title': 'AI Chat Support',
        'description': 'Start chat',
        'url': 'https://dyslu-bot.vercel.app/',
      },
    ];


    return Scaffold(
      appBar: CustomAppBar(
        useOpenDyslexicFont: useOpenDyslexicFont,
        onToggleFont: onToggleFont,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: buttonItems.length,
            itemBuilder: (context, index) {
              final item = buttonItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ResourceButton(
                  image: item['image']!,
                  title: item['title']!,
                  description: item['description']!,
                  onTap: () => _launchUrl(item['url']!),
                  useOpenDyslexicFont: useOpenDyslexicFont,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ResourceButton extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool useOpenDyslexicFont;

  const ResourceButton({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.onTap,
    required this.useOpenDyslexicFont,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontFamily: useOpenDyslexicFont ? 'OpenDyslexic' : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        fontFamily: useOpenDyslexicFont ? 'OpenDyslexic' : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Arrow icon
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}