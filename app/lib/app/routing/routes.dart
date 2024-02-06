import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/app/page/auth/login_page.dart';
import 'package:swipetivity_app/app/page/auth/register_page.dart';
import 'package:swipetivity_app/app/page/auth/start_page.dart';
import 'package:swipetivity_app/app/page/dashboard_page.dart';
import 'package:swipetivity_app/app/page/error_page.dart';
import 'package:swipetivity_app/app/page/settings_page.dart';

part 'routes.g.dart';

class Routing {
  static final routingKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    routes: $appRoutes,
    initialLocation: DashboardRoute().location,
    redirect: _checkAuthentication,
    redirectLimit: 5,
    onException: (context, state, router) => ErrorRoute().go(context),
    navigatorKey: routingKey,
    debugLogDiagnostics: kDebugMode,
  );

  static String? _checkAuthentication(
      BuildContext context, GoRouterState state) {
    AuthBloc authBloc = context.read<AuthBloc>();

    if (authBloc.state is UnauthenticatedState &&
        !state.matchedLocation.startsWith("/auth")) {
      return AuthStartRoute().location;
    }

    return null;
  }
}

@TypedGoRoute<ErrorRoute>(path: "/error", name: "Error")
@immutable
class ErrorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ErrorPage(exception: state.error!);
  }
}

@TypedGoRoute<DashboardRoute>(path: "/", name: "Dashboard")
@immutable
class DashboardRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardPage();
  }
}

@TypedGoRoute<SettingsRoute>(path: "/settings", name: "Settings")
@immutable
class SettingsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@TypedGoRoute<AuthStartRoute>(path: "/auth/start", name: "AuthStart")
@immutable
class AuthStartRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StartPage();
  }
}

@TypedGoRoute<AuthLoginRoute>(path: "/auth/login", name: "Login")
@immutable
class AuthLoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<AuthRegisterRoute>(path: "/auth/register", name: "Register")
@immutable
class AuthRegisterRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterPage();
  }
}
