import 'package:flutter_modular/flutter_modular.dart';
import 'package:swipetivity_app/auth/auth_module.dart';
import 'package:swipetivity_app/page/dashboard_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector injector) {
    // TODO: implement binds
  }

  @override
  void routes(RouteManager routeManager) {
    // TODO: implement routes
    routeManager.wildcard(child: (context) => const DashboardPage());
    routeManager.child("/dashboard", child: (context) => const DashboardPage());
    routeManager.module("/auth", module: AuthModule());
  }
}
