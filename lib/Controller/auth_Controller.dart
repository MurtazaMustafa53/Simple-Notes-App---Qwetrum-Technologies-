// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('Username', name.trim());
      await prefs.setString('email', email.trim());
      await prefs.setString('password', password.trim());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> LoginUser({
    required String email,
    required String password,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? storedEmail = prefs.getString('email');
      String? storedPassword = prefs.getString('password');

      if (email.trim() == storedEmail && password.trim() == storedPassword) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
