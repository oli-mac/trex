import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final double progress;

  const ProjectCard({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.progress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 6),
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
          SizedBox(height: 12),
          LinearProgressIndicator(
              value: progress, backgroundColor: Colors.grey[200]),
        ],
      ),
    );
  }
}
