class SurveyException implements Exception {
  const SurveyException();
}

abstract class SurveyFoundException extends SurveyException {
  const SurveyFoundException();
}

class SurveyByIdNotFoundException extends SurveyException {
  final int id;

  const SurveyByIdNotFoundException({
    required this.id,
  });
}
