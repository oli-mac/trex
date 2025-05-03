import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String username;
  final String greeting;

  const HeaderSection({
    required this.username,
    required this.greeting,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello $username! 😊',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(greeting,
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          Icon(Icons.notifications, color: Colors.grey[700])
        ],
      ),
    );
  }
}
