import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userTokenKey = 'user_token';


  Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTokenKey, token);
  }


  Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTokenKey);
  }


  // Clear All User Data
  Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userTokenKey);
  }

}
