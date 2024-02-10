import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/app/helpers.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Einstellungen"),
      ),
      body: const _SettingsList(),
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList();

  @override
  Widget build(BuildContext context) {
    return const SettingsList(
      sections: [
        _TitleSettingsSection(),
        _AccountSettingsSection(),
        _DesignSettingsSection(),
        _MoreSettingsSection()
      ],
    );
  }
}

class _TitleSettingsSection extends AbstractSettingsSection {
  const _TitleSettingsSection();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return CustomSettingsSection(
      child: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.height * 0.4,
              height: size.width * 0.3,
              child: const FittedBox(
                child: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                String firstName = state is AuthenticatedState
                    ? state.account.firstName
                    : "Unbekannt";

                return Text(
                  "Hallo, $firstName",
                  style: themeData.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                );
              },
            ),
            SizedBox(
              height: size.height * 0.010,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                String username = state is AuthenticatedState
                    ? state.account.username
                    : "Unbekannt";

                return Text(
                  "@$username",
                  style: themeData.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountSettingsSection extends AbstractSettingsSection {
  const _AccountSettingsSection();

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: const Text("Account"),
      tiles: [
        SettingsTile(
            title: const Text("Profil"),
            leading: const Icon(Icons.person),
            onPressed: _onProfileButtonPressed),
        SettingsTile(
          title: const Text("Abmelden"),
          leading: const Icon(Icons.logout),
          onPressed: _onLogoutButtonPressed,
        ),
      ],
    );
  }

  void _onProfileButtonPressed(BuildContext context) {
    showNotImplementedDialog(context: context);
  }

  void _onLogoutButtonPressed(BuildContext context) {
    showConfirmDialog(
      context: context,
      title: "Ausloggen",
      description: "Möchtest du dich wirklich ausloggen?",
      confirmButtonAction: () {
        context.pop();
        context.read<AuthBloc>().add(const UnauthenticatedEvent());
      },
    );
  }
}

class _DesignSettingsSection extends AbstractSettingsSection {
  const _DesignSettingsSection();

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: const Text("Gestaltung"),
      tiles: [
        SettingsTile.navigation(
          leading: const Icon(Icons.language),
          title: const Text("Sprache"),
          value: const Text("Deutsch"),
          onPressed: _onLanguageButtonPressed,
        ),
        SettingsTile(
          leading: const Icon(Icons.color_lens),
          title: const Text("Theme"),
          value: const Text("Wie System"),
          onPressed: _onThemeButtonPressed,
        )
      ],
    );
  }

  void _onLanguageButtonPressed(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: const Text("Sprache wählen"),
      contentPadding: const EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: const Text("Deutsch"),
            value: "Deutsch",
            groupValue: "",
            onChanged: (value) => context.pop(),
          ),
          RadioListTile(
            title: const Text("Englisch"),
            value: "Englisch",
            groupValue: "",
            onChanged: (value) => context.pop(),
          )
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  void _onThemeButtonPressed(BuildContext context) {
    showNotImplementedDialog(context: context);
  }
}

class _MoreSettingsSection extends AbstractSettingsSection {
  const _MoreSettingsSection();

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: const Text("Weiteres"),
      tiles: [
        SettingsTile(
          title: const Text("Datenschutz"),
          leading: const Icon(Icons.privacy_tip),
          onPressed: _onPrivacyButtonPressed,
        ),
        SettingsTile(
          title: const Text("Impressum"),
          leading: const Icon(Icons.info),
          onPressed: _onImprintButtonPressed,
        ),
      ],
    );
  }

  void _onPrivacyButtonPressed(BuildContext context) {
    showNotImplementedDialog(context: context);
  }

  void _onImprintButtonPressed(BuildContext context) {
    showNotImplementedDialog(context: context);
  }
}
