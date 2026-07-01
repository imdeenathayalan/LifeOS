import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/life_os_theme.dart';
import '../core/widgets/placeholder_feature_screen.dart';
import '../features/activities/presentation/activities_screen.dart';
import '../features/ai/presentation/ai_screen.dart';
import '../features/analytics/presentation/analytics_screen.dart';
import '../features/calendar/presentation/calendar_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/finance/presentation/finance_screen.dart';
import '../features/fitness/presentation/fitness_screen.dart';
import '../features/goals/presentation/goals_screen.dart';
import '../features/health/presentation/health_screen.dart';
import '../features/nutrition/presentation/nutrition_screen.dart';
import '../features/planner/presentation/planner_screen.dart';
import '../features/productivity/presentation/productivity_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/shell/life_os_shell.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => LifeOSShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const DashboardScreen()),
        GoRoute(path: '/goals', builder: (_, __) => const GoalsScreen()),
        GoRoute(path: '/activities', builder: (_, __) => const ActivitiesScreen()),
        GoRoute(path: '/calendar', builder: (_, __) => const CalendarScreen()),
        GoRoute(path: '/ai', builder: (_, __) => const AIScreen()),
        GoRoute(path: '/planner', builder: (_, __) => const PlannerScreen()),
        GoRoute(path: '/productivity', builder: (_, __) => const ProductivityScreen()),
        GoRoute(path: '/health', builder: (_, __) => const HealthScreen()),
        GoRoute(path: '/fitness', builder: (_, __) => const FitnessScreen()),
        GoRoute(path: '/nutrition', builder: (_, __) => const NutritionScreen()),
        GoRoute(path: '/finance', builder: (_, __) => const FinanceScreen()),
        GoRoute(path: '/analytics', builder: (_, __) => const AnalyticsScreen()),
        GoRoute(path: '/notifications', builder: (_, __) => const PlaceholderFeatureScreen(title: 'Notifications', iconLabel: 'BI Bell')),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ),
  ],
);

class LifeOSApp extends StatelessWidget {
  const LifeOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LifeOS',
      debugShowCheckedModeBanner: false,
      theme: LifeOSTheme.light(),
      darkTheme: LifeOSTheme.dark(),
      routerConfig: _router,
    );
  }
}
