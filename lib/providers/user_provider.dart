import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User();

  User get getUser {
    return _user;
  }

  void nextLevel() {
    _user.currentLevel += 1;
    notifyListeners();
  }
}