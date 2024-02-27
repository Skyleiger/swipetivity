import 'package:swipetivity_app/exception/survey_exceptions.dart';
import 'package:swipetivity_app/model/item_type.dart';
import 'package:swipetivity_app/model/survey.dart';
import 'package:swipetivity_app/model/survey_result.dart';
import 'package:swipetivity_app/model/user.dart';

class SurveyRepository {
  final List<Survey> surveys = const [
    Survey(
      id: 1,
      name: "Aktivitäten für Samstag Abend",
      description: "Bowlen, Golfen oder Kino? Was machen wir am Samstag?",
      itemType: ItemType(
        id: 1,
        name: 'Test Item Type',
        description: 'Test Description',
      ),
    ),
    Survey(
      id: 2,
      name: "Firmenausflug",
      description: "Wir suchen eine Aktivität für unseren Firmenausflug",
      itemType: ItemType(
        id: 2,
        name: 'Test Item Type 2',
        description: 'Test Description 2',
      ),
    ),
    Survey(
      id: 3,
      name: "Kinoabend",
      description: "Filmsuche",
      itemType: ItemType(
        id: 3,
        name: 'Test Item Type 3',
      ),
    ),
    Survey(
      id: 4,
      name: "Umfrage 4",
      description: "Beschreibung für Umfrage 4",
      itemType: ItemType(
        id: 4,
        name: 'Test Item Type 4',
      ),
      result: SurveyResult(
        id: 1,
      ),
    ),
    Survey(
      id: 5,
      name: "Umfrage 5",
      description: "Beschreibung für Umfrage 5",
      itemType: ItemType(
        id: 5,
        name: 'Test Item Type 5',
      ),
      result: SurveyResult(
        id: 1,
      ),
    ),
    Survey(
      id: 6,
      name: "Umfrage 6",
      description: "Beschreibung für Umfrage 6",
      itemType: ItemType(
        id: 6,
        name: 'Test Item Type 6',
      ),
      result: SurveyResult(
        id: 1,
      ),
    ),
    Survey(
      id: 7,
      name: "Umfrage 7",
      description: "Beschreibung für Umfrage 7",
      itemType: ItemType(
        id: 7,
        name: 'Test Item Type 7',
      ),
      result: SurveyResult(
        id: 1,
      ),
    ),
    Survey(
      id: 8,
      name: "Umfrage 8",
      description: "Beschreibung für Umfrage 8",
      itemType: ItemType(
        id: 8,
        name: 'Test Item Type 8',
      ),
      result: SurveyResult(
        id: 1,
      ),
    ),
    Survey(
      id: 9,
      name: "Umfrage 9",
      description: "Beschreibung für Umfrage 9",
      itemType: ItemType(
        id: 9,
        name: 'Test Item Type 9',
      ),
      result: SurveyResult(
        id: 1,
      ),
    ),
  ];

  Future<List<Survey>> fetchSurveys(User user) {
    return Future.delayed(const Duration(seconds: 1), () => surveys);
  }

  Future<Survey> fetchSurvey(int id) {
    return Future.delayed(const Duration(seconds: 1), () {
      return surveys.firstWhere((survey) {
        return survey.id == id;
      }, orElse: () {
        throw SurveyByIdNotFoundException(id: id);
      });
    });
  }
}
