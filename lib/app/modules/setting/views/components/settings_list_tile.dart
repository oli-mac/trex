import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      leading: Icon(icon, color: Color(0xFF6DE1D2)),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: const Icon(HeroIcons.chevron_right, size: 16),
      onTap: onTap,
    );
  }
}
