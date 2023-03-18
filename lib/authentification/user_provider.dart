import 'package:flutter/foundation.dart';

class User {
  final String email;
  final String password;

  User(this.email, this.password);
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
