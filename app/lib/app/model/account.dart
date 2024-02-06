import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:swipetivity_app/app/model/base_model.dart';

part 'account.mapper.dart';

@MappableClass()
@immutable
class Account extends BaseModel with AccountMappable {
  final String emailAddress;
  final String password;
  final String firstName;
  final String lastName;
  final String username;

  const Account({
    required super.id,
    required this.emailAddress,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.username,
  });
}
