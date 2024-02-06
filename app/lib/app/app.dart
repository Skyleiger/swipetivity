import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/app/repository/auth_repository.dart';
import 'package:swipetivity_app/app/routing/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return _AppRepositoryProvider(
      child: _AppBlocProvider(
        child: _AppBlocListenerProvider(
          child: MaterialApp.router(
            routerConfig: Routing.router,
            title: "Swipetivity",
            theme: _getLightThemeData(),
            darkTheme: _getDarkThemeData(),
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }

  ThemeData _getLightThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.pink,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );
  }

  ThemeData _getDarkThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.pink,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}

class _AppRepositoryProvider extends StatelessWidget {
  final Widget child;

  const _AppRepositoryProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
      ],
      child: child,
    );
  }
}

class _AppBlocProvider extends StatelessWidget {
  final Widget child;

  const _AppBlocProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}

class _AppBlocListenerProvider extends StatelessWidget {
  final Widget child;

  const _AppBlocListenerProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (currentContext, state) {
            BuildContext context = Routing.routingKey.currentContext!;

            if (state is UnauthenticatedState) {
              AuthStartRoute().go(context);
            }
          },
        ),
      ],
      child: child,
    );
  }
}
