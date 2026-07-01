import 'package:flutter/material.dart';

import 'life_os_card.dart';

class PlaceholderFeatureScreen extends StatelessWidget {
  const PlaceholderFeatureScreen({
    required this.title,
    required this.iconLabel,
    this.description,
    super.key,
  });

  final String title;
  final String iconLabel;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: width >= 760 ? 32 : 16,
        vertical: width >= 760 ? 28 : 16,
      ),
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description ?? '$title is ready for its production workflow, data model, realtime sync, and AI-assisted review loops.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
        ),
        const SizedBox(height: 20),
        LifeOSCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(iconLabel, style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 10),
              Text(
                'Next build slice',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Define Supabase tables, repository implementation, empty states, optimistic updates, realtime subscriptions, and accessibility tests for this module.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
