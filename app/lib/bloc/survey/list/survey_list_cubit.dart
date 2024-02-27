import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipetivity_app/bloc/auth/auth_bloc.dart';
import 'package:swipetivity_app/model/survey.dart';
import 'package:swipetivity_app/repository/survey_repository.dart';

part 'survey_list_cubit.mapper.dart';

part 'survey_list_state.dart';

class SurveyListCubit extends Cubit<SurveyListState> {
  final AuthBloc authBloc;
  final SurveyRepository repository;

  SurveyListCubit({
    required this.authBloc,
    required this.repository,
  }) : super(const SurveyListInitial()) {
    loadSurveys();
  }

  Future<void> loadSurveys() async {
    emit(const SurveyListLoading());
    return refreshSurveys();
  }

  Future<void> refreshSurveys() async {
    return repository.fetchSurveys(authBloc.account!).then((surveys) {
      if (isClosed) {
        return;
      }

      emitIgnoreClosed(SurveyListLoaded(surveys: surveys));
    }).catchError((error) {
      emitIgnoreClosed(const SurveyListFailure());
    });
  }

  void emitIgnoreClosed(SurveyListState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
