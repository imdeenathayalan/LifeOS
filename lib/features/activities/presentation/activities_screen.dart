import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Activities',
      iconLabel: 'BI Activity',
      description: 'Plan, complete, defer, and review daily activities with priority, energy, duration, and context.',
    );
  }
}
