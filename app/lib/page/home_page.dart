import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/localization/translations.g.dart';
import 'package:swipetivity_app/routing/routes.dart';
import 'package:swipetivity_app/widget/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _Title(),
            SizedBox(height: 50),
            _OpenSurveysCard(),
            SizedBox(height: 20),
            _NavigationCard(),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    var translations = context.translations.homePage.greeting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          translations.firstLine,
          style: themeData.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          String firstName =
              state is AuthenticatedState ? state.account.firstName : "";

          return Text(
            translations.secondLine(firstName: firstName),
            style: themeData.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ],
    );
  }
}

class _OpenSurveysCard extends StatelessWidget {
  const _OpenSurveysCard();

  @override
  Widget build(BuildContext context) {
    var translations = context.translations.homePage.openSurveysCard;

    return AppCard(
      onTap: _onCardTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translations.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  translations.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  translations.counter(surveysCount: 5),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          const Icon(
            size: 50,
            Icons.thumb_up,
          ),
        ],
      ),
    );
  }

  void _onCardTap(BuildContext context) {
    const SurveyListPageRoute().go(context);
  }
}

class _NavigationCard extends StatelessWidget {
  const _NavigationCard();

  @override
  Widget build(BuildContext context) {
    var translations = context.translations.homePage.navigationCard;

    return AppButtonCard(
      buttons: [
        CardButton(
          title: translations.surveysButton,
          icon: Icons.thumb_up,
          onTap: _onSurveysButtonTap,
        ),
        CardButton(
          title: translations.communitiesButton,
          icon: Icons.group,
          onTap: _onCommunitiesButtonTap,
        ),
        CardButton(
          title: translations.profileButton,
          icon: Icons.person,
          onTap: _onProfileButtonTap,
        ),
        CardButton(
          title: translations.logoutButton,
          icon: Icons.logout,
          onTap: _onLogoutButtonTap,
        ),
      ],
    );
  }

  void _onSurveysButtonTap(BuildContext context) {
    const SurveyListPageRoute().go(context);
  }

  void _onCommunitiesButtonTap(BuildContext context) {
    const CommunityListPageRoute().go(context);
  }

  void _onProfileButtonTap(BuildContext context) {
    const SettingsPageRoute().push(context);
  }

  void _onLogoutButtonTap(BuildContext context) {
    context.read<AuthBloc>().add(const UnauthenticatedEvent());
  }
}
