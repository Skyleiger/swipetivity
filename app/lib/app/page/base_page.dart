import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/app/routing/routes.dart';

class BasePage extends StatelessWidget {
  static final _routes = [
    _ChildRoute(
      route: const HomeRoute().location,
      icon: Icons.home,
      label: "Home",
    ),
    _ChildRoute(
      route: const CommunitiesRoute().location,
      icon: Icons.group,
      label: "Communities",
    ),
    _ChildRoute(
      route: const SurveysRoute().location,
      icon: Icons.thumb_up,
      label: "Umfragen",
    ),
  ];

  final GoRouterState state;
  final Widget child;

  const BasePage({
    super.key,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    _ChildRoute currentRoute =
        _routes.firstWhere((element) => element.route == state.matchedLocation);

    List<NavigationDestination> destinations =
        _routes.map((route) => route.toNavigationDestination()).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(currentRoute.label),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () => _onProfileButtonPressed(context),
              icon: const Icon(Icons.person),
            ),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _routes.indexOf(currentRoute),
        onDestinationSelected: (index) =>
            _onDestinationSelected(context, index),
        destinations: destinations,
      ),
      body: child,
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    context.go(_routes.elementAt(index).route);
  }

  void _onProfileButtonPressed(BuildContext context) {
    SettingsRoute().push(context);
  }
}

class _ChildRoute {
  final String route;
  final IconData icon;
  final String label;

  const _ChildRoute({
    required this.route,
    required this.icon,
    required this.label,
  });

  NavigationDestination toNavigationDestination() {
    return NavigationDestination(
      icon: Icon(icon),
      label: label,
    );
  }
}
