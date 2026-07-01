import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LifeOSShell extends StatelessWidget {
  const LifeOSShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final width = MediaQuery.sizeOf(context).width;
    final useDrawerRail = width >= 920;

    return Scaffold(
      body: Row(
        children: [
          if (useDrawerRail) _LifeOSDrawer(currentPath: location),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: useDrawerRail
          ? null
          : NavigationBar(
              selectedIndex: _bottomIndex(location),
              onDestinationSelected: (index) => context.go(_bottomItems[index].path),
              destinations: _bottomItems
                  .map(
                    (item) => NavigationDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.selectedIcon),
                      label: item.label,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _LifeOSDrawer extends StatelessWidget {
  const _LifeOSDrawer({required this.currentPath});

  final String currentPath;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return NavigationDrawer(
      selectedIndex: _selectedDrawerIndex(currentPath),
      onDestinationSelected: (index) => context.go(_drawerItems[index].path),
      backgroundColor: scheme.surface,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 18),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(BootstrapIcons.grid_1x2_fill, color: scheme.onPrimary),
              ),
              const SizedBox(width: 12),
              Text(
                'LifeOS',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ),
        ..._drawerItems.map(
          (item) => NavigationDrawerDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon),
            label: Text(item.label),
          ),
        ),
      ],
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.path,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final String path;
  final IconData icon;
  final IconData selectedIcon;
}

const _bottomItems = [
  _NavItem(label: 'Dashboard', path: '/', icon: BootstrapIcons.house, selectedIcon: BootstrapIcons.house_fill),
  _NavItem(label: 'Goals', path: '/goals', icon: BootstrapIcons.bullseye, selectedIcon: BootstrapIcons.bullseye),
  _NavItem(label: 'Activities', path: '/activities', icon: BootstrapIcons.activity, selectedIcon: BootstrapIcons.activity),
  _NavItem(label: 'Calendar', path: '/calendar', icon: BootstrapIcons.calendar3, selectedIcon: BootstrapIcons.calendar3),
  _NavItem(label: 'AI', path: '/ai', icon: BootstrapIcons.robot, selectedIcon: BootstrapIcons.robot),
];

const _drawerItems = [
  ..._bottomItems,
  _NavItem(label: 'Planner', path: '/planner', icon: BootstrapIcons.calendar_week, selectedIcon: BootstrapIcons.calendar_week_fill),
  _NavItem(label: 'Productivity', path: '/productivity', icon: BootstrapIcons.check2_square, selectedIcon: BootstrapIcons.check2_square),
  _NavItem(label: 'Health', path: '/health', icon: BootstrapIcons.heart_pulse, selectedIcon: BootstrapIcons.heart_pulse_fill),
  _NavItem(label: 'Fitness', path: '/fitness', icon: BootstrapIcons.lightning_charge, selectedIcon: BootstrapIcons.lightning_charge_fill),
  _NavItem(label: 'Nutrition', path: '/nutrition', icon: BootstrapIcons.egg_fried, selectedIcon: BootstrapIcons.egg_fried),
  _NavItem(label: 'Finance', path: '/finance', icon: BootstrapIcons.wallet2, selectedIcon: BootstrapIcons.wallet2),
  _NavItem(label: 'Analytics', path: '/analytics', icon: BootstrapIcons.graph_up, selectedIcon: BootstrapIcons.graph_up),
  _NavItem(label: 'Notifications', path: '/notifications', icon: BootstrapIcons.bell, selectedIcon: BootstrapIcons.bell_fill),
  _NavItem(label: 'Settings', path: '/settings', icon: BootstrapIcons.gear, selectedIcon: BootstrapIcons.gear_fill),
];

int _bottomIndex(String location) {
  final index = _bottomItems.indexWhere((item) => item.path == location);
  return index == -1 ? 0 : index;
}

int? _selectedDrawerIndex(String location) {
  final index = _drawerItems.indexWhere((item) => item.path == location);
  return index == -1 ? null : index;
}
