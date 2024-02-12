import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/routing/routes.dart';

class Routing {
  static final routingKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    routes: $appRoutes,
    initialLocation: const HomePageRoute().location,
    redirect: _checkAuthentication,
    redirectLimit: 5,
    onException: (context, state, router) =>
        const ErrorPageRoute().build(context, state),
    navigatorKey: routingKey,
    debugLogDiagnostics: kDebugMode,
  );

  static String? _checkAuthentication(
      BuildContext context, GoRouterState state) {
    AuthBloc authBloc = context.read<AuthBloc>();

    if (authBloc.state is UnauthenticatedState &&
        !state.matchedLocation.startsWith("/auth")) {
      return const StartPageRoute().location;
    }

    return null;
  }
}
