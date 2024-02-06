import 'package:flutter/material.dart';
import 'package:swipetivity_app/app/routing/routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
        indicatorColor: Theme.of(context).primaryColor,
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.thumb_up),
            label: "Umfragen",
          ),
          NavigationDestination(
            icon: Icon(Icons.group),
            label: "Communities",
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'DashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _onProfileButtonPressed(BuildContext context) {
    SettingsRoute().push(context);
  }
}
