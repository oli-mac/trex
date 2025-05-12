import 'package:flutter/material.dart';
import 'package:trex/app/modules/home/views/components/project_card.dart';

class OngoingProjectsGrid extends StatelessWidget {
  const OngoingProjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Summer List',
        'subtitle': 'Books',
        'date': 'May 30, 2022',
        'progress': 0.5
      },
      {
        'title': 'Favorite List',
        'subtitle': 'Movies',
        'date': 'May 30, 2022',
        'progress': 0.8
      },
      {
        'title': 'Valentine List',
        'subtitle': 'TV Shows',
        'date': 'May 30, 2022',
        'progress': 0.4
      },
      {
        'title': 'Internal List',
        'subtitle': 'Books',
        'date': 'May 30, 2022',
        'progress': 0.6
      },
      {
        'title': 'Book Club List',
        'subtitle': 'Books',
        'date': 'May 30, 2022',
        'progress': 0.2
      },
      {
        'title': 'November List',
        'subtitle': 'Movies',
        'date': 'May 30, 2022',
        'progress': 0.5
      },
      {
        'title': 'Lake View List',
        'subtitle': 'TV Shows',
        'date': 'May 30, 2022',
        'progress': 0.6
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
              Text('Ongoing Lists',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('view all', style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(height: 16),
          projects.isEmpty
              ? const Center(child: Text('No ongoing Lists found.'))
              : const SizedBox.shrink(),
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
