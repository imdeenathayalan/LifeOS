import 'package:supabase_flutter/supabase_flutter.dart';

import 'dashboard_models.dart';

abstract class DashboardRepository {
  Future<DashboardSnapshot> loadSnapshot();
}

class MockDashboardRepository implements DashboardRepository {
  const MockDashboardRepository();

  @override
  Future<DashboardSnapshot> loadSnapshot() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return const DashboardSnapshot(
      mission: 'Protect deep work, complete the strength session, and close the monthly finance review.',
      aiBriefing:
          'Your calendar has two focus windows and one planning gap at 4:30 PM. Hydration is behind pace, while fitness and goal momentum are trending well.',
      goals: [
        GoalSummary(
          title: 'Launch LifeOS private beta',
          area: 'Career',
          progress: 0.68,
          nextStep: 'Finalize onboarding flow review',
        ),
        GoalSummary(
          title: 'Run a consistent strength block',
          area: 'Fitness',
          progress: 0.74,
          nextStep: 'Upper body session at 6:15 PM',
        ),
        GoalSummary(
          title: 'Build a calmer morning routine',
          area: 'Health',
          progress: 0.52,
          nextStep: 'Prepare tomorrow briefing tonight',
        ),
      ],
      activities: [
        ActivitySummary(
          title: 'Write product strategy note',
          time: '09:30',
          category: 'Deep Work',
          isPriority: true,
        ),
        ActivitySummary(
          title: 'Team planning review',
          time: '12:00',
          category: 'Meeting',
          isPriority: false,
        ),
        ActivitySummary(
          title: 'Strength training',
          time: '18:15',
          category: 'Fitness',
          isPriority: true,
        ),
        ActivitySummary(
          title: 'Evening reflection',
          time: '21:30',
          category: 'Review',
          isPriority: false,
        ),
      ],
      metrics: [
        LifeMetric(label: 'Productivity', value: '76%', detail: '5 of 7 priority blocks protected', progress: 0.76),
        LifeMetric(label: 'Workout', value: '42 min', detail: 'Upper body session planned', progress: 0.62),
        LifeMetric(label: 'Nutrition', value: '1,820 kcal', detail: 'Protein target is 78% complete', progress: 0.78),
        LifeMetric(label: 'Water', value: '1.4 L', detail: '1.1 L remaining today', progress: 0.56),
        LifeMetric(label: 'Expenses', value: '$84', detail: '32% below daily budget', progress: 0.32),
        LifeMetric(label: 'Weekly', value: '71%', detail: 'Goal systems are on track', progress: 0.71),
      ],
      insights: [
        InsightSummary(
          title: 'Move planning earlier',
          body: 'Your evening reviews are more complete when the next day is sketched before 8 PM.',
          recommendedAction: 'Schedule a 10 minute planning block at 7:45 PM.',
        ),
        InsightSummary(
          title: 'Hydration lag detected',
          body: 'Water intake is tracking behind your usual weekday pace.',
          recommendedAction: 'Add two reminders before dinner.',
        ),
      ],
    );
  }
}

class SupabaseDashboardRepository implements DashboardRepository {
  const SupabaseDashboardRepository(
    this._client, {
    this.fallback = const MockDashboardRepository(),
  });

  final SupabaseClient _client;
  final DashboardRepository fallback;

  @override
  Future<DashboardSnapshot> loadSnapshot() async {
    final user = _client.auth.currentUser;
    if (user == null) return fallback.loadSnapshot();

    final row = await _client
        .from('dashboard_snapshots')
        .select()
        .eq('user_id', user.id)
        .order('snapshot_date', ascending: false)
        .limit(1)
        .maybeSingle();

    if (row == null) return fallback.loadSnapshot();
    return DashboardSnapshot(
      mission: row['mission'] as String? ?? 'Review today and choose the next best action.',
      aiBriefing: row['ai_briefing'] as String? ?? 'No AI briefing has been generated yet.',
      goals: _parseGoals(row['goals']),
      activities: _parseActivities(row['activities']),
      metrics: _parseMetrics(row['metrics']),
      insights: _parseInsights(row['insights']),
    );
  }

  List<GoalSummary> _parseGoals(Object? value) {
    final items = value is List ? value : const [];
    return items.whereType<Map>().map((item) {
      return GoalSummary(
        title: item['title'] as String? ?? 'Untitled goal',
        area: item['area'] as String? ?? 'General',
        progress: _progress(item['progress']),
        nextStep: item['next_step'] as String? ?? 'Choose the next action',
      );
    }).toList();
  }

  List<ActivitySummary> _parseActivities(Object? value) {
    final items = value is List ? value : const [];
    return items.whereType<Map>().map((item) {
      return ActivitySummary(
        title: item['title'] as String? ?? 'Untitled activity',
        time: item['time'] as String? ?? '--:--',
        category: item['category'] as String? ?? 'General',
        isPriority: item['is_priority'] as bool? ?? false,
      );
    }).toList();
  }

  List<LifeMetric> _parseMetrics(Object? value) {
    final items = value is List ? value : const [];
    return items.whereType<Map>().map((item) {
      return LifeMetric(
        label: item['label'] as String? ?? 'Metric',
        value: item['value'] as String? ?? '-',
        detail: item['detail'] as String? ?? '',
        progress: _progress(item['progress']),
      );
    }).toList();
  }

  List<InsightSummary> _parseInsights(Object? value) {
    final items = value is List ? value : const [];
    return items.whereType<Map>().map((item) {
      return InsightSummary(
        title: item['title'] as String? ?? 'Insight',
        body: item['body'] as String? ?? '',
        recommendedAction: item['recommended_action'] as String? ?? 'Review this insight',
      );
    }).toList();
  }

  double _progress(Object? value) {
    final numeric = value is num ? value.toDouble() : 0.0;
    return numeric.clamp(0.0, 1.0).toDouble();
  }
}
