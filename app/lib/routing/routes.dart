import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/page/auth/login_page.dart';
import 'package:swipetivity_app/page/auth/register_page.dart';
import 'package:swipetivity_app/page/auth/start_page.dart';
import 'package:swipetivity_app/page/base_page.dart';
import 'package:swipetivity_app/page/communities_page.dart';
import 'package:swipetivity_app/page/error_page.dart';
import 'package:swipetivity_app/page/home_page.dart';
import 'package:swipetivity_app/page/settings_page.dart';
import 'package:swipetivity_app/page/surveys_page.dart';

part 'routes.g.dart';

/// Abstract GoRouteData class that should be used for all child routes inside a shell route.
/// It disables the transition for the child route.
@immutable
abstract class ShellChildRoute extends GoRouteData {
  const ShellChildRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: build(context, state));
  }
}

@immutable
class ErrorPageRoute extends GoRouteData {
  const ErrorPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ErrorPage(exception: state.error!);
  }
}

@TypedGoRoute<StartPageRoute>(path: "/auth/start")
@immutable
class StartPageRoute extends GoRouteData {
  const StartPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StartPage();
  }
}

@TypedGoRoute<LoginPageRoute>(path: "/auth/login")
@immutable
class LoginPageRoute extends GoRouteData {
  const LoginPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<RegisterPageRoute>(path: "/auth/register")
@immutable
class RegisterPageRoute extends GoRouteData {
  const RegisterPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterPage();
  }
}

@TypedShellRoute<_BaseRoute>(routes: [
  TypedGoRoute<HomePageRoute>(path: "/home"),
  TypedGoRoute<CommunitiesPageRoute>(path: "/communities"),
  TypedGoRoute<SurveysPageRoute>(path: "/surveys"),
])
@immutable
class _BaseRoute extends ShellRouteData {
  const _BaseRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return BasePage(
      state: state,
      child: navigator,
    );
  }
}

@immutable
class HomePageRoute extends ShellChildRoute {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@immutable
class CommunitiesPageRoute extends ShellChildRoute {
  const CommunitiesPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CommunitiesPage();
  }
}

@immutable
class SurveysPageRoute extends ShellChildRoute {
  const SurveysPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SurveysPage();
  }
}

@TypedGoRoute<SettingsPageRoute>(path: "/settings")
@immutable
class SettingsPageRoute extends GoRouteData {
  const SettingsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}
