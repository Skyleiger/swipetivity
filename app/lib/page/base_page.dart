import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/routing/routes.dart';
import 'package:swipetivity_app/localization/translations.g.dart';

class BasePage extends StatelessWidget {
  static final _routes = [
    _ChildRoute(
      route: const HomePageRoute().location,
      icon: Icons.home,
      label: (context) => context.translations.homePage.name,
    ),
    _ChildRoute(
      route: const CommunityListPageRoute().location,
      icon: Icons.group,
      label: (context) => context.translations.communityListPage.name,
    ),
    _ChildRoute(
      route: const SurveyListPageRoute().location,
      icon: Icons.thumb_up,
      label: (context) => context.translations.surveyListPage.name,
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

    List<NavigationDestination> destinations = _routes.map((route) {
      return route.toNavigationDestination(context);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Text(currentRoute.label(context)),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
    const SettingsPageRoute().push(context);
  }
}

class _ChildRoute {
  final String route;
  final IconData icon;
  final String Function(BuildContext context) label;

  const _ChildRoute({
    required this.route,
    required this.icon,
    required this.label,
  });

  NavigationDestination toNavigationDestination(BuildContext context) {
    return NavigationDestination(
      icon: Icon(icon),
      label: label(context),
    );
  }
}
