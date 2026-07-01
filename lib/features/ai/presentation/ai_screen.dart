import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'AI',
      iconLabel: 'BI Robot',
      description: 'Chat with a planner, coach, analyst, and accountability partner that always requests confirmation before data changes.',
    );
  }
}
