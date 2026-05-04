import 'package:flutter/material.dart';

import '../models/animal.dart';
import '../theme/app_theme.dart';
import '../widgets/animal_card.dart';
import '../widgets/empty_state.dart';
import 'animal_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedFilter = 'All';
  String _query = '';

  static const _filters = ['All', 'Cats', 'Dogs', 'Healthy', 'Needs Help'];

  static const _animals = [
    Animal(
      id: '1',
      name: 'Cat near Library',
      type: 'Cat',
      location: 'UTM Library',
      status: 'Healthy',
      description:
          'A calm campus cat was resting near the library entrance. It appears healthy, alert, and comfortable around students.',
      dateReported: '3 May 2026',
      reportedBy: 'Aina Rahman',
    ),
    Animal(
      id: '2',
      name: 'Cat at Kolej 9',
      type: 'Cat',
      location: 'Kolej 9',
      status: 'Needs Feeding',
      description:
          'Thin cat spotted around the Kolej 9 walkway. It stayed near the food court and may need feeding.',
      dateReported: '3 May 2026',
      reportedBy: 'Daniel Tan',
    ),
    Animal(
      id: '3',
      name: 'Dog near Stadium',
      type: 'Dog',
      location: 'UTM Stadium',
      status: 'Injured',
      description:
          'Dog seen limping near the stadium parking area. It is alert but keeps distance from people.',
      dateReported: '3 May 2026',
      reportedBy: 'Nur Iman',
    ),
  ];

  List<Animal> get _visibleAnimals {
    final normalizedQuery = _query.trim().toLowerCase();
    return _animals.where((animal) {
      final matchesFilter = switch (_selectedFilter) {
        'Cats' => animal.isCat,
        'Dogs' => animal.isDog,
        'Healthy' => animal.status == 'Healthy',
        'Needs Help' => animal.needsHelp,
        _ => true,
      };

      if (!matchesFilter) {
        return false;
      }

      if (normalizedQuery.isEmpty) {
        return true;
      }

      final searchableText = [
        animal.name,
        animal.type,
        animal.location,
        animal.status,
        animal.description,
        animal.reportedBy,
      ].join(' ').toLowerCase();

      return searchableText.contains(normalizedQuery);
    }).toList();
  }

  void _openProfile(Animal animal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AnimalProfileScreen(animal: animal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleAnimals = _visibleAnimals;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal Reports'),
        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile is demo-only')),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/report'),
        icon: const Icon(Icons.pets),
        label: const Text('Report Animal'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
              color: AppTheme.primary,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => setState(() => _query = value),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search animals near campus...',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.72),
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      suffixIcon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.20),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.65),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final filter in _filters) ...[
                          FilterChip(
                            label: Text(filter),
                            selected: _selectedFilter == filter,
                            onSelected: (_) {
                              setState(() => _selectedFilter = filter);
                            },
                            selectedColor: Colors.white,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.14,
                            ),
                            labelStyle: TextStyle(
                              color: _selectedFilter == filter
                                  ? AppTheme.primary
                                  : Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.24),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
              child: Row(
                children: [
                  Text(
                    '${visibleAnimals.length} '
                    '${visibleAnimals.length == 1 ? 'animal' : 'animals'} found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.filter_list,
                    color: AppTheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _selectedFilter,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: AppTheme.primary),
                  ),
                ],
              ),
            ),
            Expanded(
              child: visibleAnimals.isEmpty
                  ? EmptyState(
                      title: 'No animals found',
                      message: 'Try a different search or filter.',
                      onPressed: () => Navigator.pushNamed(context, '/report'),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(18, 4, 18, 96),
                      itemBuilder: (context, index) {
                        final animal = visibleAnimals[index];
                        return AnimalCard(
                          animal: animal,
                          onTap: () => _openProfile(animal),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: visibleAnimals.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
