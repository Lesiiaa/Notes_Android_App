import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';

class AuthService {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<bool> registerUser(String fullName, String email, String password) async {
    try {
      final user = {
        'fullName': fullName,
        'email': email,
        'password': password,
      };
      await dbHelper.createUser(user);
      return true;
    } catch (e) {
      print("Error during registration: $e");
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    final user = await dbHelper.getUser(email, password);
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);
      await prefs.setInt('userId', user['id'] as int);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');
  }
}
