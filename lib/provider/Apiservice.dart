import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ApiService {
  static const String baseUrl = 'https://test.gslstudent.lilacinfotech.com';

  Future<bool> loginUser(String email, String password) async {
    final String url = '${baseUrl}/api/lead/auth/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userField': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful login
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        Get.snackbar(
          "Login Success",
          "You have logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        // Handle login error
        Get.snackbar(
          "Login Failed",
          "Invalid email or password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      // Handle network or other errors
      Get.snackbar(
        "Error",
        "An error occurred while trying to login",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }
}
