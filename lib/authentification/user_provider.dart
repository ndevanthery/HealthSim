import 'package:flutter/foundation.dart';

class User {
  final String email;
  final String password;
  final String id;

  User(this.email, this.password, this.id);
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
