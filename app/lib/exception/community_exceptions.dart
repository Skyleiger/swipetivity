import 'package:swipetivity_app/model/community.dart';
import 'package:swipetivity_app/model/user.dart';

class CommunityException implements Exception {
  const CommunityException();
}

class CommunityNotFoundException extends CommunityException {
  final String message;

  CommunityNotFoundException(this.message);
}

class CommunityByPinNotFoundException extends CommunityException {
  final String pin;

  const CommunityByPinNotFoundException({
    required this.pin,
  });
}

class UserAlreadyInCommunityException extends CommunityException {
  final Community community;
  final User user;

  const UserAlreadyInCommunityException({
    required this.community,
    required this.user,
  });
}

class UserNotInCommunityException extends CommunityException {
  final Community community;
  final User user;

  const UserNotInCommunityException({
    required this.community,
    required this.user,
  });
}
