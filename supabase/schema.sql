create table if not exists public.dashboard_snapshots (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  snapshot_date date not null default current_date,
  mission text not null,
  ai_briefing text not null,
  goals jsonb not null default '[]'::jsonb,
  activities jsonb not null default '[]'::jsonb,
  metrics jsonb not null default '[]'::jsonb,
  insights jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

alter table public.dashboard_snapshots enable row level security;

create policy "Users can read their dashboard snapshots"
on public.dashboard_snapshots
for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can insert their dashboard snapshots"
on public.dashboard_snapshots
for insert
to authenticated
with check (auth.uid() = user_id);

create policy "Users can update their dashboard snapshots"
on public.dashboard_snapshots
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create index if not exists dashboard_snapshots_user_date_idx
on public.dashboard_snapshots(user_id, snapshot_date desc);
