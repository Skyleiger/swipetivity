import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swipetivity_app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/localization/translations.g.dart';
import 'package:swipetivity_app/repository/auth_repository.dart';
import 'package:swipetivity_app/routing/routes.dart';
import 'package:swipetivity_app/routing/routing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  runApp(
    TranslationProvider(
      child: const _AppRepositoryProvider(
        child: _AppBlocProvider(
          child: _AppBlocListenerProvider(
            child: _App(),
          ),
        ),
      ),
    ),
  );
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
              const StartPageRoute().go(context);
            } else if (state is AuthenticatedState) {
              const HomePageRoute().go(context);
            }
          },
        ),
      ],
      child: child,
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routing.router,
      onGenerateTitle: (context) => context.translations.app.title,
      theme: _getLightThemeData(),
      darkTheme: _getDarkThemeData(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
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
