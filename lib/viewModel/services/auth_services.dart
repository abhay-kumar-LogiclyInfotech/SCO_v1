import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _counterKey = 'counter';


  // Save User Authentication State
  Future<void> saveAuthState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  // Check User Authentication State
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Clear All User Data
  Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
  }



  // Increment the counter
  Future<void> incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCounter = prefs.getInt(_counterKey) ?? 0;
    currentCounter++;
    await prefs.setInt(_counterKey, currentCounter);
  }

  // Decrement the counter
  Future<void> decrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCounter = prefs.getInt(_counterKey) ?? 0;
    currentCounter--;
    await prefs.setInt(_counterKey, currentCounter);
  }

  // Retrieve the counter
  Future<int> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_counterKey) ?? 0;
  }

  // Clear the counter
  Future<void> clearCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_counterKey);
  }
}
