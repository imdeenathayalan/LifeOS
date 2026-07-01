# LifeOS

LifeOS is a Flutter-first foundation for a premium AI Personal Operating System. It is built around a modular feature architecture, Riverpod state, Material 3 theming, Bootstrap Icons, and a Supabase-ready data layer.

## Current Slice

- Responsive app shell with bottom navigation and desktop drawer.
- Premium light and dark themes using Inter through Google Fonts.
- Dashboard with modular widgets for mission, AI briefing, goals, activities, calendar, productivity, fitness, nutrition, water, finance, progress, insights, and quick actions.
- Feature placeholders for Goals, Activities, Calendar, AI, Planner, Productivity, Health, Fitness, Nutrition, Finance, Analytics, Notifications, and Settings.
- Mock-first repository boundary designed to be replaced by Supabase queries without changing UI code.
- Supabase dashboard repository that reads authenticated, user-scoped `dashboard_snapshots` rows when configured.
- AI action confirmation pattern so the assistant never mutates user data silently.

## Run

Flutter is not installed in this environment, so this repo was authored directly. On a machine with Flutter stable installed:

```powershell
flutter pub get
flutter run -d chrome --dart-define=SUPABASE_URL=https://your-project.supabase.co --dart-define=SUPABASE_ANON_KEY=your-anon-key
```

The app includes your Supabase project URL and publishable key as development defaults. You can still override them with `--dart-define` for staging or production builds.

For a new Flutter checkout, generate platform folders once:

```powershell
flutter create . --platforms=android,ios,web
```

## Architecture

```text
lib/
  app/                  App bootstrap and router.
  core/
    config/             Supabase/env configuration.
    theme/              Material 3 design system.
    widgets/            Shared reusable UI.
  features/
    shell/              Navigation and adaptive layout.
    dashboard/          Domain models, providers, and dashboard UI.
    */presentation/     Feature screens.
```

## Supabase Direction

Apply the starter schema in `supabase/schema.sql`, then pass Supabase defines at run time. The current dashboard repository reads the latest authenticated snapshot and falls back to mock data when no user or snapshot exists.
