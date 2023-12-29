import 'package:flutter_modular/flutter_modular.dart';
import 'package:swipetivity_app/auth/page/auth_start_page.dart';
import 'package:swipetivity_app/auth/page/login_page.dart';
import 'package:swipetivity_app/auth/page/register_page.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager routeManager) {
    routeManager.wildcard(child: (context) => const AuthStartPage());
    routeManager.child("/", child: (context) => const AuthStartPage());
    routeManager.child("/start", child: (context) => const AuthStartPage());
    routeManager.child("/login",
        child: (context) => const LoginPage(),
        transition: TransitionType.downToUp);
    routeManager.child("/register",
        child: (context) => const RegisterPage(),
        transition: TransitionType.downToUp);
  }
}
