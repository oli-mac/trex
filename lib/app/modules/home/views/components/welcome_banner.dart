import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
  final String message;

  const WelcomeBanner({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(234, 227, 219, 1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Expanded(child: Text(message, style: TextStyle(fontSize: 16))),
          SizedBox(width: 10),
          Image.asset('assets/images/logo.jpeg', width: 60, height: 60),
        ],
      ),
    );
  }
}
