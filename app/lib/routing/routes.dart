import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/page/auth/login_page.dart';
import 'package:swipetivity_app/page/auth/register_page.dart';
import 'package:swipetivity_app/page/auth/start_page.dart';
import 'package:swipetivity_app/page/base_page.dart';
import 'package:swipetivity_app/page/community/community_list_page.dart';
import 'package:swipetivity_app/page/error_page.dart';
import 'package:swipetivity_app/page/home_page.dart';
import 'package:swipetivity_app/page/settings_page.dart';
import 'package:swipetivity_app/page/survey/survey_list_page.dart';
import 'package:swipetivity_app/routing/route_components.dart';
import 'package:swipetivity_app/sheet/community/community_join_sheet.dart';

part 'routes.g.dart';

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
  TypedGoRoute<CommunityListPageRoute>(path: "/community/list"),
  TypedGoRoute<SurveyListPageRoute>(path: "/survey/list"),
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
class CommunityListPageRoute extends ShellChildRoute {
  const CommunityListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CommunityListPage();
  }
}

@TypedGoRoute<CommunityJoinSheetRoute>(path: "/community/join")
@immutable
class CommunityJoinSheetRoute extends BottomSheetRoute {
  const CommunityJoinSheetRoute() : super(isScrollControlled: true);

  @override
  Widget buildSheet(BuildContext context, GoRouterState state) {
    return const CommunityJoinSheet();
  }
}

@immutable
class SurveyListPageRoute extends ShellChildRoute {
  const SurveyListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SurveyListPage();
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
