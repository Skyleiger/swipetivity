import 'dart:math';

import 'package:swipetivity_app/model/account.dart';

const Account baseAccount = Account(
  id: 1,
  emailAddress: "abc@example.com",
  password: "test123",
  firstName: "Dominic",
  lastName: "Wienzek",
  username: "dxmiixx",
);

class AuthRepository {
  Account? _account;

  Account? get account {
    return _account;
  }

  Future<Account> login(String emailAddress, String password) async {
    return Future.delayed(const Duration(seconds: 1), () {
      if (Random().nextBool()) {
        _account = baseAccount;
        return _account!;
      } else {
        throw Exception("Invalid credentials");
      }
    });
  }

  void logout() {
    _account = null;
  }

  bool isAuthenticated() {
    return _account != null;
  }
}
