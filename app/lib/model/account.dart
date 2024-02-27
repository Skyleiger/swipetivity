import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/model/user.dart';

part 'account.mapper.dart';

@MappableClass()
@immutable
class Account extends User with AccountMappable {
  final String emailAddress;
  final String password;
  final String firstName;
  final String lastName;

  const Account({
    required super.id,
    required super.username,
    required this.emailAddress,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}
