import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Goals',
      iconLabel: 'BI Bullseye',
      description: 'Track life goals, milestones, habits, progress confidence, and next actions across every area of life.',
    );
  }
}
