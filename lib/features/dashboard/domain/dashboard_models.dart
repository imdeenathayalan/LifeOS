class LifeMetric {
  const LifeMetric({
    required this.label,
    required this.value,
    required this.detail,
    required this.progress,
  });

  final String label;
  final String value;
  final String detail;
  final double progress;
}

class GoalSummary {
  const GoalSummary({
    required this.title,
    required this.area,
    required this.progress,
    required this.nextStep,
  });

  final String title;
  final String area;
  final double progress;
  final String nextStep;
}

class ActivitySummary {
  const ActivitySummary({
    required this.title,
    required this.time,
    required this.category,
    required this.isPriority,
  });

  final String title;
  final String time;
  final String category;
  final bool isPriority;
}

class InsightSummary {
  const InsightSummary({
    required this.title,
    required this.body,
    required this.recommendedAction,
  });

  final String title;
  final String body;
  final String recommendedAction;
}

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.mission,
    required this.aiBriefing,
    required this.goals,
    required this.activities,
    required this.metrics,
    required this.insights,
  });

  final String mission;
  final String aiBriefing;
  final List<GoalSummary> goals;
  final List<ActivitySummary> activities;
  final List<LifeMetric> metrics;
  final List<InsightSummary> insights;
}
