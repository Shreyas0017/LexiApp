import 'package:flutter/material.dart';

class FontToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const FontToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: Colors.white,
      inactiveThumbColor: Colors.grey,
      activeTrackColor: Colors.grey[400],
      inactiveTrackColor: Colors.grey[800],
    );
  }
}
