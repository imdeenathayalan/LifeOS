import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/life_os_theme.dart';
import '../../../core/widgets/life_os_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/status_chip.dart';
import '../domain/dashboard_models.dart';
import 'dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(dashboardSnapshotProvider);

    return snapshot.when(
      loading: () => const _DashboardLoading(),
      error: (error, stackTrace) => _DashboardError(message: error.toString()),
      data: (data) => _DashboardContent(
        snapshot: data,
        onRefresh: () async {
          await ref.refresh(dashboardSnapshotProvider.future);
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.snapshot, required this.onRefresh});

  final DashboardSnapshot snapshot;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 1100;
    final contentPadding = EdgeInsets.symmetric(
      horizontal: width >= 760 ? 32 : 16,
      vertical: width >= 760 ? 28 : 16,
    );

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: contentPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _Header(snapshot: snapshot),
                const SizedBox(height: 20),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 7, child: _PrimaryColumn(snapshot: snapshot)),
                      const SizedBox(width: 18),
                      Expanded(flex: 4, child: _SecondaryColumn(snapshot: snapshot)),
                    ],
                  )
                else ...[
                  _PrimaryColumn(snapshot: snapshot),
                  const SizedBox(height: 16),
                  _SecondaryColumn(snapshot: snapshot),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.snapshot});

  final DashboardSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today',
          style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          snapshot.mission,
          style: textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _PrimaryColumn extends StatelessWidget {
  const _PrimaryColumn({required this.snapshot});

  final DashboardSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AIBriefingCard(briefing: snapshot.aiBriefing),
        const SizedBox(height: 16),
        _GoalsCard(goals: snapshot.goals),
        const SizedBox(height: 16),
        _ActivitiesCard(activities: snapshot.activities),
        const SizedBox(height: 16),
        _MetricsGrid(metrics: snapshot.metrics),
      ],
    );
  }
}

class _SecondaryColumn extends StatelessWidget {
  const _SecondaryColumn({required this.snapshot});

  final DashboardSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _QuickActionsCard(),
        const SizedBox(height: 16),
        _CalendarPreview(activities: snapshot.activities),
        const SizedBox(height: 16),
        _InsightsCard(insights: snapshot.insights),
      ],
    );
  }
}

class _AIBriefingCard extends StatelessWidget {
  const _AIBriefingCard({required this.briefing});

  final String briefing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LifeOSCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(BootstrapIcons.stars, color: scheme.primary),
              const SizedBox(width: 10),
              const Expanded(child: SectionHeader(title: 'AI Briefing')),
              StatusChip(label: 'Needs approval', color: scheme.primary),
            ],
          ),
          const SizedBox(height: 14),
          Text(briefing, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5)),
          const SizedBox(height: 16),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () => _showConfirmSheet(context),
                icon: const Icon(BootstrapIcons.check2),
                label: const Text('Review plan'),
              ),
              const SizedBox(width: 10),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(BootstrapIcons.chat_square_text),
                label: const Text('Ask AI'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showConfirmSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Confirm AI changes', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('LifeOS can suggest schedule changes, but it will ask before editing goals, activities, workouts, meals, or financial records.'),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Not now'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Approve preview'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalsCard extends StatelessWidget {
  const _GoalsCard({required this.goals});

  final List<GoalSummary> goals;

  @override
  Widget build(BuildContext context) {
    return LifeOSCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Active Goals'),
          const SizedBox(height: 14),
          ...goals.map((goal) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(goal.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                        ),
                        Text('${(goal.progress * 100).round()}%'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: goal.progress, minHeight: 7, borderRadius: BorderRadius.circular(6)),
                    const SizedBox(height: 7),
                    Text('${goal.area} - ${goal.nextStep}', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _ActivitiesCard extends StatelessWidget {
  const _ActivitiesCard({required this.activities});

  final List<ActivitySummary> activities;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<LifeOSColors>()!;

    return LifeOSCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: "Today's Activities"),
          const SizedBox(height: 12),
          ...activities.map(
            (activity) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(activity.time, style: Theme.of(context).textTheme.labelLarge),
              title: Text(activity.title),
              subtitle: Text(activity.category),
              trailing: activity.isPriority ? StatusChip(label: 'Priority', color: colors.warning) : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.metrics});

  final List<LifeMetric> metrics;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1200 ? 3 : width >= 680 ? 2 : 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: width >= 680 ? 1.7 : 2.25,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return LifeOSCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(metric.label, style: Theme.of(context).textTheme.labelLarge),
              Text(metric.value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
              Text(metric.detail, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
              LinearProgressIndicator(value: metric.progress, minHeight: 6, borderRadius: BorderRadius.circular(6)),
            ],
          ),
        );
      },
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  @override
  Widget build(BuildContext context) {
    const actions = [
      ('Goal', BootstrapIcons.bullseye),
      ('Activity', BootstrapIcons.plus_square),
      ('Workout', BootstrapIcons.lightning_charge),
      ('Expense', BootstrapIcons.wallet2),
    ];

    return LifeOSCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Quick Actions'),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: actions
                .map(
                  (action) => FilledButton.tonalIcon(
                    onPressed: () {},
                    icon: Icon(action.$2),
                    label: Text(action.$1),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _CalendarPreview extends StatelessWidget {
  const _CalendarPreview({required this.activities});

  final List<ActivitySummary> activities;

  @override
  Widget build(BuildContext context) {
    return LifeOSCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Calendar Preview'),
          const SizedBox(height: 12),
          ...activities.take(3).map(
                (activity) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Icon(BootstrapIcons.clock, size: 18),
                      const SizedBox(width: 10),
                      Expanded(child: Text('${activity.time}  ${activity.title}')),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _InsightsCard extends StatelessWidget {
  const _InsightsCard({required this.insights});

  final List<InsightSummary> insights;

  @override
  Widget build(BuildContext context) {
    return LifeOSCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'AI Insights'),
          const SizedBox(height: 12),
          ...insights.map(
            (insight) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(insight.title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 5),
                  Text(insight.body),
                  const SizedBox(height: 8),
                  Text(insight.recommendedAction, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardLoading extends StatelessWidget {
  const _DashboardLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _DashboardError extends StatelessWidget {
  const _DashboardError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
