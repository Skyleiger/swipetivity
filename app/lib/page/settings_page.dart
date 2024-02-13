import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/helpers.dart';
import 'package:swipetivity_app/localization/translations.g.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translations.settingsPage.name),
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
      platform: DevicePlatform.android,
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
    var translations = context.translations.settingsPage.section.title;

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
                    : translations.unknownFirstName;

                return Text(
                  translations.title(firstName: firstName),
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
                    : translations.unknownUsername;

                return Text(
                  translations.subtitle(username: username),
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
    var translations = context.translations.settingsPage.section.account;

    return SettingsSection(
      title: Text(translations.name),
      tiles: [
        SettingsTile(
            title: Text(translations.profileButton),
            leading: const Icon(Icons.person),
            onPressed: _onProfileButtonPressed),
        SettingsTile(
          title: Text(translations.logout.button),
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
      title: context
          .translations.settingsPage.section.account.logout.confirmDialog.title,
      description: context.translations.settingsPage.section.account.logout
          .confirmDialog.description,
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
    var translations = context.translations.settingsPage.section.design;

    return SettingsSection(
      title: Text(translations.name),
      tiles: [
        SettingsTile.navigation(
          leading: const Icon(Icons.language),
          title: Text(translations.language.button),
          value: Text(context.translations.general
              .locale(locale: LocaleSettings.currentLocale)),
          onPressed: _onLanguageButtonPressed,
        ),
        SettingsTile(
          leading: const Icon(Icons.color_lens),
          title: Text(translations.theme.button),
          value: Text(translations.theme.system),
          onPressed: _onThemeButtonPressed,
        )
      ],
    );
  }

  void _onLanguageButtonPressed(BuildContext context) {
    var translations =
        context.translations.settingsPage.section.design.language;

    List<RadioListTile<AppLocale>> localeTiles = AppLocale.values.map((locale) {
      return RadioListTile(
        title: Text(context.translations.general.locale(locale: locale)),
        value: locale,
        groupValue: LocaleSettings.currentLocale,
        onChanged: (value) {
          LocaleSettings.setLocale(value!);
          context.pop();
        },
      );
    }).toList();

    AlertDialog dialog = AlertDialog(
      title: Text(translations.chooseDialog.title),
      contentPadding: const EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: localeTiles,
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
    var translations = context.translations.settingsPage.section.more;

    return SettingsSection(
      title: Text(translations.name),
      tiles: [
        SettingsTile(
          title: Text(translations.privacyButton),
          leading: const Icon(Icons.privacy_tip),
          onPressed: _onPrivacyButtonPressed,
        ),
        SettingsTile(
          title: Text(translations.imprintButton),
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
