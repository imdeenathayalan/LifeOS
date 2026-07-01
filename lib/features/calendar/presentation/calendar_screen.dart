import 'package:flutter/material.dart';

import '../../../core/widgets/placeholder_feature_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderFeatureScreen(
      title: 'Calendar',
      iconLabel: 'BI Calendar3',
      description: 'A calm schedule view for time blocks, upcoming activities, workout reminders, meals, and reviews.',
    );
  }
}
