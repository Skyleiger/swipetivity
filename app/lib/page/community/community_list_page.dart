import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/bloc/community/list/community_list_bloc.dart';
import 'package:swipetivity_app/localization/translations.g.dart';
import 'package:swipetivity_app/model/community.dart';
import 'package:swipetivity_app/routing/routes.dart';
import 'package:swipetivity_app/widget/card.dart';
import 'package:swipetivity_app/widget/section.dart';

class CommunityListPage extends StatelessWidget {
  const CommunityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CommunityListBloc(
          authBloc: context.read(),
          repository: context.read(),
        );
      },
      child: BlocBuilder<CommunityListBloc, CommunityListState>(
        builder: (context, state) {
          Widget child;

          if (state.status == CommunityListStatus.loading) {
            return const _LoadingView();
          } else if (state.status == CommunityListStatus.success) {
            child = _LoadedView(communities: state.communities);
          } else {
            child = const _ErrorView();
          }

          return RefreshIndicator(
            child: child,
            onRefresh: () async {
              CommunityListBloc bloc = context.read<CommunityListBloc>()
                ..add(const CommunityListRefreshEvent());

              await bloc.stream.first;
            },
          );
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final List<Community> communities;

  const _LoadedView({required this.communities});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Section(
            title: context.translations.communityListPage.general.title,
            children: const [_CreateCommunityCard(), _JoinCommunityCard()],
          ),
          Section(
            title: context.translations.communityListPage.communities.title,
            children: [
              for (var community in communities)
                _CommunityCard(community: community)
            ],
          )
        ],
      ),
    );
  }
}

class _CreateCommunityCard extends StatelessWidget {
  const _CreateCommunityCard();

  @override
  Widget build(BuildContext context) {
    var translations =
        context.translations.communityListPage.general.createButton;

    return AppCard(
      onTap: (context) {},
      defaultPadding: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListTile(
          trailing: const Icon(Icons.add),
          title: Text(translations.title),
          subtitle: Text(translations.subtitle),
        ),
      ),
    );
  }
}

class _JoinCommunityCard extends StatelessWidget {
  const _JoinCommunityCard();

  @override
  Widget build(BuildContext context) {
    var translations =
        context.translations.communityListPage.general.joinButton;

    return AppCard(
      onTap: _onCardClick,
      defaultPadding: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListTile(
          trailing: const Icon(Icons.group_add),
          title: Text(translations.title),
          subtitle: Text(translations.subtitle),
        ),
      ),
    );
  }

  void _onCardClick(BuildContext context) {
    const CommunityJoinSheetRoute().push(context);
  }
}

class _CommunityCard extends StatelessWidget {
  final Community community;

  const _CommunityCard({required this.community});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: (context) {},
      defaultPadding: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListTile(
          trailing: const Icon(Icons.group),
          title: Text(community.name),
          subtitle: Text(
              "${community.members.length} Mitglieder - 3 offene Umfragen"),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.translations.communityListPage.error.text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
