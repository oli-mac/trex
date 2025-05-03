import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
  final String message;

  const WelcomeBanner({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Expanded(child: Text(message, style: const TextStyle(fontSize: 16))),
          const SizedBox(width: 10),
          Image.asset(
            isDark ? 'assets/images/logo-dark.png' : 'assets/images/logo.png',
            width: 60,
            height: 60,
          ),
        ],
      ),
    );
  }
}
