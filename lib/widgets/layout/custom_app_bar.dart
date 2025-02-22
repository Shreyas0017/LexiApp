import 'package:flutter/material.dart';
import '../common/font_toggle.dart';
import '../../utils/constants/strings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool useOpenDyslexicFont;
  final VoidCallback onToggleFont;

  const CustomAppBar({
    super.key,
    required this.useOpenDyslexicFont,
    required this.onToggleFont,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text(
        AppStrings.appName,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: FontToggle(
            value: useOpenDyslexicFont,
            onChanged: (_) => onToggleFont(),
          ),
        ),
      ],
    );
  }
}
