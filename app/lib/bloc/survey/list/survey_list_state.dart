part of 'survey_list_cubit.dart';

@MappableClass()
@immutable
abstract class SurveyListState {
  const SurveyListState();
}

@MappableClass()
@immutable
class SurveyListInitial extends SurveyListState with SurveyListInitialMappable {
  const SurveyListInitial();
}

@MappableClass()
@immutable
class SurveyListLoading extends SurveyListState with SurveyListLoadingMappable {
  const SurveyListLoading();
}

@MappableClass()
@immutable
class SurveyListLoaded extends SurveyListState with SurveyListLoadedMappable {
  final List<Survey> surveys;

  const SurveyListLoaded({required this.surveys});
}

@MappableClass()
@immutable
class SurveyListFailure extends SurveyListState with SurveyListFailureMappable {
  const SurveyListFailure();
}
