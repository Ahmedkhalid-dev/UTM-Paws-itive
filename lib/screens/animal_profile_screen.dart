import 'package:flutter/material.dart';

import '../models/animal.dart';
import '../theme/app_theme.dart';
import '../widgets/status_chip.dart';

class AnimalProfileScreen extends StatefulWidget {
  const AnimalProfileScreen({required this.animal, super.key});

  final Animal animal;

  @override
  State<AnimalProfileScreen> createState() => _AnimalProfileScreenState();
}

class _AnimalProfileScreenState extends State<AnimalProfileScreen> {
  bool _seen = false;

  @override
  Widget build(BuildContext context) {
    final animal = widget.animal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal Profile'),
        actions: [
          IconButton(
            tooltip: 'Share',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share is demo-only')),
              );
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primary.withValues(alpha: 0.24),
                    AppTheme.accent.withValues(alpha: 0.18),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(Icons.pets, size: 78, color: AppTheme.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              animal.name,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              animal.type,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: AppTheme.secondary),
                            ),
                          ],
                        ),
                      ),
                      StatusChip(status: animal.status),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _InfoCard(
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: AppTheme.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            animal.location,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _InfoCard(
                    title: 'Description',
                    child: Text(
                      animal.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.text.withValues(alpha: 0.74),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _InfoCard(
                          title: 'Date Reported',
                          child: Text(
                            animal.dateReported,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _InfoCard(
                          title: 'Reported By',
                          child: Text(
                            animal.reportedBy,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Volunteer contact is demo-only'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.phone),
                          label: const Text('Contact Volunteer'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() => _seen = !_seen);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _seen
                                      ? 'Marked as seen'
                                      : 'Seen mark removed',
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            _seen ? Icons.check_circle : Icons.visibility,
                          ),
                          label: Text(_seen ? 'Seen' : 'Mark as Seen'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child, this.title});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                title!.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.text.withValues(alpha: 0.48),
                ),
              ),
              const SizedBox(height: 8),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
