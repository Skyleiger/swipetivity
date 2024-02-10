import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/app/page/auth/login_page.dart';
import 'package:swipetivity_app/app/page/auth/register_page.dart';
import 'package:swipetivity_app/app/page/auth/start_page.dart';
import 'package:swipetivity_app/app/page/base_page.dart';
import 'package:swipetivity_app/app/page/communities_page.dart';
import 'package:swipetivity_app/app/page/error_page.dart';
import 'package:swipetivity_app/app/page/home_page.dart';
import 'package:swipetivity_app/app/page/settings_page.dart';
import 'package:swipetivity_app/app/page/surveys_page.dart';

part 'routes.g.dart';

class Routing {
  static final routingKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    routes: $appRoutes,
    initialLocation: HomeRoute().location,
    redirect: _checkAuthentication,
    redirectLimit: 5,
    onException: (context, state, router) => ErrorRoute().build(context, state),
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

@immutable
class ErrorRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ErrorPage(exception: state.error!);
  }
}

@TypedShellRoute<BaseRoute>(routes: [
  TypedGoRoute<HomeRoute>(path: "/home", name: "Home"),
  TypedGoRoute<CommunitiesRoute>(path: "/communities", name: "Communities"),
  TypedGoRoute<SurveysRoute>(path: "/surveys", name: "Surveys"),
])
@immutable
class BaseRoute extends ShellRouteData {
  static final GlobalKey<NavigatorState> $navigatorKey =
      Routing.shellNavigatorKey;

  const BaseRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return BasePage(
      state: state,
      child: navigator,
    );
  }
}

@immutable
class HomeRoute extends ShellChildRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@immutable
class CommunitiesRoute extends ShellChildRoute {
  const CommunitiesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CommunitiesPage();
  }
}

@immutable
class SurveysRoute extends ShellChildRoute {
  const SurveysRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SurveysPage();
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

abstract class ShellChildRoute extends GoRouteData {
  const ShellChildRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: build(context, state));
  }
}
