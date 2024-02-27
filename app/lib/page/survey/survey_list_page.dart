import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/bloc/survey/list/survey_list_cubit.dart';
import 'package:swipetivity_app/localization/translations.g.dart';
import 'package:swipetivity_app/model/survey.dart';
import 'package:swipetivity_app/widget/card.dart';
import 'package:swipetivity_app/widget/section.dart';

class SurveyListPage extends StatelessWidget {
  const SurveyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SurveyListCubit(
          authBloc: context.read(),
          repository: context.read(),
        );
      },
      child: BlocBuilder<SurveyListCubit, SurveyListState>(
        builder: (context, state) {
          Widget child;

          if (state is SurveyListLoading) {
            return const _LoadingView();
          } else if (state is SurveyListLoaded) {
            child = _LoadedView(surveys: state.surveys);
          } else {
            child = const _ErrorView();
          }

          return RefreshIndicator(
            child: child,
            onRefresh: () => context.read<SurveyListCubit>().refreshSurveys(),
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
  final List<Survey> surveys;

  const _LoadedView({required this.surveys});

  @override
  Widget build(BuildContext context) {
    var translations = context.translations.surveyListPage;

    List<Survey> openSurveys =
        surveys.where((element) => element.result == null).toList();

    List<Survey> finishedSurveys =
        surveys.where((element) => element.result != null).toList();

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Section(
            title: translations.openSurveys.title,
            children: [
              for (var survey in openSurveys) _OpenSurveyCard(survey: survey)
            ],
          ),
          Section(
            title: translations.finishedSurveys.title,
            children: [
              for (var survey in finishedSurveys)
                _FinishedSurveyCard(survey: survey)
            ],
          ),
          Section(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
                child: Text(
                  translations.more.informationText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _OpenSurveyCard extends StatelessWidget {
  final Survey survey;

  const _OpenSurveyCard({required this.survey});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: (context) {},
      defaultPadding: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListTile(
          trailing: const Icon(Icons.thumb_up),
          title: Text(survey.name),
          subtitle: Text(survey.description),
        ),
      ),
    );
  }
}

class _FinishedSurveyCard extends StatelessWidget {
  final Survey survey;

  const _FinishedSurveyCard({required this.survey});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: (context) {},
      defaultPadding: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListTile(
          leading: const Icon(Icons.thumbs_up_down),
          title: Text(
            survey.name,
            textAlign: TextAlign.end,
          ),
          subtitle: Text(
            survey.description,
            textAlign: TextAlign.end,
          ),
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
        context.translations.surveyListPage.error.text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
