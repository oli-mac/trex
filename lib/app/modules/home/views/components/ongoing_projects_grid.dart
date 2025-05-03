import 'package:flutter/material.dart';
import 'package:trex/app/modules/home/views/components/project_card.dart';

class OngoingProjectsGrid extends StatelessWidget {
  const OngoingProjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Mobile App',
        'subtitle': 'E-Commerce',
        'date': 'May 30, 2022',
        'progress': 0.5
      },
      {
        'title': 'Dashboard',
        'subtitle': 'Web',
        'date': 'May 30, 2022',
        'progress': 0.8
      },
      {
        'title': 'Banner',
        'subtitle': 'Marketing',
        'date': 'May 30, 2022',
        'progress': 0.4
      },
      {
        'title': 'UI/UX',
        'subtitle': 'Task Manager',
        'date': 'May 30, 2022',
        'progress': 0.6
      },
      {
        'title': 'Banner',
        'subtitle': 'Marketing',
        'date': 'May 30, 2022',
        'progress': 0.2
      },
      {
        'title': 'UI/UX',
        'subtitle': 'Task Manager',
        'date': 'May 30, 2022',
        'progress': 0.5
      },
      {
        'title': 'UI/UX',
        'subtitle': 'Task Manager',
        'date': 'May 30, 2022',
        'progress': 0.6
      },
      {
        'title': 'Banner',
        'subtitle': 'Marketing',
        'date': 'May 30, 2022',
        'progress': 0.2
      },
      {
        'title': 'UI/UX',
        'subtitle': 'Task Manager',
        'date': 'May 30, 2022',
        'progress': 0.5
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ongoing Media',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('view all', style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final p = projects[index];
              return ProjectCard(
                title: p['title'] as String,
                subtitle: p['subtitle'] as String,
                date: p['date'] as String,
                progress: p['progress'] as double,
              );
            },
          ),
        ],
      ),
    );
  }
}
